Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 91D7368942
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 20:16:15 +1100 (EST)
To: "HappyPhot" <happyphot@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Dec 2005 13:52:36 +0800."
	<007801c60b72$eb4988c0$0860120a@photon>
Date: Wed, 28 Dec 2005 10:16:12 +0100
Sender: wd@denx.de
Message-Id: <20051228091612.B43D3353A66@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Error: unknown pseudo-op: `.cfi_startproc' 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <007801c60b72$eb4988c0$0860120a@photon> you wrote:
>
>   I am using ELDK (2005-06-07) and linux-2.6.15-rc2-2005-12-03-2208.tar.bz2
> to build the kernel. But there are some errors:
> 
> .../arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
> .../arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: 
> `.cfi_startproc'
> .../arch/powerpc/kernel/vdso32/gettimeofday.S:30: Error: unknown pseudo-op: 
> `.cfi_register'
> .......
> 
> Anybody knows what happened ? And is there any way to solve ?

ELDK 3.1 uses binutils-2.14; the current Linux kernel was changed  to
use  assembler  syntax which is not supported by the GNU assembler in
this version. See for example
http://ozlabs.org/pipermail/linuxppc64-dev/2005-February/003179.html

I don't understand why this  was  done,  either.  Especially  as  the
current  Linux  kernel  documentation ("Documentation/Changes") still
claims that binutils 2.12 would be sufficient.

You will have to update your toolchain  (i.  e.  use  ELDK  4.0)  for
working with current 2.6 kernels.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
This is an unauthorized cybernetic announcement.
