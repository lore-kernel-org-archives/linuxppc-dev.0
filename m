Return-Path: <SRS0=8srP=EU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F226C5519F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2020 23:36:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6705C22314
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2020 23:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3hkq699"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6705C22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYWvN05kBzDqT6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2020 10:36:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=a3hkq699; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYWsQ3GLCzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2020 10:35:06 +1100 (AEDT)
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
 (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4DDB24137;
 Sat, 14 Nov 2020 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605396903;
 bh=s9LmfnlBd6X9FQ2JJqe9YkY9PUM+P1pzFglNu4NzenE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a3hkq6994bhB9cavqK6NCPIPZfxYZV23S/xMP0C60Y3Ey3mdDbmfxnYcot8Wbri0c
 /FO6Xtmsirm/PbcNorKRsL9JgGgVI6cMD9azcWGFBeSA87qIW6IuFDT40DuYv98xYN
 7niWW+1Jls6GUJusktlhLQM4tipuS6z4U9czB8ic=
Date: Sat, 14 Nov 2020 15:35:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net-next 02/12] ibmvnic: Introduce indirect subordinate
 Command Response Queue buffer
Message-ID: <20201114153501.66072756@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1605208207-1896-3-git-send-email-tlfalcon@linux.ibm.com>
References: <1605208207-1896-1-git-send-email-tlfalcon@linux.ibm.com>
 <1605208207-1896-3-git-send-email-tlfalcon@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: cforno12@linux.ibm.com, netdev@vger.kernel.org, ljp@linux.vnet.ibm.com,
 ricklind@linux.ibm.com, dnbanerg@us.ibm.com, drt@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 12 Nov 2020 13:09:57 -0600 Thomas Falcon wrote:
> This patch introduces the infrastructure to send batched subordinate
> Command Response Queue descriptors, which are used by the ibmvnic
> driver to send TX frame and RX buffer descriptors.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>

> @@ -2957,6 +2963,19 @@ static struct ibmvnic_sub_crq_queue *init_sub_crq_queue(struct ibmvnic_adapter
>  
>  	scrq->adapter = adapter;
>  	scrq->size = 4 * PAGE_SIZE / sizeof(*scrq->msgs);
> +	scrq->ind_buf.index = 0;
> +
> +	scrq->ind_buf.indir_arr =
> +		dma_alloc_coherent(dev,
> +				   IBMVNIC_IND_ARR_SZ,
> +				   &scrq->ind_buf.indir_dma,
> +				   GFP_KERNEL);
> +
> +	if (!scrq->ind_buf.indir_arr) {
> +		dev_err(dev, "Couldn't allocate indirect scrq buffer\n");

This warning/error is not necessary, memory allocation will trigger an
OOM message already.

> +		goto reg_failed;

Don't you have to do something like 

                        rc = plpar_hcall_norets(H_FREE_SUB_CRQ,                 
                                                adapter->vdev->unit_address,    
                                                scrq->crq_num); 

?

> +	}
> +
>  	spin_lock_init(&scrq->lock);
>  
