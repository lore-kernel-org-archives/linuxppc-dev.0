Return-Path: <acmay@acmay.homeip.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 8012A67A79
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 06:25:03 +1100 (EST)
From: Andrew May <acmay@acmay.homeip.net>
To: Jakob Viketoft <jakob.viketoft@bitsim.se>
In-Reply-To: <4226F904.5010104@bitsim.se>
References: <4226F904.5010104@bitsim.se>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:50:09 -0800
Message-Id: <1109875809.25252.24.camel@mud>
Mime-Version: 1.0
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Adding machine types to the kernel tree...
Reply-To: acmay@acmay.homeip.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-03 at 12:46 +0100, Jakob Viketoft wrote:
> Hi!
> 
> Are there any certain policys or religious issues about adding machine 
> types to the (ppc40x) kernel tree, and who's responsible for kicking 
> stuff like this up the main tree?

Well I don't know about that, but what really makes it hard for me to
work on things is that I only have a few custom boards to test on.
So any time I make changes that could make things more general I can't
test to make sure I don't break a vanilla eval board.

> Specifically, I would like to replace the PowerPC405 support for the 
> Xilinx ML 300 (development board) with generic Xilinx Virtex-II Pro and 
> Virtex4 support (FPGAs). In my opinion, the end target isn't the 
> development boards, but the custom configuration it all will run on in 
> the end, and so things would benefit from a more general support. Do 
> anyone have any insightful views/opinions on this or comments of any kind?

I think a huge first step would be to banish xparameters.h from all the
kernel code.
Our HW guys just seem to do the strangest things without checking.
So I have 2 spins of a board with 2 Virtex-II pro's each.
The 2 spins have a small refrence clock change and the 2 CPU's have
different IRQ mappings.

There is no way I wanted to build 4 kernels to handle these.
I don't have the code with me, but the basic thing I did was fixup
the compiled in arrays like rs_table in the board_io_mapping.

So the quick way to start tracking things down may be to just
replace all the constants in xparmaters.h with function calls
that got the info from the boot loader if possible.
You will get plenty of compile errors for the arrays, but then
just this type of code needs to be fixed up to setup the arrary
at run time rather than just get the pointer to it at run time.

=========================================
XEmac_Config *
XEmac_GetConfig(int Instance)
{
	if (Instance < 0 || Instance >= XPAR_XEMAC_NUM_INSTANCES) {
		return NULL;
	}

	return &XEmac_ConfigTable[Instance];
}
============================================
