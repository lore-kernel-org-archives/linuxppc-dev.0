Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJcZ6Tr3zDqlN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:13:50 +1000 (AEST)
Received: by mail-vk0-x242.google.com with SMTP id 78so860729vkc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 03:13:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915052549.8105-2-mikey@neuling.org>
References: <20170915052549.8105-1-mikey@neuling.org>
 <20170915052549.8105-2-mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 19 Sep 2017 20:13:47 +1000
Message-ID: <CAKTCnz=8vDAb45wgq1NsoKUwaJFfwUvZoGJ44ip54UPc5wg6PQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Handle MCE on POWER9 with only DSISR bit 33
 set
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 15, 2017 at 3:25 PM, Michael Neuling <mikey@neuling.org> wrote:
> On POWER9 DD2.1 and below, it's possible to get Machine Check
> Exception (MCE) where only DSISR bit 33 is set. This will result in
> the linux MCE handler seeing an unknown event, which triggers linux to
> crash.
>
> We change this by detecting unknown events in the MCE handler and
> marking them as handled so that we no longer crash. We do this only on
> chip revisions known to have this problem.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/kernel/mce_power.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index b76ca198e0..72ec667136 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -595,6 +595,7 @@ static long mce_handle_error(struct pt_regs *regs,
>         uint64_t addr;
>         uint64_t srr1 = regs->msr;
>         long handled;
> +       unsigned long pvr;
>
>         if (SRR1_MC_LOADSTORE(srr1))
>                 handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
> @@ -604,6 +605,20 @@ static long mce_handle_error(struct pt_regs *regs,
>         if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
>                 handled = mce_handle_ue_error(regs);
>
> +       /*
> +        * On POWER9 DD2.1 and below, it's possible to get machine
> +        * check where only DSISR bit 33 is set. This will result in
> +        * the MCE handler seeing an unknown event and us crashing.
> +        * Change this to mark as handled on these revisions.
> +        */
> +       pvr = mfspr(SPRN_PVR);
> +       if (((PVR_VER(pvr) == PVR_POWER9) &&
> +            (PVR_CFG(pvr) == 2) &&
> +            (PVR_MIN(pvr) <= 1)) || cpu_has_feature(CPU_FTR_POWER9_DD1))
> +               /* DD2.1 and below */
> +               if (mce_err.error_type == MCE_ERROR_TYPE_UNKNOWN)
> +                   handled = 1;
> +

What does this mean in terms of handling? Since we do not know the event,
how do we recover/handle? The system will anyway crash for not-recovered
cases. Does this prevent us from seeing the same exception several times?

Balbir Singh.
