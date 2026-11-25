Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2F606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UK6z6NVE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHpf64lCz2yCN;
	Wed, 25 Nov 2026 22:42:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795586027;
	cv=none; b=f9eOMlwr6d2kEzvqAgqk4Of14Mr1TaA0eTef4MyS8Y9DzltxyQVAnfZKEGKVmJqdKDNiBOKJHkoPw2K5c2KKu7TrsZuAjIhUxVfai5I0CSReRVuf387ja0K9zNC1AvukTzcNubxUH7tW5O2QGCIPeIfIrIxcsRRTPXnAzKLIFnSUR2TWaIqaCOOMA+rW1X7YTrSbY+ZNeX0BWbutBdxTJZelIMswlveo6nG3QRmPj0YpkBSqlR1iGwrN6G5HzlJDV+alKIbgrn5EESSnow2aBwLzy6ePS/rfu5b2RXnHAI+AP5KEU5uH/0RvEPw6TQS1YX1xxZK4WA/rq6qCeqonIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795586027; c=relaxed/relaxed;
	bh=iMgsgpEKznfx9E2tPu9EJE/6blmi3j8XUJFr/xHJgnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpKZxzsAdnIWSCn9eudaP4eYhvhOP7y4Owu4SWLN0jiV3JbOTK5YNbhkjf2i4Qo7FD2GzeO1dKUe3BUe3AxTTi0xfB605cG6PCmshFBZvrRjSpI90pUx4nt6MMDOlsz7NnHEfVVz4eEPOQHxljGRcum/nWYmCDL2Q9OFEzCyxPDa0n2UYazgDwpO2kXmgG/gmeiJMpsRMrtTUql+1+6xrJhjuJ7WyPIZwhF9crFkz2/YhvEt00890C9KuAng1UHwRlJIu14L6Q4u4Un6aYCcGURjlD/CmnsXVMNCsoXxWwcBloF98ZeqWkx2eh5+2ltksr8PulfFJWFDLOGuo9FboQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UK6z6NVE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UK6z6NVE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ84W1cl1z2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 16:53:46 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8b6b22be970so2074154b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586024; x=1796190824; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iMgsgpEKznfx9E2tPu9EJE/6blmi3j8XUJFr/xHJgnU=;
        b=UK6z6NVEej751GorrqRd/dKs6tOI47nTTh8aIfsNkvxc1TfuPEtvJUZuHKArarJdiC
         JthDVY28rdf1SDiIlNX3gnNowpkwQo28/weVa/TrEIUKsh5Y2aoevFG9TnRBccpVvbzB
         kzAU9/AIFOJBdqVlpoM79o+LrYLgyrd0ts8mdh8+FuTKIodBTnIVlKsK9h2ycQM4PrlV
         jVh8IKd9zWTdg6zypu21goh1VoSBOn6tTQp/dmxVOTXfPv0i+guCeEo9PZaGaEIqzaTV
         94PfHleGDtOx8qPagW0WhlRqfxggZggkBt7m6/EKFbizMQFy92+7dOzUlc0M+TulRCkj
         aLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586024; x=1796190824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMgsgpEKznfx9E2tPu9EJE/6blmi3j8XUJFr/xHJgnU=;
        b=zR483v+dnamZqqwsUcXZsFZuBYaaOJbXilc5sWWNP9j5FXXnxnvfkHF0YAE3LH9eTl
         L+bVf54HwH5Y+tEOKfMLZSNjzCSavxfWIA+WHbAvLghyQEu/qVNR+yBVIfys3PHWeEoA
         VQz18XFAKUZ+ZYTREggXHhF2odZRMtkrrC7O9zSk9Q96vsQ1ZsuNJue8VbCFGKP9Kgi/
         iSZ08ykGl7SMK3WOzATMvsqMpat8kNhkkwDIwdnHHIS6Ddn5hlpa6YFx7ExvXcCBMOs/
         /gjwY5YyTHcabeNYTp+i3K4b7cBBhZnvz4h2eFercD507hQJYzUBgM4qWDf6qQYCJFlM
         gt5A==
X-Gm-Message-State: APuU4Z/TckvkpVHw1ICFkhUJhKz0VYjrcwm/GRIdm/MoBE9NOZXv4Vy/
	osOnyylQhhjurcUw79UE6cx9EKPhEpxtov1stkYAoVQKMXNgfN5DeawH
X-Gm-Gg: AZFdTZeVQQF5D7ltvpwrAfPPa6KnCHRxyiBBJtQSRA7vMYJOChTFgNMvH/q47LpO9Cf
	s1X0zELCubu704lQMBUdXxyXPwgq3byTdYyUs5iZhTdYuyO/xYb5Po2x4lv35Zr3XKGWHR4BsU6
	y5AcYGi3i4ZRcr8GzIWexQDKlzISEpOD/mzcBrff3OefFn07zx0q8ZNNwRNgf5GU6n6cVNMOKIy
	rl0xD7dKVpIfjjyPzNxNOZbzH6iDVrwvUqaItUshf6VM7VCJXFimgct7a6BXxlmbtt8ohS+oFIE
	tN0N2iqNNbn4wLZ8r2Tx4YPPgiqZgc3dZfbpbGCddjHwRObpXv224gvcO3o9HlWUqy8ZrdDP4NM
	UllkHY7LUSwd5+qYZCGuY404aTHfIEol/NwNEG5DI4eiTUwxJLJnoZ0pzN5BIpL1gQoorTkhR36
	wZuruUNpzwm0+ZRJoXjwBPtT/EWXLr4h6HbMJF96cLmhtXA62NQlJi/AQfVw5XNw1EXwBKOTpSv
	7hgup8XusOMwJQYz5AoTL4wcITeMBIYxIl0N3eYDNeGaBwID0bb7aFU5KLHPmFtK1Il5dZbZVWL
	e9od/stvlRhlDjWxIVEQnh39FDirdEFjcUQ3Xce45DBMz2StGuVvLnBn0Hzum04ntrZbE/1tJdm
	u
