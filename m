Return-Path: <axboe@kernel.dk>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id C7738DDEEE
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 20:46:05 +1100 (EST)
Date: Wed, 19 Nov 2008 10:16:28 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-ID: <20081119091628.GT26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081119093023.48895b84.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 19 2008, Stephen Rothwell wrote:
> Hi all,
> 
> I got this in my boot test last night:
> 
> Begin: Waiting for root file system... ...
> BUG: spinlock lockup on CPU#1, vol_id/3246, c000000000b09700
> Call Trace:
> [c000000040ef7080] [c00000000000fb58] .show_stack+0x70/0x184 (unreliable)
> [c000000040ef7130] [c00000000027adac] ._raw_spin_lock+0x140/0x17c
> [c000000040ef71d0] [c0000000004ec648] ._spin_lock_irqsave+0x8c/0xc4
> [c000000040ef7270] [c0000000000659dc] .lock_timer_base+0x38/0x90
> [c000000040ef7310] [c000000000065b50] .__mod_timer+0x4c/0x11c
> [c000000040ef73c0] [c00000000025ae9c] .blk_plug_device+0xc0/0xd8
> [c000000040ef7440] [c00000000025bb90] .__make_request+0x498/0x518
> [c000000040ef74f0] [c000000000259dc8] .generic_make_request+0x24c/0x2a4
> [c000000040ef75b0] [c00000000025b6d0] .submit_bio+0x108/0x130
> [c000000040ef7670] [c0000000001210e4] .submit_bh+0x174/0x1c0
> [c000000040ef7700] [c0000000001259a8] .block_read_full_page+0x34c/0x3b4
> [c000000040ef7820] [c000000000129a60] .blkdev_readpage+0x20/0x38
> [c000000040ef78a0] [c0000000000c111c] .__do_page_cache_readahead+0x23c/0x2b8
> [c000000040ef7980] [c0000000000c1370] .ondemand_readahead+0x1d8/0x210
> [c000000040ef7a30] [c0000000000b7f20] .generic_file_aio_read+0x224/0x620
> [c000000040ef7b60] [c0000000000f9020] .do_sync_read+0xc4/0x124
> [c000000040ef7cf0] [c0000000000f98e0] .vfs_read+0xd8/0x1bc
> [c000000040ef7d90] [c0000000000f9f0c] .sys_read+0x4c/0x8c
> [c000000040ef7e30] [c0000000000084d4] syscall_exit+0x0/0x40
> 
> This was on a Power5 partition.  I am attempting to reproduce the problem.
> 
> Any clues?

Strange, so it gets stuck on the timer lock, very weird. You don't
happen to have output showing that the other CPU is up to at that point?

-- 
Jens Axboe
