Return-Path: <ctz001@email.mot.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id A16EE68150
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 08:17:20 +1000 (EST)
Date: Thu, 25 Aug 2005 17:17:16 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: Grant Likely <glikely@gmail.com>
In-Reply-To: <20050825062425.GA5607@siegfried.thelikelysolution.ca>
Message-ID: <Pine.WNT.4.61.0508251610280.2688@holyoke.labs.mot.com>
References: <20050824134404.B1DF668108@ozlabs.org>
	<EDFB2B1ED0A1D7118A0A00065BF2490D1E3A601B@il06exm13>
	<20050825062425.GA5607@siegfried.thelikelysolution.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: T Ziomek <Tom.Ziomek@motorola.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Source of xparameter_ml300.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 25 Aug 2005, Grant Likely wrote:
> On Wed, Aug 24, 2005 at 08:20:48PM -0500, T Ziomek wrote:
>>
>> Also, be aware that the differences between 'xparameters.h' and
>> 'xparameters_ml300.h' are not all you need to worry about.

BTW, I took a approach different from MV's for 'xparameters.h'.  Seeing no
reason why that file *had* to be changed for Linux (and because the folks
doing the Xilinx hardware releases I use only use the 'standalone' BSP and
hence never run that Tcl script), I instead added a 'linux.xparameters.h'
file.  This file first includes 'xparameters.h' and then #defs all of the
Linux-specific stuff.
    Then I changed all Linux #includes of 'xparameters.h' to pull in my new
file instead.

My 'linux.xparameters.h' hasn't changed since I created it Feb. 2, though
I've worked with a dozen or more 'xparameters.h' files in that time.

IMO, this two files approach is better all-around, with better separation
of concerns and no Tcl script.

>>    Starting with MV's port to the ML300, you need to figure out which IP
>> versions it was created for (for example, "emac_v1_00_b").  Then you need
>> to compare that with the IP version used in your system [NOTE 1].  They'll
>> probably be different, so then you need to either merge MV's changes into
>> the newer Xilinx code or Xilinx's changes into the MV-modified drivers.
>> This leaves you with software drivers that match the IP and have the chang-
>> es needed to work in Linux.
>
> Ah, yes.  I was wondering how much grief I would be dealing with in that
> regard.  One of my goals is to get somewhat flexable drivers for basic
> cores into mainline, so I'm sure I'll be fighting with this.

I keep wanting to implement a "2 files" approach like that above for the
driver files.  It's not as simple to do, and so far I keep enduring the
periodic hack session rather than investing time looking for a better solu-
tion.

Oh yeah, another minor type of change I had to deal with -- in cases where
a peripheral is on a different bus between the ML300 and our board I had to
make changes such as "OPB" -> "PLB".  No big deal there, though I wonder if
it should really be necessary.  Does Xilinx IP have significant bus-specific
differences (e.g. OPB EMAC vs. PLB EMAC)?  I wouldn't expect so...

>>    It also looks like the Xilinx software driver bugs that MV found were
>> not reported to Xilinx but just worked around, so those bugs are probably
>> still present in your design.  They were in ours...
> Thank's for the heads up.  Your email addr's getting a permanent place
> in my address book.  :)

:-(

Just kidding; I've been meaning for months now to put this stuff out on the
maillist (partly because I'm way overdue on "giving back" and partly to see
if I was missing some obvious Easy Way).

>> NOTE 1:  And don't depend on Xilinx's rev numbers changing when their dri-
>>          ver code does.  I regularly run across situations where consecu-
>>          tive FPGA designs both use, say, the "gpio_v2_00_a" IP and driver
>>          yet the driver code has changed.  It is important that you 'diff'
>>          or whatever all of the driver code for changes each time you re-
>>          ceive a new FPGA design generated from an XPS with *any* changes
>>          at all (new version, patches, etc.), even if it appears that the
>>          patch should not affect any driver code.
> Hmm, lovely.

Don't get me started...

> IMHO the mainline code should be as simple as possible to adapt to new
> boards and their associated xparameters.h.  I've created an xparameters
> 'abstraction layer' that keeps changes to the board more or less
> isolated to the platform bus initialization data structures.  It also
> prevents having to recompile the world everytime I use a different
> bitstream.  However, that doesn't solve the changes to logic cores (as
> you so eloquently pointed out).  At the very least I'd like to get a set
> of core drivers ported/written that use #defs to adapt to the
> appropriate core version.  I'll never be able to support every core
> version, but I should be able to support a number of the more recent
> cores.
>
> The difficulty that I have with the current port is that there is still
> a fair bit of work to adapt from one xparameters to another.
>
> There is a very real possibilty that I'll be taking on
> lots of v2pro work in the near future and I'd like to have a comfortable
> foundation to start from.

