Return-Path: <dan.j.williams@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 291BDDE1C7
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 05:39:55 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so1359665wag.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 10:39:54 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1141743016.20090116172403@emcraft.com>
References: <200812090057.33890.yur@emcraft.com>
	<e9c3a7c20901151351p5e1b4641h1b4c8ba1ae5dcc73@mail.gmail.com>
	<e9c3a7c20901151421o69522f71rfe6d7d9621de47eb@mail.gmail.com>
	<1141743016.20090116172403@emcraft.com>
Date: Fri, 16 Jan 2009 11:39:54 -0700
Message-ID: <e9c3a7c20901161039t1ad9d8dawaf7fb9823583db49@mail.gmail.com>
Subject: Re: Re[2]: [PATCH 07/11] md: rewrite handle_stripe_dirtying6 in
	asynchronous way
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

On Fri, Jan 16, 2009 at 7:24 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
>> Ok, I now see why this change was made.  Please make this changelog
>> more descriptive than "Rewrite handle_stripe_dirtying6 function to
>> work asynchronously."
>
>  Sure, how about the following:
>
> "
>
>  md: rewrite handle_stripe_dirtying6 in asynchronous way
>
>  Processing stripe dirtying in asynchronous way requires some changes
> to the handle_stripe_dirtying6() algorithm.
>
>  In the synchronous implementation of the stripe dirtying we processed
> dirtying of a degraded stripe (with partially changed strip(s) located
> on the failed drive(s)) inside one handle_stripe_dirtying6() call:
> - we computed the missed strips from the old parities, and thus got
> the fully up-to-date stripe, then
> - we did reconstruction using the new data to write.
>
>  In the asynchronous case of handle_stripe_dirtying6() we don't
> process anything right inside this function (since we under the lock),
> but only schedule the necessary operations with flags. Thus, if
> handle_stripe_dirtying6() is performed on the top of a degraded array
> we should schedule the reconstruction operation when the failed strips
> are marked (by previously called fetch_block6()) as to be computed
> (with the R5_Wantcompute flag), and all the other strips of the stripe
> are UPTODATE. The schedule_reconstruction() function will set the
> STRIPE_OP_POSTXOR flag [for new parity calculation], which is then
> handled in raid_run_ops() after the STRIPE_OP_COMPUTE_BLK one [which
> causes computing of the data missed].
>
> "

Excellent!

Thanks,
Dan
