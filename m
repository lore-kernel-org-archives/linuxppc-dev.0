Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC32C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 11:33:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E9D206BA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 11:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E9D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4465fz5Kn3zDq7n
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 22:32:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4465d24lNczDq64
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 22:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4465d23Yyrz9s9L; Sat, 23 Feb 2019 22:31:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4465d21j8yz9s6w;
 Sat, 23 Feb 2019 22:31:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v16 05/21] powerpc: prep stack walkers for
 THREAD_INFO_IN_TASK
In-Reply-To: <20190205113219.17903-6-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-6-mpe@ellerman.id.au>
Date: Sat, 23 Feb 2019 22:31:18 +1100
Message-ID: <87imxalp15.fsf@concordia.ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ce393df243aa..4ffbb677c9f5 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2067,6 +2081,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  	int curr_frame = 0;
>  #endif
>  
> +	if (!try_get_task_stack(tsk))
> +		return;

This needs to be after the NULL check below:

>  	sp = (unsigned long) stack;
>  	if (tsk == NULL)
>  		tsk = current;


Otherwise show_stack(NULL, NULL) blows up :)

I've changed it to:

	if (tsk == NULL)
		tsk = current;

	if (!try_get_task_stack(tsk))
		return;

	sp = (unsigned long) stack;
	if (sp == 0) {
        	...


cheers
