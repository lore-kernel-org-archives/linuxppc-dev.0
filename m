Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHxCm30FzzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 00:44:04 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so6480801pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 07:44:04 -0700 (PDT)
Date: Sat, 20 Aug 2016 18:03:08 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mikey@neuling.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
Message-ID: <20160820100307.GA6731@simonLocalRHEL7.x64>
References: <20160822073206.1342-1-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160822073206.1342-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,
On Mon, Aug 22, 2016 at 05:32:06PM +1000, Cyril Bur wrote:
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index b6aa378..31e4e15 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1226,7 +1226,19 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
>  		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
>  	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
>  		goto bad;
> +
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	/*
> +	 * If there is a transactional/suspended state then throw it away.
> +	 * The purpose of a sigreturn is to destroy all traces of the
> +	 * signal frame, this includes any transactional state created
> +	 * within in.
> +	 * The cause is not important as there will never be a
> +	 * recheckpoint so it's not user visible.
> +	 */
> +	if (MSR_TM_ACTIVE(mfmsr()))
> +		tm_reclaim_current(0);
> +
Maybe a little picky here:
Per my understanding, the TRANSACTIONAL state will be failed in system
call common entry. The only expected state to prevent here is SUSPEND 
state.
Should we use MSR_TM_SUSPENDED(mfmsr()) here and BUG_ON
MSR_TM_TRANSACTIONAL(mfmsr())?  -- If it is transactional state, something
 is wrong with kernel. 

Others looks good to me.

Thanks,
- Simon
