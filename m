Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4BC4067B5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 07:19:07 +1100 (EST)
Date: Mon, 27 Nov 2006 12:18:59 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Mock <jeff@mock.com>
Subject: Re: PPC440GX ethernet oddities
Message-ID: <20061127201859.GA14806@gate.ebshome.net>
References: <456A641D.7070904@mock.com>
	<20061127042554.GB26806@gate.ebshome.net>
	<456B21C3.6040203@mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <456B21C3.6040203@mock.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 27, 2006 at 09:34:59AM -0800, Jeff Mock wrote:
> 
> Eugene Surovegin wrote:
> > On Sun, Nov 26, 2006 at 08:05:49PM -0800, Jeff Mock wrote:
> >> I'm having a slightly strange behavior with PPC440GX ethernet, I'm
> >> looking for a little advice where I can poke around to see what's going on.
> >>
> >> I have a custom 440GX board, I use the two RGMII gigabit interfaces to
> >> two Vistesse PHYs.  This works nicely.
> > 
> > What is the CPU clock speed?
> > 
> 
> They are 800MHz rev.F 440GX's.

OK, this explains why you can get 80MB/s over Linux sockets :)

> 
> >> The board has a large FPGA signal processor that is DMA'ing data into
> >> main memory, the PPC sends data from main memory out the ethernet
> >> interfaces.  This all works well.  For testing purposes I'm DMA'ing a
> >> pseudo random sequence at 80MB/s, sending this over ethernet on a TCP
> >> socket to a server machine and checking the sequence at the receiving
> >> end. 
> > 
> > Could you elaborate a little here. Is it a user-space program or some 
> > kernel mode code which does the copying?
> > 
> 
> The device driver for the FPGA allocates 64MB of memory at boot time and
> uses this as a ring buffer.  The user process mmap()s the entire buffer.
> When the user process does a read it blocks until data is available and
> the device driver returns pointers into the ring buffer for the
> currently available data.  The user process passes pointers to the ring
> buffer to the write() used to send data out the network connection.
> 
> This isn't terribly memory efficient, but the embedded 440GX main
> purpose in life is to move data from the FPGAs across the network. At
> 80MB/s the 440GX CPU seems to be about 40% utilized.

Yeah, you probably can save one memory copy by using kernel mode code, 
but 40% seems OK if this is the only thing 440GX has to do.

> > 
> > Well, 300ms doesn't look particularly crazy to me given a data stream 
> > and the fact you are using non-realtime OSes on both ends.
> > 
> 
> I'm starting to think that you might be right about that.  The odd thing
> that caused me to seek community help is that the ring buffer only fills
> to about 512kB under normal circumstances, but fills to 25MB if I
> connect the second Gb ethernet port of the 440GX.

Although it's interesting to figure out what caused this change in 
behaviour, you have to keep in mind that TCP isn't a real-time 
protocol and it can create some jitter. You have to be prepared to 
buffer upto several seconds of your data when using TCP on local LAN 
and more if using intranet/Internet.

> 
> 
> > Try ethtool -S, EMAC driver supports it.
> > 
> 
> This is a great idea, I didn't realize that ethtool supports the IBM
> EMAC driver.  I suspected that I would find some electrical problem that
> was causing additional packet errors when the second ethernet port is
> connected.  A ran about 2TB last night, ethtool -S on the PPC says:
> 
> # ./ethtool -S eth0
> NIC statistics:
>      rx_packets: 683430611
>      rx_bytes: 45405076316
>      tx_packets: 1331225622
>      tx_bytes: 2005276384145
>      rx_packets_csum: 683428670
>      tx_packets_csum: 1331224150
>      tx_undo: 0
>      rx_dropped_stack: 80
>      rx_dropped_oom: 0
>      rx_dropped_error: 0
>      [lots more 0's...]
> 
> The number of checksum errors seems okay and doesn't really change when
> I plug in the second network connection, but the ring buffer usage still
> increases dramatically.

Stats look OK.  BTW, tx/rx_packets_csum is not a number of checksum 
errors, that's a number of packets where driver used hw checksum 
acceleration :).

-- 
Eugene
