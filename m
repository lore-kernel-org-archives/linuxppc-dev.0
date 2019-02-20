Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:10:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC10F2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kq/KL3cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC10F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444PJG1WLtzDqLF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 04:10:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="kq/KL3cB"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444PG76bkszDqDx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 04:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b/xQ0De9DqRGz7Fcps93XhuWO/x59JQPfs3kHnkPpwM=; b=kq/KL3cB13GF+XOFS0BtCsw0F
 d3bzd9FWWSCXZVy6/DkADUujFszbWW/3IhfO0YP77BQz6qoEYqyX58EhDMp+7EgZLTgUOrkm65MKz
 bVs2kZoXBlp2MXc6o0o2ApKjrvNac1Q61yb4vWgQtuTxwl9IO2WMxv8ewTUcyt7zMn7C9GII09YoH
 ym8hBP65Ogo5uji54f9QXUlCz8Dm2Nxfl7fXkQrLaEgLf7ThRlWDUi4rPZq0yrJejadECNv4t7if1
 l9xBHwcqo+zfOfoyW9bcHGn5ovEN1JXTNioPLKwF41qAdxFTG6UxxN94XWPc4OYZo9vHGhyYHINvm
 wmjW4Jq9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwVMQ-0001zB-MZ; Wed, 20 Feb 2019 17:08:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2E6032139CDE4; Wed, 20 Feb 2019 18:08:41 +0100 (CET)
Date: Wed, 20 Feb 2019 18:08:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
Message-ID: <20190220170841.GM32494@hirez.programming.kicks-ass.net>
References: <20190220165520.5241-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220165520.5241-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 20, 2019 at 05:55:20PM +0100, Laurent Vivier wrote:
> index 3f35ba1d8fde..372278605f0d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1651,6 +1651,7 @@ void sched_init_numa(void)
>  	 */
>  	tl[i++] = (struct sched_domain_topology_level){
>  		.mask = sd_numa_mask,
> +		.flags = SDTL_OVERLAP,

This makes no sense what so ever. The numa identify node should not have
overlap with other domains.

Are you sure this is not because of the utterly broken powerpc nonsense
where they move CPUs between nodes?

>  		.numa_level = 0,
>  		SD_INIT_NAME(NODE)
>  	};
> -- 
> 2.20.1
> 
