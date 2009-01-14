Return-Path: <dan.j.williams@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 13C8EDE0EE
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 06:00:33 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so695935wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:00:26 -0800 (PST)
Message-ID: <e9c3a7c20901141100r666007cbv76a869eddf292371@mail.gmail.com>
Date: Wed, 14 Jan 2009 12:00:26 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: [RFC PATCH 00/11][v3] md: support for asynchronous execution of
	RAID6 operations
In-Reply-To: <200901130342.55633.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901130342.55633.yur@emcraft.com>
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

On Mon, Jan 12, 2009 at 5:42 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>  Hello,
>
>  This is the next attempt on asynchronous RAID-6 support. This patch-set
> has the Dan Williams' comments (Dec, 17) addressed with the following
> exception:
>
> - I still think that using 'enum dma_ctrl_flags' for PQ-specific
> operations is better than introducing another group of flags and
> enhance the device_prep_dma_pq()/device_prep_dma_pqzero_sum() with one
> more parameter. If unchanged 'enum dma_ctrl_flags' will be a criteria
> of acceptance, please let me know - I'll re-implement this exactly as
> Dan suggested.

Ignore that Dan character :-), dma_ctrl_flags is the proper place for
this functionality.

However, I do not believe we need/want ASYNC_TX_ZERO_{P,Q}.  I will
reply to 0002 and 0003 with details.

>
>
>  Fearing to look like a spammer, I post only those patches, which had
> been affected by the changes intended to address Dan's comments. These
> are the following five:
>
> 0002-async_tx-add-support-for-asynchronous-GF-multiplica.patch
> 0003-async_tx-add-support-for-asynchronous-RAID6-recover.patch
> 0004-md-run-RAID-6-stripe-operations-outside-the-lock.patch
> 0008-md-asynchronous-handle_parity_check6.patch
> 0011-ppc440spe-adma-ADMA-driver-for-the-PPC440SP-e-syst.patch
>
>  As regarding the other six patches of asynchronous RAID-6 support
> patchset:
>
> 0001-async_tx-don-t-use-src_list-argument-of-async_xor.patch
> 0005-md-common-schedule_reconstruction-for-raid5-6.patch
> 0006-md-change-handle_stripe_fill6-to-work-in-asynchrono.patch
> 0007-md-rewrite-handle_stripe_dirtying6-in-asynchronous.patch
> 0009-md-change-handle_stripe6-to-work-asynchronously.patch
> 0010-md-remove-unused-functions.patch
>
>  they are the same as in my 09 Dec 2008 post:

Do you have a git tree where you can post this series?  That would
make it easier for me to track/review.

Thanks,
Dan
