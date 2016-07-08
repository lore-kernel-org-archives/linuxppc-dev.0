Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlzL42jXnzDr5F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 12:42:36 +1000 (AEST)
Message-ID: <1467945755.27479.160.camel@neuling.org>
Subject: Re: [PATCH v7 09/11] cpuidle/powernv: cleanup powernv_add_idle_states
From: Michael Neuling <mikey@neuling.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Date: Fri, 08 Jul 2016 12:42:35 +1000
In-Reply-To: <1467924432-29003-10-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467924432-29003-10-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> =C2=A0		/*
> @@ -230,7 +238,7 @@ static int powernv_add_idle_states(void)
> =C2=A0			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
> =C2=A0			powernv_states[nr_idle_states].flags =3D CPUIDLE_FLAG_TIMER_STOP=
;
> =C2=A0			powernv_states[nr_idle_states].target_residency =3D 300000;
> -			powernv_states[nr_idle_states].enter =3D &fastsleep_loop;
> +			powernv_states[nr_idle_states].enter =3D fastsleep_loop;

You can change this code too with the same thing.

static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] =3D {
	{ /* Snooze */
		.name =3D "snooze",
		.desc =3D "snooze",
		.exit_latency =3D 0,
		.target_residency =3D 0,
		.enter =3D &snooze_loop },
};

Mikey
