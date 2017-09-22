Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz9cx36n9zDrGy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:05:37 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id q29so217899uaf.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:05:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922033221.31609-1-mikey@neuling.org>
References: <20170922033221.31609-1-mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 22 Sep 2017 21:05:33 +1000
Message-ID: <CAKTCnznis_M=p94Ruf5d31JHuPsoo0v62uZ4orQ4Y9vz3aR7dQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: Handle MCE on POWER9 with only DSISR bit 33
 set
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <nicholas.piggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 22, 2017 at 1:32 PM, Michael Neuling <mikey@neuling.org> wrote:
> On POWER9 DD2.1 and below, it's possible for a paste instruction to
> cause a Machine Check Exception (MCE) where only DSISR bit 33 is
> set. This will result in the MCE handler seeing an unknown event,
> which triggers linux to crash.
>
> We change this by detecting unknown events caused by load/stores in
> the MCE handler and marking them as handled so that we no longer
> crash.
>
> An MCE that occurs like this is spurious, so we don't need to do
> anything in terms of servicing it. If there is something that needs to
> be serviced, the CPU will raise the MCE again with the correct DSISR
> so that it can be serviced properly.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com
> --
> v3: Simplification and SRR1 check suggestions from Nick
> v2: update commit message based on Balbir's comments
> ---
>  arch/powerpc/kernel/mce_power.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index b76ca198e0..e423cf0e43 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -624,5 +624,15 @@ long __machine_check_early_realmode_p8(struct pt_regs *regs)
>
>  long __machine_check_early_realmode_p9(struct pt_regs *regs)
>  {
> +       /*
> +        * On POWER9 DD2.1 and below, it's possible to get machine
> +        * check caused by a paste instruction where only DSISR bit 33
> +        * is set. This will result in the MCE handler seeing an
> +        * unknown event and us crashing.  Change this to mark as
> +        * handled.
> +        */
> +       if (SRR1_MC_LOADSTORE(regs->msr) && regs->dsisr == 0x40000000)
> +               return 1;
> +

Acked-by: Balbir SIngh <bsingharora@gmail.com>
