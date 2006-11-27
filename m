Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1F81667B6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 04:35:03 +1100 (EST)
Received: from [192.168.12.6] (lab.mock.com [192.168.12.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.mock.com (Postfix) with ESMTP id CCEDF73108
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Nov 2006 09:34:59 -0800 (PST)
Message-ID: <456B21C3.6040203@mock.com>
Date: Mon, 27 Nov 2006 09:34:59 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440GX ethernet oddities
References: <456A641D.7070904@mock.com>
	<20061127042554.GB26806@gate.ebshome.net>
In-Reply-To: <20061127042554.GB26806@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Eugene Surovegin wrote:
> On Sun, Nov 26, 2006 at 08:05:49PM -0800, Jeff Mock wrote:
>> I'm having a slightly strange behavior with PPC440GX ethernet, I'm
>> looking for a little advice where I can poke around to see what's going on.
>>
>> I have a custom 440GX board, I use the two RGMII gigabit interfaces to
>> two Vistesse PHYs.  This works nicely.
> 
> What is the CPU clock speed?
> 

They are 800MHz rev.F 440GX's.

>> The board has a large FPGA signal processor that is DMA'ing data into
>> main memory, the PPC sends data from main memory out the ethernet
>> interfaces.  This all works well.  For testing purposes I'm DMA'ing a
>> pseudo random sequence at 80MB/s, sending this over ethernet on a TCP
>> socket to a server machine and checking the sequence at the receiving
>> end. 
> 
> Could you elaborate a little here. Is it a user-space program or some 
> kernel mode code which does the copying?
> 

The device driver for the FPGA allocates 64MB of memory at boot time and
uses this as a ring buffer.  The user process mmap()s the entire buffer.
When the user process does a read it blocks until data is available and
the device driver returns pointers into the ring buffer for the
currently available data.  The user process passes pointers to the ring
buffer to the write() used to send data out the network connection.

This isn't terribly memory efficient, but the embedded 440GX main
purpose in life is to move data from the FPGAs across the network. At
80MB/s the 440GX CPU seems to be about 40% utilized.


> 
> Well, 300ms doesn't look particularly crazy to me given a data stream 
> and the fact you are using non-realtime OSes on both ends.
> 

I'm starting to think that you might be right about that.  The odd thing
that caused me to seek community help is that the ring buffer only fills
to about 512kB under normal circumstances, but fills to 25MB if I
connect the second Gb ethernet port of the 440GX.


> Try ethtool -S, EMAC driver supports it.
> 

This is a great idea, I didn't realize that ethtool supports the IBM
EMAC driver.  I suspected that I would find some electrical problem that
was causing additional packet errors when the second ethernet port is
connected.  A ran about 2TB last night, ethtool -S on the PPC says:

# ./ethtool -S eth0
NIC statistics:
     rx_packets: 683430611
     rx_bytes: 45405076316
     tx_packets: 1331225622
     tx_bytes: 2005276384145
     rx_packets_csum: 683428670
     tx_packets_csum: 1331224150
     tx_undo: 0
     rx_dropped_stack: 80
     rx_dropped_oom: 0
     rx_dropped_error: 0
     [lots more 0's...]

The number of checksum errors seems okay and doesn't really change when
I plug in the second network connection, but the ring buffer usage still
increases dramatically.

Thanks for the other suggestions.  I have a friend at a 'real' company
where I might be able to borrow a network analyzer.

jeff
