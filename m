Return-Path: <linuxppc-dev+bounces-20700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB8ECD37B9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 12:07:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDdkz6rFHz2xlh;
	Mon, 11 May 2026 22:07:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778501243;
	cv=none; b=PvVhoeScmdX7Y+Ut1lIKS8WvaQUqslDqbKZ2BHNPPJlh4rqXUqJi5q7mny9eUuZ3hViNmL3PzRTVY3MZx1330SBVJ1WscqiDjN4H4faZJUmsWo435YuYvj3WeeY8T5KSJjSQVyJYr8oxTC4TeoSm30frXhd9qf2mwNRikDGzhWkX8WE7sa1+enQgEoAkaM+lwF7veRvDKdXMoeVc6igbm5bmSir3B77rwsbYd12mFL84/5RyOhB3CCUm5s6f0lVpLmGejvAy8gIsHIT6JuP+hvvzS9bQJFu3ftNfXVUWKMP343lXhuNHfhLmuIFEv+cSuzGAV2iAtCb5s7V9Hx1aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778501243; c=relaxed/relaxed;
	bh=EejTLY3OBIlLpwEB0GNm1ilVJ/CzXgY7DxCgsyni+qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EcrQ4bSwurJrhNQ87+8EzxPQhZEr9C1eoI3J5FJhM8oPH3d9oAl+oaa+FdsxgEXaeAVtxpyj3mzY1lNLAeCabK9bGBRqUD98k7d74RMAHkTn8JNTheZDcnlRkhH2Hxc6iVaTwb19CNA1OJX+J8Q06/TGiL+AmBQBPQKKin/Zu4oM6OwkOCfh7NE+cLV3QBGyxBGq3z8JpNNu+sthVCBMc/od/yEfOQCLmHHwqXZr3+3WIewB8Z0gVeF9w55qIHWETAbq96pEF5xl/6q4G/Nt7UlXJDD/ZP9V61mS4QGBd5/ASVUYtFFqwvDGpXL7T8m+jyXisvxB8lcUO7iZnoqDKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org) smtp.mailfrom=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDdky3p1nz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 22:07:20 +1000 (AEST)
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8CAB84C1A0B1B4;
	Mon, 11 May 2026 14:06:29 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powernv: fix null pointer dereference in pnv_get_random_long()
