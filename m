Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfkMK6f8xzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 14:40:45 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so3234003pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 21:40:45 -0700 (PDT)
Date: Thu, 22 Sep 2016 14:40:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/41] powerpc/64: use gas sections for arranging
 exception vectors
Message-ID: <20160922144036.2b521d95@roar.ozlabs.ibm.com>
In-Reply-To: <20160921074407.4885-4-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
 <20160921074407.4885-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Sep 2016 17:43:29 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Use assembler sections of fixed size and location to arrange pseries
> exception vector code (64e also using it in head_64.S for 0x0..0x100).
>=20
> This allows better flexibility in arranging exception code and hiding
> unimportant details behind macros.
>=20
> Gas sections can be a bit painful to use this way, mainly because the
> assembler does not know where they will be finally linked. Taking
> absolute addresses requires a bit of trickery for example, but it can
> be hidden behind macros for the most part.
>=20
> Generated code is mostly the same except locations, offsets, alignments.

Okay, this patch requires the following change that I missed when
rebasing it. In some configurations it causes linker stubs to be
inserted in a way that shifts code and breaks things.

I thought I'd caught all such linker stub breakages at link time with
the linker script change, but not so. I'll keep working on that.


=46rom f03ff61077b775c4d094eff152fb3ca2b98a2c59 Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Sep 2016 13:49:57 +1000
Subject: [PATCH] powerpc/64s: hmi_exception_early is "unrelocated" so must =
be in trampoline section

---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exc=
eptions-64s.S
index 11a7b28..df58681 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1168,7 +1168,7 @@ COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_therma=
l_exception)
 #endif /* CONFIG_CBE_RAS */
=20
=20
-COMMON_HANDLER_BEGIN(hmi_exception_early)
+TRAMP_HANDLER_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
 	mr	r10,r1			/* Save r1			*/
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
@@ -1216,7 +1216,7 @@ hmi_exception_after_realmode:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	tramp_real_hmi_exception
-COMMON_HANDLER_END(hmi_exception_early)
+TRAMP_HANDLER_END(hmi_exception_early)
=20
=20
 #define MACHINE_CHECK_HANDLER_WINDUP			\
--=20
2.9.3
