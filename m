Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0019C27C79
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2024 11:29:18 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=DFUwqRo8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W2nhr2Bkjz3fvN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2024 21:29:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=DFUwqRo8;
	dkim-atps=neutral
Received: from mail.ozlabs.org (unknown [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W2nh22BtLz3ftx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2024 21:28:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718623703;
	bh=xN/bQdiQ7QunPgDWnHIxIsBeNMFeFeDKxugA/ptH56U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DFUwqRo8lcJWUK+iQILpyWm7Uf2kMXYORMEAw7xtKE6RbkO+HT1vSn17XJfPwP6xG
	 2B60u0Wh7t/j+3Lf9t3Pu08WpR3gAR24pUEbSmdo1Ms0FQpB3s7+4YamWeBSMC7eZU
	 85rj2ZE9XVQH9sGLrBHaebuBD9BcLHMtvhXe0hOLheXirfTiB69DJ85MlhpEuaPLBj
	 N8dwAk8ItVnZuQ1qoLi1AiWqVcPhNzaTq5czCuzqFOw5FoWxdr7nfv3JRLbUn4zg+k
	 UmeG2fx+AZ2mgZWkNDfazHRRDMULpVv+iWIXVqGf/ImDCMmB+8JIMnSGYRLD/m8pA8
	 xuyYF13tZkyJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W2ngp42kZz4wb1;
	Mon, 17 Jun 2024 21:28:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jinglin Wen <jinglin.wen@shingroup.cn>, npiggin@gmail.com
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
In-Reply-To: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
Date: Mon, 17 Jun 2024 21:28:19 +1000
Message-ID: <87le336c6k.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, jinglin.wen@shingroup.cn
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jinglin Wen <jinglin.wen@shingroup.cn> writes:
> According to the code logic, when the kernel is loaded to address 0,
> no copying operation should be performed, but it is currently being
> done.
>
> This patch fixes the issue where the kernel code was incorrectly
> duplicated to address 0 when booting from address 0.
>
> Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
> ---
>  arch/powerpc/kernel/head_64.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for the improved change log.

The subject could probably still be clearer, maybe:
  Fix unnecessary copy to 0 when kernel is booted at address 0

Looks like this was introduced by:

  Fixes: b270bebd34e3 ("powerpc/64s: Run at the kernel virtual address earlier in boot")
  Cc: stable@vger.kernel.org # v6.4+

Let me know if you think otherwise.

Just out of interest, how are you hitting this bug? AFAIK none of our
"normal" boot loaders will load the kernel at 0. 

> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 4690c219bfa4..6c73551bdc50 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -647,7 +647,9 @@ __after_prom_start:
>   * Note: This process overwrites the OF exception vectors.
>   */
>  	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)
> -	mr.	r4,r26			/* In some cases the loader may  */
> +	tophys(r4,r26)
> +	cmplwi	cr0,r4,0	/* runtime base addr is zero */
> +	mr	r4,r26			/* In some cases the loader may */
>  	beq	9f			/* have already put us at zero */
	
That is a pretty minimal fix, but I think the code would be clearer if
we just compared the source and destination addresses.

Something like the diff below. Can you confirm that works for you.

cheers

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4690c219bfa4..6ad1435303f9 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -647,8 +647,9 @@ __after_prom_start:
  * Note: This process overwrites the OF exception vectors.
  */
 	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)
-	mr.	r4,r26			/* In some cases the loader may  */
-	beq	9f			/* have already put us at zero */
+	mr	r4, r26			// Load the source address into r4
+	cmpld	cr0, r3, r4		// Check if source == dest
+	beq	9f			// If so skip the copy
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
 
