Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcPx06nYkzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 17:14:12 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f27so15970988pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 00:14:12 -0700 (PDT)
Date: Tue, 30 May 2017 17:13:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] cpuidle-powernv: Allow Deep stop states that don't
 stop time
Message-ID: <20170530171357.4e0b87a7@roar.ozlabs.ibm.com>
In-Reply-To: <3429547945465851cfcbf81f6e762037c395c8ac.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <3429547945465851cfcbf81f6e762037c395c8ac.1494585671.git.ego@linux.vnet.ibm.com>
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

On Tue, 16 May 2017 14:19:48 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The current code in the cpuidle-powernv intialization only allows deep
> stop states (indicated by OPAL_PM_STOP_INST_DEEP) which lose timebase
> (indicated by OPAL_PM_TIMEBASE_STOP). This assumption goes back to
> POWER8 time where deep states used to lose the timebase. However, on
> POWER9, we do have stop states that are deep (they lose hypervisor
> state) but retain the timebase.
> 
> Fix the initialization code in the cpuidle-powernv driver to allow
> such deep states.
> 
> Further, there is a bug in cpuidle-powernv driver with
> CONFIG_TICK_ONESHOT=n where we end up incrementing the nr_idle_states
> even if a platform idle state which loses time base was not added to
> the cpuidle table.
> 
> Fix this by ensuring that the nr_idle_states variable gets incremented
> only when the platform idle state was added to the cpuidle table.

Should this be a separate patch? Stable?

> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 12409a5..45eaf06 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -354,6 +354,7 @@ static int powernv_add_idle_states(void)
>  
>  	for (i = 0; i < dt_idle_states; i++) {
>  		unsigned int exit_latency, target_residency;
> +		bool stops_timebase = false;
>  		/*
>  		 * If an idle state has exit latency beyond
>  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> @@ -381,6 +382,9 @@ static int powernv_add_idle_states(void)
>  			}
>  		}
>  
> +		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
> +			stops_timebase = true;
> +
>  		/*
>  		 * For nap and fastsleep, use default target_residency
>  		 * values if f/w does not expose it.
> @@ -392,8 +396,7 @@ static int powernv_add_idle_states(void)
>  			add_powernv_state(nr_idle_states, "Nap",
>  					  CPUIDLE_FLAG_NONE, nap_loop,
>  					  target_residency, exit_latency, 0, 0);
> -		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
> -				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +		} else if (has_stop_states && !stops_timebase) {
>  			add_powernv_state(nr_idle_states, names[i],
>  					  CPUIDLE_FLAG_NONE, stop_loop,
>  					  target_residency, exit_latency,
> @@ -405,8 +408,8 @@ static int powernv_add_idle_states(void)
>  		 * within this config dependency check.
>  		 */
>  #ifdef CONFIG_TICK_ONESHOT
> -		if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
> -			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
> +		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
> +			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {

Hmm, seems okay but readability is isn't the best with the ifdef and
mixing power8 and 9 cases IMO.

Particularly with the nice regular POWER9 states, we're not doing much
logic in this loop besides checking for the timebase stop flag, right?
Would it be clearer if it was changed to something like this (untested
quick hack)?

---
 drivers/cpuidle/cpuidle-powernv.c | 76 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 12409a519cc5..77291389f9ac 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -353,7 +353,9 @@ static int powernv_add_idle_states(void)
 	}
 
 	for (i = 0; i < dt_idle_states; i++) {
+		unsigned int cpuidle_flags = CPUIDLE_FLAG_NONE;
 		unsigned int exit_latency, target_residency;
+
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
@@ -371,6 +373,16 @@ static int powernv_add_idle_states(void)
 		else
 			target_residency = 0;
 
+		if (flags[i] & OPAL_PM_TIMEBASE_STOP) {
+			/*
+			 * All cpuidle states with CPUIDLE_FLAG_TIMER_STOP set
+			 * depend on CONFIG_TICK_ONESHOT.
+			 */
+			if (!IS_ENABLED(CONFIG_TICK_ONESHOT))
+				continue;
+			cpuidle_flags = CPUIDLE_FLAG_TIMER_STOP;
+		}
+
 		if (has_stop_states) {
 			int err = validate_psscr_val_mask(&psscr_val[i],
 							  &psscr_mask[i],
@@ -379,50 +391,36 @@ static int powernv_add_idle_states(void)
 				report_invalid_psscr_val(psscr_val[i], err);
 				continue;
 			}
-		}
 
-		/*
-		 * For nap and fastsleep, use default target_residency
-		 * values if f/w does not expose it.
-		 */
-		if (flags[i] & OPAL_PM_NAP_ENABLED) {
-			if (!rc)
-				target_residency = 100;
-			/* Add NAP state */
-			add_powernv_state(nr_idle_states, "Nap",
-					  CPUIDLE_FLAG_NONE, nap_loop,
-					  target_residency, exit_latency, 0, 0);
-		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
-				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
 			add_powernv_state(nr_idle_states, names[i],
-					  CPUIDLE_FLAG_NONE, stop_loop,
-					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
-		}
-
-		/*
-		 * All cpuidle states with CPUIDLE_FLAG_TIMER_STOP set must come
-		 * within this config dependency check.
-		 */
-#ifdef CONFIG_TICK_ONESHOT
-		if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
-			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
-			if (!rc)
-				target_residency = 300000;
-			/* Add FASTSLEEP state */
-			add_powernv_state(nr_idle_states, "FastSleep",
-					  CPUIDLE_FLAG_TIMER_STOP,
-					  fastsleep_loop,
-					  target_residency, exit_latency, 0, 0);
-		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
-				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
-			add_powernv_state(nr_idle_states, names[i],
-					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
+					  cpuidle_flags, stop_loop,
 					  target_residency, exit_latency,
 					  psscr_val[i], psscr_mask[i]);
+			nr_idle_states++;
+		} else {
+			/*
+			 * For nap and fastsleep, use default target_residency
+			 * values if f/w does not expose it.
+			 */
+			if (flags[i] & OPAL_PM_NAP_ENABLED) {
+				if (!rc)
+					target_residency = 100;
+				/* Add NAP state */
+				add_powernv_state(nr_idle_states, "Nap",
+						  cpuidle_flags, nap_loop,
+						  target_residency, exit_latency, 0, 0);
+				nr_idle_states++;
+			} else if (flags[i] & (OPAL_PM_SLEEP_ENABLED |
+						OPAL_PM_SLEEP_ENABLED_ER1)) {
+				if (!rc)
+					target_residency = 300000;
+				/* Add FASTSLEEP state */
+				add_powernv_state(nr_idle_states, "FastSleep",
+						  cpuidle_flags, fastsleep_loop,
+						  target_residency, exit_latency, 0, 0);
+				nr_idle_states++;
+			}
 		}
-#endif
-		nr_idle_states++;
 	}
 out:
 	return nr_idle_states;
-- 
2.11.0
