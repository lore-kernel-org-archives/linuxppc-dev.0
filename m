Return-Path: <joey@joescan.com>
Received: from exprod7og124.obsmtp.com (exprod7og124.obsmtp.com [64.18.2.26])
 by ozlabs.org (Postfix) with SMTP id 8BA7D104785
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 13:33:17 +1100 (EST)
Received: by mail-vw0-f52.google.com with SMTP id h1so1974885vbi.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2012 18:33:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL_WD7hYZoaB87vZzj4Fk9nsHYSoe+qWq87g72ERLAkMur5vYg@mail.gmail.com>
References: <CAL_WD7hYZoaB87vZzj4Fk9nsHYSoe+qWq87g72ERLAkMur5vYg@mail.gmail.com>
Date: Wed, 1 Feb 2012 18:33:13 -0800
Message-ID: <CAL_WD7iJceKMOX9dWDM-SuiO5a_M-3Kp4FnZqS+AuEKvphq_-w@mail.gmail.com>
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

First I think the spin_locks in the irq handlers should be
spin_lock_irqsave(), because the same lock is used in multiple irq
handlers.  If we get an rx interrupt while the tx interrupt holds the
spin lock, this would seem to be a problem.  In this case maybe not
because it is a single processor system and spin_locks should compile
to nothing(I haven't verified this), and the rx and tx handlers don't
really touch any common data elements.  I haven't tested changing
this, because I've currently running a long test.

On another front, I put some time stamp tracing into the
mpc52xx_fec_start_xmit, and verified that the delay is happening after
the packet is added the the BestComm ring buffer.  There will be 3
quick calls to the xmit, but I'll only see 2 packets at the PC, until
200 - 400 ms later, when I'll get another xmit call (for the
retransmit), and then get two duplicate packets at pc.

Attempting to add time stamping to the TX irq handler have revealed
this to be a Heisenbug of sorts. After the following changes, I
haven't seen any delays two hours of running.  Previously every minute
of so.

I'll let it run over night and see if I see an additional delays.
Next I'll remove the timestamp code, and attempt to capture the state
of the ring buffer and BestComm at the point the retransmit packet is
handed off to the driver.  The delayed packet has to be somewhere at
that point.  I could be in the FEC Queue, as I don't think I've seen a
delayed packet larger than 1k.

@@ -382,6 +414,8 @@
 =A0 =A0 =A0dev_kfree_skb_irq(skb);
 =A0 }
 =A0 spin_unlock(&priv->lock);
+ =A0 js_irq_timestamps[js_irq_idx] =3D get_tbl();
+ =A0 js_irq_idx =3D (js_irq_idx+1 =3D=3D TS_COUNT)? 0 : js_irq_idx+1;

=A0 =A0 netif_wake_queue(dev);

@@ -409,6 +443,7 @@



Joey Nelson



On Fri, Jan 27, 2012 at 12:14 PM, Joey Nelson <joey@joescan.com> wrote:
>
>
> In my application, I have a PC connected through TCP to a MPC5200B based =
system. =A0The PC sends a short request, the MPC5200B=A0receives=A0the requ=
est and sends the data back. =A0It is doing this about 300 times per second=
. =A0Normally exchange happens in just handful of milliseconds. =A0But rand=
omly every 2 to 15 minutes the MPC5200B sends all but the last packet of th=
e response, and about 200ms later the PC sends a delayed ACK, and the MPC52=
00B TCP stack figures the packet was lost. =A0It then sends two nearly iden=
tical packets (The IP header Identification and Checksum fields are increme=
nted). =A0I can also see that RetransSegs in /proc/net/snmp increments by o=
ne for each of these delays.
>
> My theory is that the packet is getting suck somewhere in the network sta=
ck (most likely toward the bottom). =A0Then when another packet is sent, th=
e suck one gets pushed out.
>
> I've done a test where I have another task on the MPC5200B sending UDP pa=
ckets to a different PC every 10ms. =A0This eliminated the long delays, and=
 seems to support my stuck packet theory.
>
> I'm seeing the same issue with 2.6.23 and 3.1.6.
>
> I'm getting ready to dive into the hairy world of Bestcomm and FEC, but I=
 figured I'd see if anyone else has any suggestions before I make my decent=
. =A0Has anyone seen this=A0behavior=A0before? =A0Any likely candidates for=
 where the packet is getting stuck? =A0General advice for reference materia=
ls (I've started on Linux Device Drivers 3rd Ed, BestComm AN2604, and the D=
atasheets)
>
> Thanks in advance.
>
> Joey Nelson
> joey@joescan.com
>
