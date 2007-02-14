Return-Path: <imrek@atomki.hu>
Received: from imrek.org (unknown [193.6.168.119])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFCF1DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 18:17:24 +1100 (EST)
Received: from localhost ([127.0.0.1]) by imrek.org with esmtp (Exim 4.54)
	id 1HHEVY-00008u-VO
	for linuxppc-embedded@ozlabs.org; Wed, 14 Feb 2007 08:24:53 +0100
Date: Wed, 14 Feb 2007 08:24:52 +0100 (CET)
From: jozsef imrek <imrek@atomki.hu>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Speed of plb_temac 3.00 on ML403
In-Reply-To: <BAY110-F266A0C4987983C9B579C76B2910@phx.gbl>
Message-ID: <Pine.LNX.4.61.0702140546360.32655@imrek.org>
References: <BAY110-F266A0C4987983C9B579C76B2910@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 12 Feb 2007, Ming Liu wrote:

> You said in your application the data path can bypass the IP stack, the CPU, 
> and with some work even the main memory. How can you achieve that? Then who 
> will process the UDP packets? If you add the work of processing packets in,

a precondition for this to work is to have all your data processing
implemented in hardware, since the CPU will not see the payload of
the udp packets, so it will have no chance to modify it.

the trick is (as i mentioned in my first reply) is to use an IPIF with
address range support (so it looks like a memory), and have the s/g dma
engine of the plb_temac read the udp payload from this "memory" instead
of your system ram.

the packet header (ethernet + ip + udp) in our application is assembled
by a code based on pktgen. you could implement it in hw as well, but there
is no need for that since you can utilize the full gigabit bandwith (this
you have seen.. :), and it is more convinient to have that functionality
in sw.


a quick hack to see this theory working:

1, create a new peripherial with address range support.
 	(start xps -> hardware -> create or import new peripherial,
 	plb bus, no sw reset/mir, no interrupt, no user regs, with
 	burst support, no fifo, with user address range, no dma,
 	no master iface)

 	you might want to replace the bram in the sample code
 	(pcores/*/hdl/vhdl/user_logic.vhd) with a fixed value
 	or a counter.

2, add this core to your design, create and download your new bitfile.

3, modify the source of the plb_temac linux driver. when a packet
 	is sent with fragments a buffer descriptor (bd) will be set
 	up for each fragment. the first bd will be used for the
 	packet header, and the rest of the bd's will point to the
 	the udp payload. so you want to make sure, that the physical
  	address of all but the first bd's is pointing to the physical
  	address of your IPIF's address range (you can find it in your
 	mhs file, search for C_AR_BASEADDR).

 	in adapter.c in xenet_SgSend_internal() search for the loop
 	where a bd is set up for each payload fragment (something like
 	for (i = 1; i < total_frags; i++, frag++)..), and set the
 	phy_addr to the address of your core (ie. phy_addr = 0x70090000;).

 	compile your new kernel, download it.

4, start pktgen with frags = 1 (use pgset "frags 1"). check the
 	payload of the packets sent on the wire (ie. with tcpdump).

 	if you have replaced the bram in step 1 with a fixed value
 	you should see that value. if you have replaced it with a
 	counter you should see the values rolling. if you did not
 	replace the bram, you should see the contents of the bram - it
 	is filled with all zeroes on reset, but you can fill it with
 	any test pattern.



good luck, and let me know how it works!


-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------
