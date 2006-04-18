Return-Path: <jessicac@tccomm.com>
Received: from smtpout07-04.prod.mesa1.secureserver.net
	(smtpout07-01.prod.mesa1.secureserver.net [64.202.165.230])
	by ozlabs.org (Postfix) with SMTP id 300EF679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 05:51:24 +1000 (EST)
Message-ID: <002001c66321$76d44050$9afea8c0@tcdomain.com>
From: "Jessica Chen" <jessicac@tccomm.com>
To: <linuxppc-embedded@ozlabs.org>
References: <20060415001224.D1551353A56@atlas.denx.de>
Subject: Re: Port Linux w/ mbxboot to PPCBoot system 
Date: Tue, 18 Apr 2006 12:51:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you for your reply Wolfgang!

In u-boot-1.1.4 README "Where we come from" section, it says u-boot "provide
extended interface to Linux boot loader".  Does it mean that there is still
some sort of boot loader in arch/ppc/coffboot/vmlinux.gz ?  If yes, when
does it start?  Does it boot the kernel?

To build u-boot, I will need to get the manual for MPC852 and check the
configurations in include/configs/TQM860L.h file.

I am trying to find the machine specific header file in linux-2.4.25
(include/asm-ppc/tqm8xx.h file in linux-2.4.4) which should have the same
definition of structure bd_info as in include/asm-ppc/u-boot.h.  And you
recommend using linux-2.4 instead of linux-2.6 on your website.

So am I heading the right directions here?  Because the u-boot README
doesn't have the new directories and filenames, I am a little confused.



Thanks again,

Jessica



> >      I am new to embedded system, I am studying ppcboot-1.1.5 and linux
> > kernel-2.4.4 that comes with an mpc852 base board, we want to modify it
in
>
> Both PPCBoot and Linux 2.4.4 are *hoplessly* obsolete. It may  be  ok
> to study this to understand the workings, but please don't even dream
> of using it for any current work.
>
> > the future.  In the build process, they use the zImage.initrd
> > (arch/ppc/mbxboot/zvmlinux.initrd) instead of the raw Linux kernel image
>
> Somebody didn't know what he was doing, it seems.
>
> > since ppcboot is already running, what happens when I boot the kernel
that
> > has old boot loader code in arch/ppc/mbxboot?  Will some parameters be
> > overwritten?  If not, why?
>
> The Linux bootstrap loader code (arch/ppc/mbxboot)  will  ignore  the
> parameteres  passed  by  U-Boot,  will set up is own (hardwired), and
> duplicate some of the things that PPCboot did or would do.
>
> >      I am very tempted to follow the README to re-build the kernel with
only
> > vmlinux.gz and port it, but I don't want to create any un-recoverable
> > results.  So I am here to seek advice, maybe this is something obvious
to
> > many people.
>
> Don't change anything. Look at it, then drop it. Start using  current
> code, i. e. a recent version of U-Boot and a recent Linux kernel.
