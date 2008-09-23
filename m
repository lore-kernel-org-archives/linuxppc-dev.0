Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id F105BDDECF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 15:46:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Regarding select() on PPC
Date: Tue, 23 Sep 2008 07:46:02 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809230746.03234.arnd@arndb.de>
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 23 September 2008, Sadashiiv, Halesh wrote:
> 
> >I'm trying to sort out how obsolete it actually is and see if we can
> >remove the whole thing.
> >
> 
> Ok...once you verified please let me know.
> 

I just did some more research. The bug was introduced with Linux-2.1.48,
the same version in which Pauls name first appeared as the PPC guy
in the MAINTAINERS file, over 11 years ago.

Before that, ppc used to have distinct implementations for oldselect
(__NR_select) and select (__NR__newselect), because initially it shared
the syscall numbers with i386 and that had replaced its oldselect
with newselect in 1.3.0.

In essence, oldselect was already obsolete before it was introduced
in the powerpc architecture, but for obscure reasons, some code
must have confused the two calling conventions, so Cort introduced
the wrapper that could handle either one, and used it for both
syscalls. This of course made it theoretically impossible to ever
fix the implementation without potentially breaking user space one
way or another.

The 32 bit emulation code never implemented a call behind __NR_select
or the oldselect calling conventions, so anything relying on
the legacy behaviour is broken there already.

I would definitely switch over the ppc32 __NR_newselect implementation
to sys_select. For __NR_select, there is no correct solution, the three
options are the current ppc_select, the real sys_select or sys_ni_syscall.
Each of these is broken in different ways, but in practice it will never
be called anyway.

I love archeology.

	Arnd <><
