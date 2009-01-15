Return-Path: <dan.j.williams@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 0E0EE474D2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 08:51:40 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1348963wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 13:51:39 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <200812090057.33890.yur@emcraft.com>
References: <200812090057.33890.yur@emcraft.com>
Date: Thu, 15 Jan 2009 14:51:39 -0700
Message-ID: <e9c3a7c20901151351p5e1b4641h1b4c8ba1ae5dcc73@mail.gmail.com>
Subject: Re: [PATCH 07/11] md: rewrite handle_stripe_dirtying6 in asynchronous
	way
From: Dan Williams <dan.j.williams@intel.com>
To: Yuri Tikhonov <yur@emcraft.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 8, 2008 at 2:57 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
> Rewrite handle_stripe_dirtying6 function to work asynchronously.
>
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  drivers/md/raid5.c |  113 ++++++++++++++--------------------------------------
>  1 files changed, 30 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index e08ed4f..f0b47bd 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2485,99 +2485,46 @@ static void handle_stripe_dirtying6(raid5_conf_t *conf,
>                struct stripe_head *sh, struct stripe_head_state *s,
>                struct r6_state *r6s, int disks)
>  {
> -       int rcw = 0, must_compute = 0, pd_idx = sh->pd_idx, i;
> +       int rcw = 0, pd_idx = sh->pd_idx, i;
>        int qd_idx = r6s->qd_idx;
> +
> +       set_bit(STRIPE_HANDLE, &sh->state);
>        for (i = disks; i--; ) {
>                struct r5dev *dev = &sh->dev[i];
> -               /* Would I have to read this buffer for reconstruct_write */
> -               if (!test_bit(R5_OVERWRITE, &dev->flags)
> -                   && i != pd_idx && i != qd_idx
> -                   && (!test_bit(R5_LOCKED, &dev->flags)
> -                           ) &&
> -                   !test_bit(R5_UPTODATE, &dev->flags)) {
> -                       if (test_bit(R5_Insync, &dev->flags)) rcw++;
> -                       else {
> -                               pr_debug("raid6: must_compute: "
> -                                       "disk %d flags=%#lx\n", i, dev->flags);
> -                               must_compute++;
> +               /* check if we haven't enough data */
> +               if (!test_bit(R5_OVERWRITE, &dev->flags) &&
> +                   i != pd_idx && i != qd_idx &&
> +                   !test_bit(R5_LOCKED, &dev->flags) &&
> +                   !(test_bit(R5_UPTODATE, &dev->flags) ||
> +                     test_bit(R5_Wantcompute, &dev->flags))) {
> +                       rcw++;
> +                       if (!test_bit(R5_Insync, &dev->flags))
> +                               continue; /* it's a failed drive */
> +
> +                       if (
> +                         test_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
> +                               pr_debug("Read_old stripe %llu "
> +                                       "block %d for Reconstruct\n",
> +                                    (unsigned long long)sh->sector, i);
> +                               set_bit(R5_LOCKED, &dev->flags);
> +                               set_bit(R5_Wantread, &dev->flags);
> +                               s->locked++;
> +                       } else {
> +                               pr_debug("Request delayed stripe %llu "
> +                                       "block %d for Reconstruct\n",
> +                                    (unsigned long long)sh->sector, i);
> +                               set_bit(STRIPE_DELAYED, &sh->state);
> +                               set_bit(STRIPE_HANDLE, &sh->state);

What's the reasoning behind changing the logic here, i.e. removing
must_compute and such?  I'd feel more comfortable seeing copy and
paste where possible with cleanups separated out into their own patch.

--
Dan
