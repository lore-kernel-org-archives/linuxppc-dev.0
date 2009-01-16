Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7757ADDFE0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 01:24:06 +1100 (EST)
Date: Fri, 16 Jan 2009 17:24:03 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1141743016.20090116172403@emcraft.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re[2]: [PATCH 07/11] md: rewrite handle_stripe_dirtying6 in
	asynchronous way
In-Reply-To: <e9c3a7c20901151421o69522f71rfe6d7d9621de47eb@mail.gmail.com>
References: <200812090057.33890.yur@emcraft.com>
	<e9c3a7c20901151351p5e1b4641h1b4c8ba1ae5dcc73@mail.gmail.com>
	<e9c3a7c20901151421o69522f71rfe6d7d9621de47eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

On Friday, January 16, 2009 you wrote:

> On Thu, Jan 15, 2009 at 2:51 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>> On Mon, Dec 8, 2008 at 2:57 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>> What's the reasoning behind changing the logic here, i.e. removing
>> must_compute and such?  I'd feel more comfortable seeing copy and
>> paste where possible with cleanups separated out into their own patch.
>>

> Ok, I now see why this change was made.  Please make this changelog
> more descriptive than "Rewrite handle_stripe_dirtying6 function to
> work asynchronously."

 Sure, how about the following:

"

 md: rewrite handle_stripe_dirtying6 in asynchronous way

 Processing stripe dirtying in asynchronous way requires some changes=20
to the handle_stripe_dirtying6() algorithm.

 In the synchronous implementation of the stripe dirtying we processed=20
dirtying of a degraded stripe (with partially changed strip(s) located=20
on the failed drive(s)) inside one handle_stripe_dirtying6() call:
- we computed the missed strips from the old parities, and thus got=20
the fully up-to-date stripe, then
- we did reconstruction using the new data to write.

 In the asynchronous case of handle_stripe_dirtying6() we don't=20
process anything right inside this function (since we under the lock),=20
but only schedule the necessary operations with flags. Thus, if=20
handle_stripe_dirtying6() is performed on the top of a degraded array=20
we should schedule the reconstruction operation when the failed strips=20
are marked (by previously called fetch_block6()) as to be computed=20
(with the R5_Wantcompute flag), and all the other strips of the stripe=20
are UPTODATE. The schedule_reconstruction() function will set the=20
STRIPE_OP_POSTXOR flag [for new parity calculation], which is then=20
handled in raid_run_ops() after the STRIPE_OP_COMPUTE_BLK one [which=20
causes computing of the data missed].

"

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
