Date: Tue, 9 Mar 2004 12:15:51 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: John Feller <JFeller@RADIOFRAMENETWORKS.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DMA transfer into sk_buff - cached memory question
Message-ID: <20040309201551.GB18478@gate.ebshome.net>
References: <09EDD8D5C7874D439B2155E0359890C7E88E43@mail.redmond.radioframenetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09EDD8D5C7874D439B2155E0359890C7E88E43@mail.redmond.radioframenetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 09, 2004 at 11:06:09AM -0800, John Feller wrote:
>
> We've got a custom FPGA-based Ethernet MAC that stores Rx packets in
> internal FPGA memory.  From there the software must copy the packet data
> into SDRAM.  I've done the simple "memcpy" thing in the Rx interrupt, but
> that obviously takes some time.  So the hardware group has put in a single
> DMA controller that I can kick off to do the data transfer in the
> background.  This works fine with my U-Boot code, but data caching is not
> enabled there.
>
> Now I am looking at implementing this DMA operation in my Linux Ethernet
> driver, but am worried about data caching issues with the socket buffer data
> pointer I get back from "dev_alloc_skb()".  The DMA engine will obviously
> bypass the PowerPC data cache (go directly to SDRAM), so it looks like there
> is a potential for mis-match between SDRAM and the cache if that SDRAM
> address range is cached before the DMA transfer begins.
>
> It doesn't appear there is a way to force the allocation of the socket
> buffer data area as uncached.  Passing "__GFP_DMA" to "alloc_skb()" doesn't
> seem to guarantee anything about caching - just that the memory was
> allocated from a "DMA" address range.  I'm assuming this doesn't mean
> anything on the PowerPC.
>
> Ideally the allocated socket buffer data area would still be cacheable, but
> guaranteed to not be in the data cache immediately after it is allocated.
> Second-best would be to have the socket buffer data area marked as
> non-cacheable in the 405 hardware TLB assigned to it.
>
> Any help/advice would be appreciated.  It seems like this would be a very
> common issue, but I have been unable to find the answer anywhere.  Thank you
> for your help, and I apologize if I have missed something very obvious.

Please, read Documentation/DMA-mapping.txt.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
