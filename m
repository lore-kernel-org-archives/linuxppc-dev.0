Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 338761A006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 21:33:24 +1000 (EST)
Received: by mail-ob0-f169.google.com with SMTP id wp18so5192666obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 04:33:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1410430423-1246-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1410430423-1246-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 11 Sep 2014 17:03:22 +0530
Message-ID: <CAKohpo=uB252XLfx3tHPA8uk5RPkWB0SPQ_UxzVw70c-DWuHWg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: powernv: Set the cpus to nominal frequency
 during reboot/kexec
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11 September 2014 15:43, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> This patch ensures the cpus to kexec/reboot at nominal frequency.
> Nominal frequency is the highest cpu frequency on PowerPC at
> which the cores can run without getting throttled.
>
> If the host kernel had set the cpus to a low pstate and then it
> kexecs/reboots to a cpufreq disabled kernel it would cause the target
> kernel to perform poorly. It will also increase the boot up time of
> the target kernel. So set the cpus to high pstate, in this case to
> nominal frequency before rebooting to avoid such scenarios.
>
> The reboot notifier will set the cpus to nominal frequncy.
>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Changes v2->v3:
> We return EBUSY when cpufreq governor tries to change the frequency
> after rebooting is set to true. This results in console being flushed
> with error messages indicating failed attempts to change the
> frequency. So instead of returning EBUSY we return 0 to stop the
> governor from changing the frequency without alerting a failure to
> do the same on reboot, as this  is not an errorneaos condition.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
