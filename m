Return-Path: <stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vxGS5NFCzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 11:39:12 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4T1cm7O109701
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 21:39:10 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j8s5vq2mx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 21:39:09 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Mon, 28 May 2018 21:39:09 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : Add Description for cpuidle state
In-Reply-To: <20180528173442.100642-1-huntbag@linux.vnet.ibm.com>
References: <20180528173442.100642-1-huntbag@linux.vnet.ibm.com>
Date: Tue, 29 May 2018 11:39:01 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d0xf6y16.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abhishek Goel <huntbag@linux.vnet.ibm.com> writes:
> @@ -215,7 +216,7 @@ static inline void add_powernv_state(int index, const char *name,
>  				     u64 psscr_val, u64 psscr_mask)
>  {
>  	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> -	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
> +	strlcpy(powernv_states[index].desc, desc, CPUIDLE_DESC_LEN);

We should still fall back to using name in the event of desc being null,
as not all firmware will expose the descriptions.

> @@ -311,6 +313,11 @@ static int powernv_add_idle_states(void)
>  		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
>  		goto out;
>  	}
> +	if (of_property_read_string_array(power_mgt,
> +		"ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n");
> +		goto out;
> +	}

I don't think pr_warn is appropriate here, as for all current released
firmware we don't have that property. I think perhaps just silently
continuing on is okay, as we have to keep compatibility with that firmware.

> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -17,7 +17,7 @@
>
>  #define CPUIDLE_STATE_MAX	10
>  #define CPUIDLE_NAME_LEN	16
> -#define CPUIDLE_DESC_LEN	32
> +#define CPUIDLE_DESC_LEN	60

Do we really get that long?

-- 
Stewart Smith
OPAL Architect, IBM.
