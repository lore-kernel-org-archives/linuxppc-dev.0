Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-127.roch.qwest.net [67.41.71.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A06367C1A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 05:36:11 +1000 (EST)
Subject: Re: asm-ppc includes
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Jeff Stevens <jsteve17@yahoo.com>
In-Reply-To: <20061015150217.17117.qmail@web33411.mail.mud.yahoo.com>
References: <20061015150217.17117.qmail@web33411.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 14:06:25 -0500
Message-Id: <1160939185.18463.7.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: ELDK Mailing List <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 2006-10-15 at 08:02 -0700, Jeff Stevens wrote:
> I have a AMCC 440SP board, and I am having an issue with the asm includes under 2.6.17.9.  
> It seems that almost everything I try to compile is looking for headers files in the asm-ppc
>  directory that aren't there (like asm/errno.h, asm/ioctl.h, asm/types.h, asm/posix-types.h,
>  etc.).  Where are these files?  I have a few applications that compiled fine under 2.4 that
>  now won't compile under 2.6.

You're compiling applications against raw kernel headers?  You really
shouldn't do that.  Use the ones provided by glibc.

To answer your "where are they" question, in 2.6.15-ish lots of them
moved to include/asm-powerpc/.  Makefile magic brings them in to kernel
compiles using ARCH=ppc when needed.

josh
