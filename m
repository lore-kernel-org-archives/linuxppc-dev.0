Return-Path: <SRS0=Bl8b=VI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C71C74A42
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 04:54:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69883206B8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 04:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69883206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kkHx4lDmzDqjQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 14:54:53 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kkG45W0DzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 14:53:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45kkG32gBQz9sDB;
 Thu, 11 Jul 2019 14:53:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/imc: Dont create debugfs files for cpu-less
 nodes
In-Reply-To: <20190702092112.4015-1-maddy@linux.vnet.ibm.com>
References: <20190702092112.4015-1-maddy@linux.vnet.ibm.com>
Date: Thu, 11 Jul 2019 14:53:14 +1000
Message-ID: <87d0ihgojp.fsf@concordia.ellerman.id.au>
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
Cc: Qian Cai <cai@lca.pw>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Maddy,

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index 186109bdd41b..e04b20625cb9 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -69,20 +69,20 @@ static void export_imc_mode_and_cmd(struct device_node *node,
>  	if (of_property_read_u32(node, "cb_offset", &cb_offset))
>  		cb_offset = IMC_CNTL_BLK_OFFSET;
>  
> -	for_each_node(nid) {
> -		loc = (u64)(pmu_ptr->mem_info[chip].vbase) + cb_offset;
> +	while (ptr->vbase != NULL) {

This means you'll bail out as soon as you find a node with no vbase, but
it's possible we could have a CPU-less node intermingled with other
nodes.

So I think you want to keep the for loop, but continue if you see a NULL
vbase?


> +		loc = (u64)(ptr->vbase) + cb_offset;
>  		imc_mode_addr = (u64 *)(loc + IMC_CNTL_BLK_MODE_OFFSET);
> -		sprintf(mode, "imc_mode_%d", nid);
> +		sprintf(mode, "imc_mode_%d", (u32)(ptr->id));
>  		if (!imc_debugfs_create_x64(mode, 0600, imc_debugfs_parent,
>  					    imc_mode_addr))
>  			goto err;
>  
>  		imc_cmd_addr = (u64 *)(loc + IMC_CNTL_BLK_CMD_OFFSET);
> -		sprintf(cmd, "imc_cmd_%d", nid);
> +		sprintf(cmd, "imc_cmd_%d", (u32)(ptr->id));
>  		if (!imc_debugfs_create_x64(cmd, 0600, imc_debugfs_parent,
>  					    imc_cmd_addr))
>  			goto err;
> -		chip++;
> +		ptr++;
>  	}
>  	return;

cheers