Date: Mon, 11 May 2026 14:04:12 +0200
Message-ID: <20260511120413.254934-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pnv_get_random_long() dereferences the per-CPU pnv_rng pointer without
checking whether it has been initialized resulting in the oops below:

    [    0.000000] Linux version 7.1.0-rc2+ (pmenzel@flughafenberlinbrandenburgwillybrandt.molgen.mpg.de) (gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #3 SMP PREEMPT Wed May  6 08:50:58 CEST 2026
    […]
    [   17.901992] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
    [   17.902011] BUG: Kernel NULL pointer dereference on read at 0x00000000
    [   17.902018] Faulting instruction address: 0xc0000000000e7138
    [   17.902027] Oops: Kernel access of bad area, sig: 11 [#1]
    [   17.902034] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
    [   17.902045] Modules linked in: powernv_rng(+) bnx2x ofpart ibmpowernv bfq mdio cmdlinepart powernv_flash ipmi_powernv ipmi_devintf mtd ipmi_msghandler at24(+) vmx_crypto opal_prd sch_fq_codel nfsd parport_pc ppdev auth_rpcgss nfs_acl lp lockd grace parport sunrpc autofs4 btrfs xor libblake2b raid6_pq ast drm_shmem_helper drm_client_lib i2c_algo_bit drm_kms_helper drm ahci drm_panel_orientation_quirks libahci
    [   17.902185] CPU: 147 UID: 0 PID: 2626 Comm: hwrng Not tainted 7.1.0-rc2+ #3 PREEMPTLAZY
    [   17.902197] Hardware name: 8335-GCA POWER8 (raw) 0x4d0200 opal:skiboot-5.4.8-5787ad3 PowerNV
    [   17.902204] NIP:  c0000000000e7138 LR: c00800001ec8013c CTR: c0000000000e70fc
    [   17.902212] REGS: c000000092913c50 TRAP: 0300   Not tainted  (7.1.0-rc2+)
    [   17.902222] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44420220  XER: 20000000
    [   17.902269] CFAR: c00800001ec8026c DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
                   GPR00: c00800001ec8013c c000000092913ef0 c000000001c18100 c00000002222d900
                   GPR04: c00000002222d900 0000000000000080 0000000000000001 0000000000000000
                   GPR08: 0000000000000000 c000000002212000 c0000000951e1780 c00800001ec80258
                   GPR12: c0000000000e70fc c00000ffff6fd700 c0000000001d11c0 c00000001b99b9c0
                   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
                   GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
                   GPR24: 0000000000000000 c000000002fe6a58 0000000000000000 0000000000000000
                   GPR28: c000000002fe6a20 0000000000000010 000000000000000f c00000002222d900
    [   17.902406] NIP [c0000000000e7138] pnv_get_random_long+0x3c/0x114
    [   17.902426] LR [c00800001ec8013c] powernv_rng_read+0x78/0xc4 [powernv_rng]
    [   17.902444] Call Trace:
    [   17.902448] [c000000092913ef0] [c000000092913f30] 0xc000000092913f30 (unreliable)
    [   17.902463] [c000000092913f30] [c000000000decd58] hwrng_fillfn+0xd4/0x3dc
    [   17.902484] [c000000092913f90] [c0000000001d1328] kthread+0x170/0x1a4
    [   17.902498] [c000000092913fe0] [c00000000000d030] start_kernel_thread+0x14/0x18
    [   17.902513] Code: 60000000 7d2000a6 71290010 418200bc e94d0908 812a0000 39290001 912a0000 e90d0030 3d220060 39299f00 7d08482a <e9280000> 7c0004ac e8e90000 0c070000
    [   17.902569] ---[ end trace 0000000000000000 ]---
    [   18.008801] pstore: backend (nvram) writing error (-1)

    [   18.015458] note: hwrng[2626] exited with irqs disabled
    [   18.015483] note: hwrng[2626] exited with preempt_count 1

Commit f3eac426657d ("powerpc/powernv: wire up rng during setup_arch")
introduced a lazy initialization path via pnv_get_random_long_early():
per-CPU pointers are left NULL until slab becomes available and
rng_create() completes.

pnv_get_random_long() is an exported symbol called directly by the
powernv_rng hwrng module (powernv_rng_read()), bypassing the
ppc_md.get_random_seed guard that would otherwise ensure per-CPU data is
ready.  If the hwrng fill thread runs on a CPU whose slot is still NULL,
the function crashes dereferencing rng->regs at offset 0.

Guard both branches with a NULL check and return 0 (no data) when the
per-CPU pointer has not been set up yet.

Testing on the IBM Power S822LC (8335-GCA POWER8 (raw) 0x4d0200
opal:skiboot-5.4.8-5787ad3 PowerNV) is successful:

    [   23.850775] powernv_rng: Registered powernv hwrng.

Fixes: f3eac426657d ("powerpc/powernv: wire up rng during setup_arch")
Link: https://lore.kernel.org/all/a159e81a-ccfd-440f-af68-6a56cca09cb2@molgen.mpg.de/
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org # v5.18
Assisted-by: Claude Sonnet 4.6
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
No idea, how to test, that the rng works as expected (and if, despite
the missing message) it  didn’t work before.

 arch/powerpc/platforms/powernv/rng.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 7a4c38cd6a82..dc71eaf5d954 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -87,12 +87,16 @@ int pnv_get_random_long(unsigned long *v)
 
 	if (mfmsr() & MSR_DR) {
 		rng = get_cpu_var(pnv_rng);
-		*v = rng_whiten(rng, in_be64(rng->regs));
+		if (rng)
+			*v = rng_whiten(rng, in_be64(rng->regs));
 		put_cpu_var(rng);
-	} else {
-		rng = raw_cpu_read(pnv_rng);
-		*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));
+		return rng ? 1 : 0;
 	}
+
+	rng = raw_cpu_read(pnv_rng);
+	if (!rng)
+		return 0;
+	*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));
 	return 1;
 }
 EXPORT_SYMBOL_GPL(pnv_get_random_long);
-- 
2.53.0


