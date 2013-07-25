Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9018F2C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 18:00:48 +1000 (EST)
Message-ID: <51F0DAF1.9060702@asianux.com>
Date: Thu, 25 Jul 2013 15:59:45 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com> <51ECD664.7040708@linux.vnet.ibm.com>
 <20130723134431.GF31944@concordia> <51EF1F97.3070409@asianux.com>
 <20130724011640.GA6042@concordia> <51EF375D.9060006@asianux.com>
 <20130725031501.GA15673@concordia> <1374729381.6142.59.camel@pasglop>
 <51F0B68F.4000402@asianux.com> <1374731505.6142.64.camel@pasglop>
 <51F0C2E8.3050005@asianux.com> <1374737592.6142.67.camel@pasglop>
In-Reply-To: <1374737592.6142.67.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: chenhui.zhao@freescale.com, "paulus@samba.org" <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 03:33 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-25 at 14:17 +0800, Chen Gang wrote:
>> > 
>> > Hmm... for an extern function (espeically have been implemented in
>> > various modules), normally, we can assume it may fail in some cases
>> > (although now, we don't know what cases can cause its failure).
>> > 
>> > If "we don't have a good way to handle the failure", "print the related
>> > warning message" is an executable choice (or "BUG_ON()", if it is critical).
>> > 
>> > So, if the performance is not sensible, I still suggest to let extern
>> > function have return value.
> This is not a module function. We are not doing a uni course on how to
> write C code here. Be real.

In our case, 'module' points to various sub directories of arch/powerpc
(maybe 'module' is not quite precise, it is easy misunderstand).

The real world is not conflict with "how to write C code".

For my opinion: one fix may like below (assume have removed max_cpus)
which is more reasonable for code readers.

-----------------------------diff begin------------------------------

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7edbd5b..53155f4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -347,7 +347,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
 
 	if (smp_ops && smp_ops->probe)
-		smp_ops->probe();
+		BUG_ON(smp_ops->probe() < 0);
 }
 
 void smp_prepare_boot_cpu(void)

-----------------------------diff end--------------------------------


Thanks
-- 
Chen Gang
