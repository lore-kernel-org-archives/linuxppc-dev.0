Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep13-int.chello.nl (amsfep13-int.chello.nl [213.46.243.23])
	by ozlabs.org (Postfix) with ESMTP id B3F3667A6D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 21:03:08 +1100 (EST)
Message-ID: <422C27FE.6000709@bitsim.se>
Date: Mon, 07 Mar 2005 11:07:58 +0100
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: acmay@acmay.homeip.net
References: <4226F904.5010104@bitsim.se> <1109875809.25252.24.camel@mud>
In-Reply-To: <1109875809.25252.24.camel@mud>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Adding machine types to the kernel tree...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the comments!

Andrew May wrote:
> I think a huge first step would be to banish xparameters.h from all the
> kernel code.
> Our HW guys just seem to do the strangest things without checking.
> So I have 2 spins of a board with 2 Virtex-II pro's each.
> The 2 spins have a small refrence clock change and the 2 CPU's have
> different IRQ mappings.

I understand that there is numerous resentment against having this file 
in the kernel and I've been thinking of a solution without it. One such 
path would be serving the kernel with a OCP list of the devices used, 
but I'm unsure about the current status of OCP. Is this The Right Way to 
do it, or are OCP likely to be abandoned further along the 2.6 road?

Matt (Porter), I've seen that you've "ported" this to the 2.6 kernel, 
what do you say?

> There is no way I wanted to build 4 kernels to handle these.
> I don't have the code with me, but the basic thing I did was fixup
> the compiled in arrays like rs_table in the board_io_mapping.
> 
> So the quick way to start tracking things down may be to just
> replace all the constants in xparmaters.h with function calls
> that got the info from the boot loader if possible.
> You will get plenty of compile errors for the arrays, but then
> just this type of code needs to be fixed up to setup the arrary
> at run time rather than just get the pointer to it at run time.

The question is, do you want to have a bootloader (as U-boot) on a small 
embedded system? In the FPGA case, you might need something that puts 
the bitstream in the right place, but I'm not quite sure it would 
constitute a bootloader. Maybe just having a static OCP list at a 
certain location in flash and let the little bitstream prog send the 
pointer to it as a kernel parameter at startup?

Reactions appreciated!

Cheers!

	/Jakob