Exactly what I keep wanting to do.  I expect you'll be glad you have it.

One thing I *did* do was completely remove Xilinx-sourced files (or files
based on Xilinx-supplied code) from the kernel tree.  So things like
.../arch/ppc/platforms/xilinx_ocp and .../drivers/net/xilinx_enet/x* are not
used at all.  In my thinking that stuff doesn't belong in the kernel tree
because it changes so often (again, the board vs. FPGA issue) (and I fully
expect to get re-educated, because I really don't know enough to spout off
about what should or shouldn't be in the kernel tree).
    I did of course have to change Makefiles and the like to pull the neces-
sary headers and C from my (external to the kernel tree) 'ppc405_0' dir.
And it's not a complete solution; my ppc405_0 tree isn't accounted for when
Linux builds all of its dependencies so I have to remember when to delete
a certain subtree's *.[oa] files to force rebuilds.
    Being a one-man band in a research group it works okay for me, but with-
out more work it certainly isn't scalable to a large team and wouldn't be
appropriate for product development.

>> I've been where you're going...
> I feel a great sense of foreboding in that remark...  Thanks for the
> long response; good info.
>
> Did you use a 2.4 or 2.6 kernel in your work?  Are your driver changes
> available for download anywhere?

So far we're using MV Pro 3.1, which is based on a 2.4 kernel.  Pro 4.0 is
2.6 based and starting to become available; I haven't yet checked on the
PPC405 / ML300 port.

Working for A Big Corporation, I can't easily get my changes onto an FTP
site.  I'll provide them on request instead, but note that I'll be out of
the office this Friday.  Plus I'll have to doublecheck them for the proper
copyright & licensing notices.  But still, next week should be no problem.

The files I've been modifying are
.../include/xbasic_types.h
.../include/xdma_channel.h  [1]
.../include/xemac.h  [1]
.../libsrc/dma_v*/src/xdma_channel_sg.c
.../libsrc/emac_v*/src/xemac.c
.../libsrc/emac_v*/src/xemac_g.c
.../libsrc/emac_v*/src/xemac_intr_dma.c

[1] : Since these two are duplicated within the driver tree (another peeve
       of mine), I also delete .../libsrc/dma_v*/src/xdma_channel.h and
       .../libsrc/emac_v*/src/xemac.h to avoid having to make the same
       changes twice.

Descriptions of the specific changes made follow.  I believe all but the
first are just re-applying changes MV made in their port to Linux.

.../include/xbasic_types.h
     Make 'Xuint32' and 'Xint32' 'int's rather than 'long's.

.../include/xdma_channel.h
     Add 'VirtPtr' and 'PhyPtr' elements to 'XDmaChannel' struct.
     Add 'PhyPtr' arg to XDmaChannel_CreateSgList()'s signature.

.../include/xemac.h
     Add 'PhysAddress' element to 'XEmac_Config' and 'XEmac' structs.
     Add 'PhyPtr' arg to XEmac_SetSgRecvSpace()'s and XEmac_SetSgSendSpace()'s
           signatures.

.../libsrc/dma_v*/src/xdma_channel_sg.c
     Add P_TO_V() and V_TO_P() macros.
     Add 'PhyPtr' arg to XDmaChannel_CreateSgList() and add setting of
     'InstancePtr's 'VirtPtr' and 'PhyPtr' fields.

.../libsrc/emac_v*/src/xemac.c
     Add setting of 'InstancePtr's 'PhysAddress' field in XEmac_Initialize().

.../libsrc/emac_v*/src/xemac_g.c
     Init 'XYZ' struct's new 'PhysAddress' element.

.../libsrc/emac_v*/src/xemac_intr_dma.c
     Pass 'PhysAddress' rather than 'BaseAddress' to XBufDescriptor_SetDestAd-
           dress() in XEmac_SgSend()
     Pass 'PhysAddress' rather than 'BaseAddress' to XBufDescriptor_SetSrcAd-
           dress() in XEmac_SgRecv().
     Add 'PhyPtr' arg to XEmac_SetSgRecvSpace() and pass it to XDmaChannel_Cre-
           ateSgList().
     Add 'PhyPtr' arg to XEmac_SetSgSendSpace() and pass it to XDmaChannel_Cre-
           ateSgList().

Looking at my archived of hacked ppc405_0 trees it looks like I have the
following hacked driver directories:  dma_v1_00_a, emac_v1_00_e, emac_v1_00_f
and emac_v2_00_c .  Of course there's no certainty one 'dma_v1_00_a' is the
same as another...

That's it, for now.
Tom

-- 
   /"\  ASCII Ribbon Campaign   |   Email to user 'CTZ001'
   \ /                          |             at 'email.mot.com'
    X        Against HTML       |
   / \     in e-mail & news     |
