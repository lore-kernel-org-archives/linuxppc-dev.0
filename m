Return-Path: <sruffell@digium.com>
Received: from mail.digium.com (mail.digium.com [216.207.245.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E7981007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 09:03:43 +1000 (EST)
Date: Thu, 14 Apr 2011 17:27:19 -0500
From: Shaun Ruffell <sruffell@digium.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Define 'crash_kexec_wait_realmode' for Non-SMP
	systems.
Message-ID: <20110414222719.GA16256@digium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a regression from b987812b3fcaf70fdf0037589e5d2f5f2453e6ce
"powerpc/kexec: Fix mismatched ifdefs for PPC64/SMP" which resulted in

arch/powerpc/kernel/crash.c: In function =E2=80=98default_machine_crash_s=
hutdown=E2=80=99:
  arch/powerpc/kernel/crash.c:349: error: implicit declaration of functio=
n
  =E2=80=98crash_kexec_wait_realmode=E2=80=99

message on when compiling on Blue&White G3 and CONFIG_SMP is not defined.

Signed-off-by: Shaun Ruffell <sruffell@digium.com>
---
 arch/powerpc/kernel/crash.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 3d3d416..5e6e37f 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -255,6 +255,9 @@ void crash_kexec_secondary(struct pt_regs *regs)
 {
 	cpus_in_sr =3D CPU_MASK_NONE;
 }
+
+static inline void crash_kexec_wait_realmode(int cpu) {}
+
 #endif
=20
 /*
--=20
1.7.4.3
