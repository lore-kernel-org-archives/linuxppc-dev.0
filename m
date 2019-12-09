Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF595C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 00:30:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FAA206D5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 00:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FAA206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47X1F06GWxzDqVT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 11:30:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=178.32.97.215; helo=14.mo1.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 10802 seconds by postgrey-1.36 at bilbo;
 Tue, 10 Dec 2019 11:28:58 AEDT
Received: from 14.mo1.mail-out.ovh.net (14.mo1.mail-out.ovh.net
 [178.32.97.215])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47X1By0sx2zDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 11:28:53 +1100 (AEDT)
Received: from player791.ha.ovh.net (unknown [10.108.35.210])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 839371A3EB1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2019 21:51:46 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 84B93CF70276;
 Mon,  9 Dec 2019 20:51:40 +0000 (UTC)
Date: Mon, 9 Dec 2019 21:51:39 +0100
From: Greg Kurz <groug@kaod.org>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v3] ocxl: Fix potential memory leak on context creation
Message-ID: <20191209215139.53de41dd@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209105513.8566-1-fbarrat@linux.ibm.com>
References: <20191209105513.8566-1-fbarrat@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12961641203386784101
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgudegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghenucevlhhushhtvghrufhiiigvpedt
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
Cc: clombard@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, alastair@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  9 Dec 2019 11:55:13 +0100
Frederic Barrat <fbarrat@linux.ibm.com> wrote:

> If we couldn't fully init a context, we were leaking memory.
> 
> Fixes: b9721d275cc2 ("ocxl: Allow external drivers to use OpenCAPI contexts")
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> Changlog:
> v3:
> 	code cleanup (Greg)
> v2:
> 	reset context pointer in case of allocation failure (Andrew)
> 
> 
>  drivers/misc/ocxl/context.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index 994563a078eb..de8a66b9d76b 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -10,18 +10,17 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
>  	int pasid;
>  	struct ocxl_context *ctx;
>  
> -	*context = kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
> -	if (!*context)
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
>  		return -ENOMEM;
>  
> -	ctx = *context;
> -
>  	ctx->afu = afu;
>  	mutex_lock(&afu->contexts_lock);
>  	pasid = idr_alloc(&afu->contexts_idr, ctx, afu->pasid_base,
>  			afu->pasid_base + afu->pasid_max, GFP_KERNEL);
>  	if (pasid < 0) {
>  		mutex_unlock(&afu->contexts_lock);
> +		kfree(ctx);
>  		return pasid;
>  	}
>  	afu->pasid_count++;
> @@ -43,6 +42,7 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
>  	 * duration of the life of the context
>  	 */
>  	ocxl_afu_get(afu);
> +	*context = ctx;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ocxl_context_alloc);

