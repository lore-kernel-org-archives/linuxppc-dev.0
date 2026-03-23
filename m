Return-Path: <linuxppc-dev+bounces-18635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EDEF483D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 17:53:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffgkt0WH9z2yWK;
	Tue, 24 Mar 2026 04:53:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774288405;
	cv=none; b=Jd4AcGZB5CflDktcmo0Qfzf8fvhwujLmgB9zyVPhjjmnvwG9lR2AdEP0f5PqhOZoIFxZCpa3+mgNmxpzgp5uzOhgtiQ2NcebLgNXPv9d8PIji9I+addrIrDuVToBig96Zaxqf57gysxPTwu9Y4Rk5nlmXaTtuZAX+ZfFGARTLUOGv72WyI4eGpqaVvBSGrWBjA/1UL//qf2A6sZX26EtcCDHe0g/9BJtCFcLfwV856b+kWXVg8hiQr+2tfjJiFFAGG8o3QQyeNcTW2D7eDFbYsR7tUBdRIj1FxeArrmGoyqE5lKy5wK7U18vjbutFvOfgIAijhWpoq/9PqiT5nMXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774288405; c=relaxed/relaxed;
	bh=reWwq5ua+u6vmCZuUTKVBM0ZLloWVsOJt7na7m30eIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSMDY8bh4FbvrHkUlIBo5dJA3koRqYF2DPvck2AQ0CDnRjPyxP2paa0BSR5TWuF/TNoiKLa34Tr2NTasPzPysgHPBK7J3dmHBsn8Y55fw2YK0psCm2Z9g4ffLusMoXiTO1DmI/tm14sV3xUQIo4MiYvdqyAlAVFm5Fxk55NGuxRx5QcuRe0BA96KcK5j+P3eenPN93K62omhF5aEtWIkpfMv+I5owDEJ8gnS7UTSyyDVLW+uOFwZbonrXhUcg1c/LluYJSY9b4PzTvdcD6gFSGG0/FPB+SRB+KQsd73Wdq2JoVVQ1Ag3WghBDVgm5HjCKscVIdHwBWmeHlZy5WzR6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bV7mxTWB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bV7mxTWB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffgks3CQ2z2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 04:53:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A97444486;
	Mon, 23 Mar 2026 17:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC77C2BCB0;
	Mon, 23 Mar 2026 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288403;
	bh=AE6bvPRBuu/wn9CJ9Bc0lzK1gYt9cBL0a+aIcWO4eCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV7mxTWBukFmR5V1TfAE3U4PHdCw+B18jcmZLFiYDg7lovpoVi6W/EcoLDOyawoWb
	 c0G+I1soK0HNQ46qHJ+Kjhzxtr3DmCXIVcBDdGHe7lZgMwdP8lE4dOiU+1frxh5Oxk
	 tg1wgR+cFyGJUFixQBX2maEdDM0hOlThkIbVZFptqw91KGyr/5gFVsKpksHc8l7FYm
	 Zch52RON9+hDZ0Z7iCImIZ9bbmdEUsIctlSMiYO8s9e9QpKd6up+CSD0A/rQcEGzcG
	 /9mMQ/b/RZUqQx95MmexN/E+miQtL0jHPA0oXOyJeIypJzez/ho+OREMjiHEL+dFS5
	 JqIYFBD77kcJQ==
Date: Mon, 23 Mar 2026 17:53:21 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error
 overwrite
Message-ID: <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
References: <20260322054309.898214-1-surenb@google.com>
 <20260322054309.898214-4-surenb@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322054309.898214-4-surenb@google.com>

On Sat, Mar 21, 2026 at 10:43:07PM -0700, Suren Baghdasaryan wrote:
> If kvm_s390_handle_pv() call fails its error code gets recorded but
> execution proceeds as if the call was successful. If the next call to
> copy_to_user() fails then the original error is overwritten.

Is that really a big deal though, as you're returning an error in either case?

> The follow-up patch adds fatal signal checks during VMA walk, which
> makes it possible for kvm_s390_handle_pv() to return EINTR error.
> Without this fix any error including EINTR can be overwritten and
> original error will be lost.
>
> Change error handling for kvm_s390_handle_pv() to alter normal flow
> once failure happens. This is consistent with how kvm_arch_vm_ioctl
> handles errors for other ioctl commands.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3eb60aa932ec..ddad08c0926f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		}
>  		/* must be called without kvm->lock */
>  		r = kvm_s390_handle_pv(kvm, &args);
> +		if (r)
> +			break;
>  		if (copy_to_user(argp, &args, sizeof(args))) {

Yeah as per Sashiko we probably need to copy_to_user() still.

But in that case, do we even need a change at all? I'm not sure it really
matters which error code terminates things does it?

>  			r = -EFAULT;
>  			break;
> --
> 2.53.0.1018.g2bb0e51243-goog
>

Thanks, Lorenzo

