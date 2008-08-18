Return-Path: <grigore.mihaela@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id D9BFADE231
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 02:09:00 +1000 (EST)
Received: by gxk14 with SMTP id 14so3639378gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 09:08:59 -0700 (PDT)
Message-ID: <78ef7ce10808180901v6c694e63xefc37dd97485533@mail.gmail.com>
Date: Mon, 18 Aug 2008 19:01:56 +0300
From: "Mihaela Grigore" <grigore.mihaela@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: self-modifying code in 2.6 kernel for ppc writes into readonly section
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

First, I'm talkin about the 2.6.11 version. I know arch/ppc is gone in
latest versions,
but i assume the code is still the same and just moved to powerpc.

There is a piece of code in the early initialization of the 2.6 kernel
that identifies the cpu type and then tries to eliminate code that
does not apply to the current cpu. This is done by writing nop's over
sections of code that are not needed (do_cpu_ftr_fixups in
arch/ppc/kernel/misc.S)

When I try to run the kernel in a ppc emulator, I get a segmentation
fault in do_cpu_ftr_fixups. From examining the section headers of the
vmlinux, the text section is marked as readonly. The piece of code
above mentioned is trying to write a nop to memory location inside the
text section which is readonly, so that explains the sigsegv  error.

Since the kernel does run on boards with ppc cpu's, can somebody
explain how come this is actually working ? Or if/where I am mistaking
with my assumptions ?

Thank you

P.S. please add me in cc in a reply to this message
