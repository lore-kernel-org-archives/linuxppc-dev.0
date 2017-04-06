Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzGLg4BsbzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 18:38:03 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v368Y3TK008755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 04:37:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ngxq4syg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 04:37:48 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 02:37:47 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 03/11] powerpc/powernv: Detect supported IMC units and
 its events
In-Reply-To: <1491231308-15282-4-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-4-git-send-email-maddy@linux.vnet.ibm.com>
Date: Thu, 06 Apr 2017 18:37:34 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r316hqy9.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -33,6 +33,388 @@
<snip>
> +static void imc_pmu_setup(struct device_node *parent)
> +{
> +	struct device_node *child;
> +	int pmu_count = 0, rc = 0;
> +	const struct property *pp;
> +
> +	if (!parent)
> +		return;
> +
> +	/* Setup all the IMC pmus */
> +	for_each_child_of_node(parent, child) {
> +		pp = of_get_property(child, "compatible", NULL);
> +		if (pp) {
> +			/*
> +			 * If there is a node with a "compatible" field,
> +			 * that's a PMU node
> +			 */
> +			rc = imc_pmu_create(child, pmu_count);
> +			if (rc)
> +				return;
> +			pmu_count++;
> +		}
> +	}
> +}

This doesn't strike me as the right kind of structure, the presence of a
compatible property really just says "hey, there's this device and it's
compatible with these ways of accessing it".

I'm guessing the idea behind having imc-nest-offset/size in a top level
node is because it's common to everything under it and the aim is to not
blow up the device tree to be enormous.

So why not go after each ibm,imc-counters-nest compatible node under the
top level ibm,opal-in-memory-counters node? (i'm not convinced that
having ibm,ibmc-counters-nest versus ibm,imc-counters-core and
ibm,imc-counters-thread as I see in the dts is correct though, as
they're all accessed exactly the same way?)

-- 
Stewart Smith
OPAL Architect, IBM.
