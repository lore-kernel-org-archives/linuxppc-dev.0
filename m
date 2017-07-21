Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDCXp35WrzDrHw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 11:16:58 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id a11so3590902pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 18:16:58 -0700 (PDT)
Date: Fri, 21 Jul 2017 11:16:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: energy driver only print message when
 LPAR guest
Message-ID: <20170721111644.2a6a6610@roar.ozlabs.ibm.com>
In-Reply-To: <87eftbgt0m.fsf@concordia.ellerman.id.au>
References: <20170720115900.455-1-npiggin@gmail.com>
 <87eftbgt0m.fsf@concordia.ellerman.id.au>
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

On Thu, 20 Jul 2017 23:03:21 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > This driver currently reports the H_BEST_ENERGY is unsupported even
> > when booting in a non-LPAR environment (e.g., powernv). Prevent it.  
> 
> Just delete the printk(). Users don't know what that means, and
> developers have other better ways to detect that the hcall is missing if
> anyone cares.
> 
> cheers

powerpc/pseries: energy driver do not print failure message

This driver currently reports the H_BEST_ENERGY is unsupported (even
when booting in a non-LPAR environment). This is not something the
administrator can do much with, and not significant for debugging.

Remove it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 164a13d3998a..35c891aabef0 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -229,10 +229,9 @@ static int __init pseries_energy_init(void)
 	int cpu, err;
 	struct device *cpu_dev;
 
-	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY)) {
-		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
-		return 0;
-	}
+	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY))
+		return 0; /* H_BEST_ENERGY hcall not supported */
+
 	/* Create the sysfs files */
 	err = device_create_file(cpu_subsys.dev_root,
 				&attr_cpu_activate_hint_list);
-- 
2.11.0
