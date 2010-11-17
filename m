Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CE750B71B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 04:21:12 +1100 (EST)
Message-ID: <4CE40F00.7010407@windriver.com>
Date: Wed, 17 Nov 2010 11:21:04 -0600
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] kgdb,
	ppc: Corrected the address using of current->thread.evr register
References: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
	<4CE2FF5A.402@windriver.com>
	<983540C0-C0E6-44DB-9264-4A5B1E058043@kernel.crashing.org>
In-Reply-To: <983540C0-C0E6-44DB-9264-4A5B1E058043@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Deng, Dongdong" <dongdong.deng@windriver.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	kgdb-bugreport@lists.sourceforge.net, miltonm@bga.com, "Hai,
	Shan" <shan.hai@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2010 11:16 AM, Kumar Gala wrote:

>> Thanks,
>> Jason.
> 
> Repost a version with the casts and I'll pick it up.
> 
> - k

I have the final version ready for a pull request that I was going to
make in the next hour or two that is fully regression tested.

If you would prefer to these changes in the PPC, let me know, or if
you want to ack the patch, I'll add that before submitting the pull
request.

Thanks,
Jason.

--
>From b47efa1d4fa4631ee0cc59f4fcd143464b910cdc Mon Sep 17 00:00:00 2001
From: Dongdong Deng <dongdong.deng@windriver.com>
Date: Tue, 16 Nov 2010 16:02:00 -0600
Subject: [PATCH 4/4] kgdb: Fix regression in evr register handling

Commit ff10b88b5a05c8f1646dd15fb9f6093c1384ff6d (kgdb,ppc: Individual
register get/set for ppc) introduced a problem where memcpy was used
incorrectly to read and write the evr registers with a kernel that
has:

CONFIG_FSL_BOOKE=y
CONFIG_SPE=y
CONFIG_KGDB=y

This patch also fixes the following compilation problems:

arch/powerpc/kernel/kgdb.c: In function 'dbg_get_reg':
arch/powerpc/kernel/kgdb.c:341: error: passing argument 2 of 'memcpy' makes pointer from integer without a cast
arch/powerpc/kernel/kgdb.c: In function 'dbg_set_reg':
arch/powerpc/kernel/kgdb.c:366: error: passing argument 1 of 'memcpy' makes pointer from integer without a cast

[jason.wessel@windriver.com: Remove void * casts and fix patch header]
Reported-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/kgdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 7a9db64..42850ee 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 		/* FP registers 32 -> 63 */
 #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
 		if (current)
-			memcpy(mem, current->thread.evr[regno-32],
+			memcpy(mem, &current->thread.evr[regno-32],
 					dbg_reg_def[regno].size);
 #else
 		/* fp registers not used by kernel, leave zero */
@@ -362,7 +362,7 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 	if (regno >= 32 && regno < 64) {
 		/* FP registers 32 -> 63 */
 #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
-		memcpy(current->thread.evr[regno-32], mem,
+		memcpy(&current->thread.evr[regno-32], mem,
 				dbg_reg_def[regno].size);
 #else
 		/* fp registers not used by kernel, leave zero */
-- 
1.7.0.4
