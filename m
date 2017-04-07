Return-Path: <srs0=m6hi=3p=axtens.net=dja@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzh7y5vyXzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 11:00:14 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzh7y51ytz8w0j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 11:00:14 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzh7x4Cbsz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 11:00:12 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 81so11521964pgh.3
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 18:00:12 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: Re: [PATCH] powerpc/crypto/crc32c-vpmsum: Fix missing
 preempt_disable()
In-Reply-To: <1491485678-3444-1-git-send-email-mpe@ellerman.id.au>
References: <1491485678-3444-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 07 Apr 2017 11:00:06 +1000
Message-ID: <87o9w9hw15.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

We'll also need a similar patch for the t10dif code that went in to
Herbert's next.

I will do a patch once I get my development environment up and going
again.

Regards,
Daniel

Michael Ellerman <mpe@ellerman.id.au> writes:

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
> ---
>  arch/powerpc/crypto/crc32c-vpmsum_glue.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/crypto/crc32c-vpmsum_glue.c b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> index 411994551afc..f058e0c3e4d4 100644
> --- a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> +++ b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> @@ -33,10 +33,13 @@ static u32 crc32c_vpmsum(u32 crc, unsigned char const *p, size_t len)
>  	}
>  
>  	if (len & ~VMX_ALIGN_MASK) {
> +		preempt_disable();
>  		pagefault_disable();
>  		enable_kernel_altivec();
>  		crc = __crc32c_vpmsum(crc, p, len & ~VMX_ALIGN_MASK);
> +		disable_kernel_altivec();
>  		pagefault_enable();
> +		preempt_enable();
>  	}
>  
>  	tail = len & VMX_ALIGN_MASK;
> -- 
> 2.7.4
