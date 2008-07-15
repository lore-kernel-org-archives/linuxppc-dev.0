Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 24409DDF8A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 09:59:07 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: AT_BASE_PLATFORM (v2)
Date: Tue, 15 Jul 2008 18:58:49 -0500
Message-Id: <1216166331-14810-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Background:
Some IBM POWER-based systems have the ability to run in a
"compatibility" mode which mostly appears to the OS as a different
processor from the actual hardware.  This feature of the platform is
useful for live partition migration and for backwards compatibility
with old kernels on new hardware.  For example, a Power6 system may
appear to be a Power5+, which makes the AT_PLATFORM value "power5+".

Problem:
Booting a system in a compatibility mode means that ld.so may load
libraries that are inappropriately tuned for the real
microarchitecture, and apps that use JIT techniques do not have the
right information for generating tuned code.  While the AT_PLATFORM
auxiliary vector entry correctly indicates the ISA supported, it does
not accurately reflect the underlying microarchitecture in this case,
and there is no good way for userspace to get this information.

Proposed solution:
Add an AT_BASE_PLATFORM auxiliary vector entry which indicates the
microarchitecture.  This entry uses the same string format as
AT_PLATFORM, and is readily usable by ld.so and other applications.

Other solutions that have been suggested but found wanting:

- Use a bit in AT_HWCAP to indicate compat mode -- this is not
expressive enough.  It's not possible to derive the microarchitecture
from the combination of AT_PLATFORM's value and a single bit.

- Use dsocaps -- this seems to be a ld.so-specific interface and not
easily usable by other programs.  ld.so/glibc is not the only program
that can use knowledge of the microarchitecture.

The following two patches:
- add the base support to binfmt_elf.c for AT_BASE_PLATFORM
- implement AT_BASE_PLATFORM for powerpc

Changes since v1:
- increment AT_VECTOR_SIZE_BASE
- define AT_BASE_PLATFORM in generic code instead of powerpc
