Return-Path: <joey@joescan.com>
Received: from exprod7og119.obsmtp.com (exprod7og119.obsmtp.com [64.18.2.16])
 by ozlabs.org (Postfix) with SMTP id E4575104792
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 05:43:56 +1100 (EST)
Received: by vcbfk13 with SMTP id fk13so4210030vcb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2012 10:43:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL_WD7iJceKMOX9dWDM-SuiO5a_M-3Kp4FnZqS+AuEKvphq_-w@mail.gmail.com>
References: <CAL_WD7hYZoaB87vZzj4Fk9nsHYSoe+qWq87g72ERLAkMur5vYg@mail.gmail.com>
 <CAL_WD7iJceKMOX9dWDM-SuiO5a_M-3Kp4FnZqS+AuEKvphq_-w@mail.gmail.com>
Date: Thu, 2 Feb 2012 10:43:52 -0800
Message-ID: <CAL_WD7hkuhi4D2CPuoLyG2-7w8JmSQDnxiYbqKxzGNep5ONsrg@mail.gmail.com>
Subject: Re: MPC5200B FEC TX packets getting stuck
From: Joey Nelson <joey@joescan.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I ran my test overnight with the TX irq time-stamping and finally got
one delayed packet. Based on the time-stamp data the packets are
getting stuck in the FEC TX FIFO.

The calls to the xmit function are spaced our on about 150 us interval
for a larger TCP socket write.  The BestComm tx irq is handled within
about 115us of the xmit (so for TCP at least there is unlikely to be
more than 1 skb in the ring).  The "stuck" packet generates a tx irq
just like normal.  Which tells me that BestComm has copied it to the
FEC TX fifo, but for some reason the FEC has decided to just sit on
it.  But BestComm starts adding another packet, it the FEC starts to
transmit the "stuck" packet.

This testing has been on Kernel 3.1.6 (but I've seen the same problem
on a kernel based on the OLEAS pcm030 2.6.23 kernel).  The hardware is
a custom board with 16 bit wide DDR SDRAM.

CPU:   MPC5200B v2.2, Core v1.4 at 396 MHz
      Bus 132 MHz, IPB 132 MHz, PCI 33 MHz


Joey Nelson

On Wed, Feb 1, 2012 at 6:33 PM, Joey Nelson <joey@joescan.com> wrote:
> First I think the spin_locks in the irq handlers should be
> spin_lock_irqsave(), because the same lock is used in multiple irq
> handlers. =A0If we get an rx interrupt while the tx interrupt holds the
> spin lock, this would seem to be a problem. =A0In this case maybe not
> because it is a single processor system and spin_locks should compile
> to nothing(I haven't verified this), and the rx and tx handlers don't
> really touch any common data elements. =A0I haven't tested changing
> this, because I've currently running a long test.
>
> On another front, I put some time stamp tracing into the
> mpc52xx_fec_start_xmit, and verified that the delay is happening after
> the packet is added the the BestComm ring buffer. =A0There will be 3
> quick calls to the xmit, but I'll only see 2 packets at the PC, until
> 200 - 400 ms later, when I'll get another xmit call (for the
> retransmit), and then get two duplicate packets at pc.
>
> Attempting to add time stamping to the TX irq handler have revealed
> this to be a Heisenbug of sorts. After the following changes, I
> haven't seen any delays two hours of running. =A0Previously every minute
> of so.
>
> I'll let it run over night and see if I see an additional delays.
> Next I'll remove the timestamp code, and attempt to capture the state
> of the ring buffer and BestComm at the point the retransmit packet is
> handed off to the driver. =A0The delayed packet has to be somewhere at
> that point. =A0I could be in the FEC Queue, as I don't think I've seen a
> delayed packet larger than 1k.
>
> @@ -382,6 +414,8 @@
> =A0=A0 =A0 =A0dev_kfree_skb_irq(skb);
> =A0=A0 }
> =A0=A0 spin_unlock(&priv->lock);
> + =A0 js_irq_timestamps[js_irq_idx] =3D get_tbl();
> + =A0 js_irq_idx =3D (js_irq_idx+1 =3D=3D TS_COUNT)? 0 : js_irq_idx+1;
>
> =A0 =A0 netif_wake_queue(dev);
>
> @@ -409,6 +443,7 @@
>
>
>
> Joey Nelson
>
>
>
> On Fri, Jan 27, 2012 at 12:14 PM, Joey Nelson <joey@joescan.com> wrote:
>>
>>
>> In my application, I have a PC connected through TCP to a MPC5200B based=
 system. =A0The PC sends a short request, the MPC5200B=A0receives=A0the req=
uest and sends the data back. =A0It is doing this about 300 times per secon=
d. =A0Normally exchange happens in just handful of milliseconds. =A0But ran=
domly every 2 to 15 minutes the MPC5200B sends all but the last packet of t=
he response, and about 200ms later the PC sends a delayed ACK, and the MPC5=
200B TCP stack figures the packet was lost. =A0It then sends two nearly ide=
ntical packets (The IP header Identification and Checksum fields are increm=
ented). =A0I can also see that RetransSegs in /proc/net/snmp increments by =
one for each of these delays.
>>
>> My theory is that the packet is getting suck somewhere in the network st=
ack (most likely toward the bottom). =A0Then when another packet is sent, t=
he suck one gets pushed out.
>>
>> I've done a test where I have another task on the MPC5200B sending UDP p=
ackets to a different PC every 10ms. =A0This eliminated the long delays, an=
d seems to support my stuck packet theory.
>>
>> I'm seeing the same issue with 2.6.23 and 3.1.6.
>>
>> I'm getting ready to dive into the hairy world of Bestcomm and FEC, but =
I figured I'd see if anyone else has any suggestions before I make my decen=
t. =A0Has anyone seen this=A0behavior=A0before? =A0Any likely candidates fo=
r where the packet is getting stuck? =A0General advice for reference materi=
als (I've started on Linux Device Drivers 3rd Ed, BestComm AN2604, and the =
Datasheets)
>>
>> Thanks in advance.
>>
>> Joey Nelson
>> joey@joescan.com
>>
