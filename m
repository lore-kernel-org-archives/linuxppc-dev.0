Return-Path: <dan@embeddedalley.com>
Received: from smtp110.biz.mail.mud.yahoo.com (smtp110.biz.mail.mud.yahoo.com
	[68.142.201.179]) by ozlabs.org (Postfix) with SMTP id B8BF8DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 02:31:37 +1000 (EST)
In-Reply-To: <m2wsv58cp1.fsf@ohwell.denx.de>
References: <F3D55679E1DCFF49A57570501B70475F070D83BC@CL5EXBE04.ad2.softcom.biz>
	<7c1681440709032107u3feb0684x34dcf44b5e43616@mail.gmail.com>
	<m2wsv58cp1.fsf@ohwell.denx.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2D63A00B-C9A8-4C11-BDB2-B3597FACA3AF@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Breakpoint is not hitting for Kernel Debugging
Date: Wed, 5 Sep 2007 09:31:40 -0700
To: Detlev Zundel <dzu@denx.de>
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


On Sep 5, 2007, at 6:27 AM, Detlev Zundel wrote:

> Hi,
>
>>   ;; Following is to clear the page table base address
>>   WM32    0x000000f0      0x00000000
>
> Did you really need this under any circumstance?  To only hit a
> breakpoint?

No, you don't.  For the identify mapped kernel
space, only the MMU XLAT is required, which
covers nearly all kernel.  This is only necessary for
tracking vmalloc()'ed space, like for loadable
modules.

However, this WM32 should not be necessary
in any case, as the page table pointers for
BDI information tracking are set up by the
kernel initialization functions.

> I am asking because recent experiences with BDI debugging showed that
> there are some pitfalls that one can fall into (and these are only the
> ones that I got aware of):

Yes, and I apologize for not allocating the
time to work with Abatron to make this
work better.  The page tables changes
that have taken (and still take) place in
2.6 caused our original 2.4 implementation
to not work well.  Abatron has made updates
that work well, but there are still some edge
cases that may not work well.  I need to find
those and provide some assistance.

The whole of the Linux BDI configuration
has been abused as well, the BDI_SWITCH
should not be used as it is today.  That
was not the intention for this particular
configuration option.

>    So for the original poster I would say a PTBASE 0x0 would be in
>    order.

It changes a little among the processor variants,
in particular traditional Power versus Book E.
Check the release notes and manuals for the
BDI2000, along with the information from
Ultimate Solutions to determine what is best.

> b) Moreover even with a _wrong_ PTBASE on a 440EPx the BDI translated
>    start_kernel just fine by only subtracting 0xc0000000 (using a
>    "default" translation) - it was only later (debugging dynamic
>    modules) that the wrong PTBASE hit me hard.

That's correct.  If the BDI firmware can find the
translation in the TLB, it will just use that.  In the
case of many processors, this is either a wired
entry or a BAT.  If the BDI firmware can't find
a valid translation, it walks the page tables.
For 8xx and some 40x, the PTBASE is required
as there may be no wired entries by default.

Just remember that the values for both MMU XLAT
and PTBASE must match the kernel software and
configuration.  This is the only correct answer :-)
Documentation will describe the public source,
default configuration at the time of the writing,
but it's very easy to change and will cause
debugging problems.

Thanks.

	-- Dan
