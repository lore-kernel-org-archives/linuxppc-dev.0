Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C03AF1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 15:12:37 +1000 (AEST)
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45738140283
 for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2015 15:12:36 +1000 (AEST)
Received: by oica37 with SMTP id a37so50719001oic.0
 for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2015 22:12:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Fri, 8 May 2015 10:42:34 +0530
Message-ID: <CAKohpokZcJeCEaKnfQC-78s2KKCJ9a7UqSA_R8VbjEX2HUGVNQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] powernv: cpufreq: Report frequency throttle by OCC
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4 May 2015 at 14:24, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:
> This patchset intends to add frequency throttle reporting mechanism
> to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
> On-Chip-Controller which takes care of the power and thermal safety of
> the chip. The CPU frequency can be throttled during an OCC reset or
> when OCC tries to limit the max allowed frequency. The patchset will
> report such conditions so as to keep the user informed about reason
> for the drop in performance of workloads when frequency is throttled.
>
> Changes from v2:
> - Split into multiple patches
> - Semantic fixes
>
> Shilpasri G Bhat (6):
>   cpufreq: poowernv: Handle throttling due to Pmax capping at chip level
>   powerpc/powernv: Add definition of OPAL_MSG_OCC message type
>   cpufreq: powernv: Register for OCC related opal_message notification
>   cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
>   cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is
>     set
>   cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling
>
>  arch/powerpc/include/asm/opal-api.h |   8 ++
>  drivers/cpufreq/powernv-cpufreq.c   | 199 +++++++++++++++++++++++++++++++++---
>  2 files changed, 192 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
