Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjc7P1cw9zDqpB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 16:10:09 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i123so15539345pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jul 2016 23:10:09 -0700 (PDT)
Subject: Re: [PATCH v5] cpuidle: Fix last_residency division
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
References: <1467383054-1959-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 daniel.lezcano@linaro.org, nicolas.pitre@linaro.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5102d9f9-3b38-17c3-98ce-cceb073da764@gmail.com>
Date: Mon, 4 Jul 2016 16:10:00 +1000
MIME-Version: 1.0
In-Reply-To: <1467383054-1959-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/07/16 00:24, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereby
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exits
> due to this timeout, its last_residency will be target_residency of next
> deeper state.
> 
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
> changed the math around last_residency calculation. Specifically, while
> converting last_residency value from nanoseconds to microseconds it does
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency of
> next available state. This pattern is picked up get_typical_interval()
> in the menu governor and therefore expected_interval in menu_select() is
> frequently less than the target_residency of any state but snooze.
> 
> Due to this we are entering snooze at a higher rate, thereby affecting
> the single thread performance.
> 
> Fix this by using precise division via ktime_us_delta.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---

This looks so much cleaner :)

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir
