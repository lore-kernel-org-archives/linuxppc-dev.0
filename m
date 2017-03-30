Return-Path: <nicstange@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvFgF47ySzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 06:53:29 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id p52so15034665wrc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 12:53:29 -0700 (PDT)
From: Nicolai Stange <nicstange@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
 Nicolai Stange <nicstange@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/time: set ->min_delta_ticks and ->max_delta_ticks
Date: Thu, 30 Mar 2017 21:53:17 +0200
Message-Id: <20170330195317.7328-1-nicstange@gmail.com>
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the powerpc arch's clockevent driver initialize these fields properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from this
driver.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 arch/powerpc/kernel/time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 07b90725855e..2b33cfaac7b8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -995,8 +995,10 @@ static void __init init_decrementer_clockevent(void)
 
 	decrementer_clockevent.max_delta_ns =
 		clockevent_delta2ns(decrementer_max, &decrementer_clockevent);
+	decrementer_clockevent.max_delta_ticks = decrementer_max;
 	decrementer_clockevent.min_delta_ns =
 		clockevent_delta2ns(2, &decrementer_clockevent);
+	decrementer_clockevent.min_delta_ticks = 2;
 
 	register_decrementer_clockevent(cpu);
 }
-- 
2.12.0
