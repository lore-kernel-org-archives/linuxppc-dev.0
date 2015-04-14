Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC35D1A0BDE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 18:27:19 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:27:17 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6376E1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:18:25 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E8PMhJ29229090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 01:25:22 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E8RDYK028572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:27:14 -0600
Message-ID: <552CCF5E.5040201@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 13:57:10 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On 04/14/2015 07:26 AM, Shreyas B. Prabhu wrote:
> +	 * fastsleep_workaround_state = WORKAROUND_APPLYONCE implies
> +	 * fastsleep workaround needs to be left in 'applied' state on all
> +	 * the cores. Do this by-
> +	 * 1. Patching out the call to 'undo' workaround in fastsleep exit path
> +	 * 2. Sending ipi to all the cores which have atleast one online thread
> +	 * 3. Patching out the call to 'apply' workaround in fastsleep entry
> +	 * path
> +	 * There is no need to send ipi to cores which have all threads
> +	 * offlined, as last thread of the core entering fastsleep or deeper
> +	 * state would have applied workaround.
> +	 */
> +	err = patch_instruction(
> +		(unsigned int *)pnv_fastsleep_workaround_at_exit,
> +		PPC_INST_NOP);
> +	if (err) {
> +		pr_err("fastsleep_workaround_state change failed while patching pnv_fastsleep_workaround_at_exit");
> +		goto fail;
> +	}
> +
> +	primary_thread_mask = cpu_online_cores_map();
> +	on_each_cpu_mask(&primary_thread_mask,
> +				pnv_fastsleep_workaround_apply,
> +				&err, 1);
> +	if (err) {
> +		pr_err("fastsleep_workaround_state change failed while running pnv_fastsleep_workaround_apply");
> +		goto fail;
> +	}
> +
> +	err = patch_instruction(
> +		(unsigned int *)pnv_fastsleep_workaround_at_entry,
> +		PPC_INST_NOP);
> +	if (err) {
> +		pr_err("fastsleep_workaround_state change failed while patching pnv_fastsleep_workaround_at_entry");
> +		goto fail;
> +	}

A point that bothers me here is if we can potentially race with cpu
hotplug ? If cpuX and its siblings are offline and it was interrupted to
come online:

cpuX                                     cpuY
Interrupted to come online
Undo workaround

                                Nop the fastsleep_workaround_exit path
                                IPI online cores: apply workaround once

Set yourself in the online mask
                                Nop the fastsleep_workaround_entry path


This results in cpuX undoing the workaround on its core, never to set it
back again.

So should we protect the region between the beginning and end of
patching instructions with get_online_cpus() and put_online_cpus() ?

Regards
Preeti U Murthy