X-Received: by 2002:a05:6a00:2996:b0:89a:19ae:10e7 with SMTP id d2e1a72fcca58-8c87cf29209mr13734304b3a.42.1795586024370;
        Tue, 24 Nov 2026 21:53:44 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285ccf4sm7958930b3a.12.2026.11.24.21.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:53:44 -0800 (PST)
Date: Wed, 25 Nov 2026 11:23:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb
 GFP_KERNEL allocations under spinlock
Message-ID: <awZ31TppgNv1uBuW@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:21:52PM +0530, Ritesh Harjani (IBM) wrote:
> kvmppc_init_hostwide() takes lock_l0_stats with spin_lock_irqsave() and
> then allocates the guest state message and buffer with GFP_KERNEL. On
> a nested API v2 host with DEBUG_ATOMIC_SLEEP this warns at boot:
> 
>   BUG: sleeping function called from invalid context at include/linux/sched/mm.h:322
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
>   preempt_count: 1, expected: 0
>   RCU nest depth: 0, expected: 0
>   locks held by swapper/0/1: 1, on CPU#0:
>    #0: c000000004ad95b8 (lock_l0_stats){....}-{3:3}, at: kvmppc_register_pmu+0x50/0x270
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc2-00028-ge5a8bf3a3ee9-dirty #124 PREEMPT
>   Call Trace:
>    dump_stack_lvl+0xe8/0x150 (unreliable)
>    __might_resched+0x190/0x30c
>    __kmalloc_cache_noprof+0x4dc/0x760
>    kvmppc_gsm_new+0x68/0xcc
>    kvmppc_register_pmu+0xd4/0x270
>    do_one_initcall+0xac/0x48c
>    kernel_init_freeable+0x3cc/0x7f0
>    kernel_init+0x3c/0x274
>    ret_from_kernel_user_thread+0x14/0x1c
> 
> The lock is not needed for the allocation of gsm and gsb buffers.
> Allocate and fill the message and buffer without the lock and only take
> it to publish the two global pointers.
> 
> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/perf/kvm-hv-pmu.c | 65 ++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index aa72b96b5a8c..a58634f656e9 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -314,53 +314,48 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
>  
>  static int kvmppc_init_hostwide(void)
>  {
> -	int rc = 0;
> +	struct kvmppc_gs_msg *gsm;
> +	struct kvmppc_gs_buff *gsb;
>  	unsigned long flags;
> +	int rc;
>  
> -	spin_lock_irqsave(&lock_l0_stats, flags);
> -
> -	/* already registered ? */
> -	if (gsm_l0_stats) {
> -		rc = 0;
> -		goto out;
> -	}
> -
> -	/* setup the Guest state message/buffer to talk to L0 */
> -	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
> -				      GSM_SEND, GFP_KERNEL);
> -	if (!gsm_l0_stats) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	/* allocate the Guest state message/buffer to talk to L0 */
> +	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND,
> +			     GFP_KERNEL);
> +	if (!gsm)
> +		return -ENOMEM;
>  
>  	/* Populate the Idents */
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
>  
>  	/* allocate GSB. Guest/Vcpu Id is ignored */
> -	gsb_l0_stats = kvmppc_gsb_new(kvmppc_gsm_size(gsm_l0_stats), 0, 0,
> -				      GFP_KERNEL);
> -	if (!gsb_l0_stats) {
> +	gsb = kvmppc_gsb_new(kvmppc_gsm_size(gsm), 0, 0, GFP_KERNEL);
> +	if (!gsb) {
>  		rc = -ENOMEM;
> -		goto out;
> +		goto free_gsm;
>  	}
>  
>  	/* ask the ops to fill in the info */
> -	rc = kvmppc_gsm_fill_info(gsm_l0_stats, gsb_l0_stats);
> +	rc = kvmppc_gsm_fill_info(gsm, gsb);
> +	if (rc)
> +		goto free_gsb;
>  
> -out:
> -	if (rc) {
> -		if (gsm_l0_stats)
> -			kvmppc_gsm_free(gsm_l0_stats);
> -		if (gsb_l0_stats)
> -			kvmppc_gsb_free(gsb_l0_stats);
> -		gsm_l0_stats = NULL;
> -		gsb_l0_stats = NULL;
> -	}
> +	/* setup the Guest state message/buffer to talk to L0 */
> +	spin_lock_irqsave(&lock_l0_stats, flags);
> +	gsm_l0_stats = gsm;
> +	gsb_l0_stats = gsb;
>  	spin_unlock_irqrestore(&lock_l0_stats, flags);
> +
> +	return 0;
> +
> +free_gsb:
> +	kvmppc_gsb_free(gsb);
> +free_gsm:
> +	kvmppc_gsm_free(gsm);
>  	return rc;
>  }
>  
> -- 
> 2.39.5
> 

LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

