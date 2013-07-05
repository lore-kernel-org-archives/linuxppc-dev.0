Return-Path: <michael@ellerman.id.au>
Date: Fri, 5 Jul 2013 12:54:27 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] powerpc/perf: Add power8 EBB support
Message-ID: <20130705025427.GA27319@concordia>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
 <51CABB56.9010105@linux.vnet.ibm.com>
 <1372333965.29229.26.camel@concordia>
 <51CD0DC7.7020702@linux.vnet.ibm.com>
 <51D5C5B9.4070005@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51D5C5B9.4070005@linux.vnet.ibm.com>
Cc: ryanarn@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 04, 2013 at 03:58:01PM -0300, Adhemerval Zanella wrote:
> Hi Michael,
> 
> I believe you forgot to add the cpu_user_features2 bit to announce the EBB support
> for P8, patch following:

Hi Adhemerval,

You're right, I haven't added it. I was wondering how best to do it.

It's possible to configure the kernel so that it doesn't have PMU
support, and in that case EBB is unsupported. It's also possible that something
goes wrong with the PMU registration (kernel bug or OOM), and again EBB is then
unsupported.

So I think it might be better if we add PPC_FEATURE2_EBB at runtime in
init_power8_pmu().

What do you think?

Something like:

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index c7f8ccc..fd9ed89 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -620,10 +682,19 @@ static struct power_pmu power8_pmu = {
 
 static int __init init_power8_pmu(void)
 {
+       int rc;
+
        if (!cur_cpu_spec->oprofile_cpu_type ||
            strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
                return -ENODEV;
 
-       return register_power_pmu(&power8_pmu);
+       rc = register_power_pmu(&power8_pmu);
+       if (rc)
+               return rc;
+
+       /* Tell userspace that EBB is supported */
+       cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_EBB;
+
+       return 0;
 }
 early_initcall(init_power8_pmu);


cheers
