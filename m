Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2qRC6PYtzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 13:39:19 +1000 (AEST)
In-Reply-To: <1491485678-3444-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/crypto/crc32c-vpmsum: Fix missing preempt_disable()
Message-Id: <3w2qRC5Svjz9sNJ@ozlabs.org>
Date: Wed, 12 Apr 2017 13:39:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-06 at 13:34:38 UTC, Michael Ellerman wrote:
> In crc32c_vpmsum() we call enable_kernel_altivec() without first
> disabling preemption, which is not allowed:
> 
>   WARNING: CPU: 9 PID: 2949 at ../arch/powerpc/kernel/process.c:277 enable_kernel_altivec+0x100/0x120
>   Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c vmx_crypto ...
>   CPU: 9 PID: 2949 Comm: docker Not tainted 4.11.0-rc5-compiler_gcc-6.3.1-00033-g308ac7563944 #381
>   ...
>   NIP [c00000000001e320] enable_kernel_altivec+0x100/0x120
>   LR [d000000003df0910] crc32c_vpmsum+0x108/0x150 [crc32c_vpmsum]
>   Call Trace:
>     0xc138fd09 (unreliable)
>     crc32c_vpmsum+0x108/0x150 [crc32c_vpmsum]
>     crc32c_vpmsum_update+0x3c/0x60 [crc32c_vpmsum]
>     crypto_shash_update+0x88/0x1c0
>     crc32c+0x64/0x90 [libcrc32c]
>     dm_bm_checksum+0x48/0x80 [dm_persistent_data]
>     sb_check+0x84/0x120 [dm_thin_pool]
>     dm_bm_validate_buffer.isra.0+0xc0/0x1b0 [dm_persistent_data]
>     dm_bm_read_lock+0x80/0xf0 [dm_persistent_data]
>     __create_persistent_data_objects+0x16c/0x810 [dm_thin_pool]
>     dm_pool_metadata_open+0xb0/0x1a0 [dm_thin_pool]
>     pool_ctr+0x4cc/0xb60 [dm_thin_pool]
>     dm_table_add_target+0x16c/0x3c0
>     table_load+0x184/0x400
>     ctl_ioctl+0x2f0/0x560
>     dm_ctl_ioctl+0x38/0x50
>     do_vfs_ioctl+0xd8/0x920
>     SyS_ioctl+0x68/0xc0
>     system_call+0x38/0xfc
> 
> It used to be sufficient just to call pagefault_disable(), because that
> also disabled preemption. But the two were decoupled in commit 8222dbe21e79
> ("sched/preempt, mm/fault: Decouple preemption from the page fault
> logic") in mid 2015.
> 
> So add the missing preempt_disable/enable(). We should also call
> disable_kernel_fp(), although it does nothing by default, there is a
> debug switch to make it active and all enables should be paired with
> disables.
> 
> Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
> Cc: stable@vger.kernel.org # v4.8+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/4749228f022893faf54a3dbc70796f

cheers
