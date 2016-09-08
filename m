Return-Path: <shreyasbp@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sV3h73BqkzDsT1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 12:10:15 +1000 (AEST)
Received: by mail-oi0-x229.google.com with SMTP id s131so52158496oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 19:10:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1473225390-4281-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1473225390-4281-1-git-send-email-ego@linux.vnet.ibm.com>
From: "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Date: Wed, 7 Sep 2016 22:10:12 -0400
Message-ID: <CAAVMmb62-S76f+7G7tf9Npd1ic7_+oAdo3NfGhizEm5iYhhf1g@mail.gmail.com>
Subject: Re: [PATCH] powernv: Restore SPRs correctly upon wake up from
 hypervisor state loss
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gautham,

Thanks for fixing this.

On Wed, Sep 7, 2016 at 1:16 AM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> pnv_wakeup_tb_loss function currently expects the cr4 to be "eq" if
> the CPU is waking up from a complete hypervisor state loss. Hence, it
> currently restores the SPR contents only if cr4 is "eq".
>
> However, after the commit bcef83a00dc4 ("powerpc/powernv: Add platform
> support for stop instruction"), on ISA_V300 CPUs, the function
> pnv_restore_hyp_resource sets cr4 to contain the result of the
> comparison between state the CPU has woken up and the first deepest
> stop state before calling pnv_wakeup_tb_loss.
>
> Thus if the CPU woke up from a state that is deeper than the first
> deepest stop state, cr4 have "gt" set and hence, pnv_wakeup_tb_loss
> will fail to restore the SPRs on waking up from such a state.
>
> Fix the code in pnv_wakeup_tb_loss to restore the SPR states when cr4 is
> "eq" or "gt".
>
> Fixes: Commit bcef83a00dc4 ("powerpc/powernv: Add platform support for
> stop instruction")
>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Cc: Michael Neuling <michael.neuling@au1.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shreyas B. Prabhu <shreyasbp@gmail.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---

Reviewed-by: Shreyas B. Prabhu <shreyasbp@gmail.com>


Thanks,
Shreyas
