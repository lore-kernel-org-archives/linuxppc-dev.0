Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D4392C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 01:53:32 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id va7so2132667obc.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2013 07:53:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <514F0FB0.8030109@gmail.com>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
 <514F0FB0.8030109@gmail.com>
Date: Sun, 24 Mar 2013 20:23:27 +0530
Message-ID: <CAKohpomznLtxYZYx31xg+V5FesNiMwOqNDN0QNqOqUw_7g4Uhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Francesco Lavra <francescolavra.fl@gmail.com>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Liviu.Dudau@arm.com, Steve.Bannister@arm.com,
 sparclinux@vger.kernel.org, arvind.chauhan@arm.com,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Jesper Nilsson <jesper.nilsson@axis.com>, robin.randhawa@arm.com,
 Stephen Warren <swarren@wwwdotorg.org>, cpufreq@vger.kernel.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, cbe-oss-dev@lists.ozlabs.org,
 Fenghua Yu <fenghua.yu@intel.com>, linaro-kernel@lists.linaro.org,
 Mike Frysinger <vapier@gentoo.org>, linux-pm@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, rjw@sisk.pl,
 Kukjin Kim <kgene.kim@samsung.com>, Borislav Petkov <bp@alien8.de>,
 Ben Dooks <ben-linux@fluff.org>, Thomas Renninger <trenn@suse.de>,
 linux-arm-kernel@lists.infradead.org, Mikael Starvik <starvik@axis.com>,
 Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 Sascha Hauer <kernel@pengutronix.de>, charles.garcia-tobin@arm.com,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24 March 2013 20:07, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
> On 03/24/2013 02:48 PM, Viresh Kumar wrote:
>> policy->cpus contains all online cpus that have single shared clock line. And
>> their frequencies are always updated together.
>>
>> Many SMP system's cpufreq drivers take care of this in individual drivers but
>> the best place for this code is in cpufreq core.
>>
>> This patch modifies cpufreq_notify_transition() to notify frequency change for
>> all cpus in policy->cpus and hence updates all users of this API.

One thing about this work. I compiled it for ARM and Intel. Also this
stuff is tested
by "Fengguang Wu" <fengguang.wu@intel.com> automated build system.

I am not sure if that builds all architectures or not.
I tried to review my patch closely but their can be some minor mistakes.

I thought of adding this in the patch details but forgot at last.

Is their a simple way to compile stuff for all platforms? Sorry i am
not aware of
it :(

>> diff --git a/arch/blackfin/mach-common/cpufreq.c b/arch/blackfin/mach-common/cpufreq.c
>> +     ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
>> +     if (ret != 0) {
>> +             WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
>> +             break;
>
> This doesn't even compile, as the break statement isn't in the
> for_each_online_cpu() loop anymore.

I tried to review it very carefully but this situation was a bit tricky :)
Thanks for trying it out.

Following should fix it for you:

commit 942ca8a6bc87e3c42beabc9102755136493e5355
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Sun Mar 24 20:21:43 2013 +0530

    fixup! cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
---
 arch/blackfin/mach-common/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/blackfin/mach-common/cpufreq.c
b/arch/blackfin/mach-common/cpufreq.c
index 4e67368..995511e80 100644
--- a/arch/blackfin/mach-common/cpufreq.c
+++ b/arch/blackfin/mach-common/cpufreq.c
@@ -164,7 +164,7 @@ static int bfin_target(struct cpufreq_policy *policy,
        ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
        if (ret != 0) {
                WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
-               break;
+               return ret;
        }
 #endif
        on_each_cpu(bfin_adjust_core_timer, &index, 1);


@Rafael: Let me add fixups for now, i will send final patch later after others
also review their part.
