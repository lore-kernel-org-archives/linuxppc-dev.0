Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FB61A004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 20:41:23 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id j17so10552616oag.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 03:41:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpokMXSC_oTbg1b0adPxFsht7aZJd61YwSpzqsUi=KOAwXw@mail.gmail.com>
References: <1408015178-21745-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohponDNHYrD9b==cp+pVmAi2ygA9-HcLZWqr4w3DDivB=-Ng@mail.gmail.com>
 <53F57E51.4060200@gmail.com>
 <CAKohpon8ANWoy52B=_nSuNyHALrsQOLX4cA+690E=CifnVRFtg@mail.gmail.com>
 <53F6AF66.10204@linux.vnet.ibm.com>
 <CAKohpokMXSC_oTbg1b0adPxFsht7aZJd61YwSpzqsUi=KOAwXw@mail.gmail.com>
Date: Mon, 25 Aug 2014 16:11:21 +0530
Message-ID: <CAKohponpWL1Wjo=HcDrwDYvuykRVPMVSeEzKDWg1Mi075c8KEA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Register the driver with reboot notifier
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Shilpasri G Bhat <shilpabhatppc@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25 August 2014 16:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Its not that I am doubting if this will work or not. But this Hack is using
> routines not meant for this purpose. And that being a core routine,
> things aren't that straightforward anymore.

Well if you want a working HACK for solving this, what about following ?

diff --git a/drivers/cpufreq/powernv-cpufreq.c
b/drivers/cpufreq/powernv-cpufreq.c
index af49688..d6a1742 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -34,6 +34,7 @@
 #define POWERNV_MAX_PSTATES    256

 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
+static bool rebooting;

 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -283,6 +284,9 @@ static int powernv_cpufreq_target_index(struct
cpufreq_policy *policy,
 {
        struct powernv_smp_call_data freq_data;

+       if (unlikely(rebooting))
+               return -EBUSY;
+
        freq_data.pstate_id = powernv_freqs[new_index].driver_data;

        /*
@@ -317,6 +321,19 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
        .attr           = powernv_cpu_freq_attr,
 };

+static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
+               unsigned long action, void *unused)
+{
+       /* TODO: Get policy & index */
+       powernv_cpufreq_target_index(policy, index);
+       rebooting = true;
+       return NOTIFY_DONE;
+}
+
+static struct notifier_block powernv_cpufreq_reboot_nb = {
+       .notifier_call = powernv_cpufreq_reboot_notifier,
+};
+
 static int __init powernv_cpufreq_init(void)
 {
        int rc = 0;
@@ -328,12 +345,15 @@ static int __init powernv_cpufreq_init(void)
                return rc;
        }

-       return cpufreq_register_driver(&powernv_cpufreq_driver);
+       rc = cpufreq_register_driver(&powernv_cpufreq_driver);
+       register_reboot_notifier(&powernv_cpufreq_reboot_nb);
+       return rc;
 }
 module_init(powernv_cpufreq_init);

 static void __exit powernv_cpufreq_exit(void)
 {
+       unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
        cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
