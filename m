Return-Path: <SRS0=+v6T=6S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23259C47258
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 22:13:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFF52078C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 22:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JDybFtus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFF52078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GHDq1syQzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 08:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=JDybFtus; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GHBH4FNkzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 08:11:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Ke6Is75zTSCuovFahCnc7BTlhzg10jNaHS1gn8ns//o=; b=JDybFtusCmGEq91bmNnwoWCj+a
 N0xxIbsYu5lQxZkzPmNDuU07PGvTPGCdW0vbPRO5yL9CyEBvYR1vtbAgXrtqw0hBFSByZmuXy1eOa
 BV13lTYReOQhwPBCt6oCwd0okqW34ZMeppO7ul+DxlMT9qEZya+kLv/fyY5XjjSJAr4+XskBbUHkP
 mPhZXNr8NsQlQubgAbiO0erlNn5pHycINxr2ibFLT8cB20zuIsAzAh/rYn7lMK6nibeLoyUg72TaC
 rhhs1ncVZ9Po/A7mh6tw7ETaxX3a6Mq6QjZeYirrDtXuot86KgWihjeGnL68mEPitegVqvhOr0bO8
 9WIr0pFg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVjIz-0001BJ-5H; Mon, 04 May 2020 22:11:17 +0000
Subject: Re: [PATCH v2 2/5] stats_fs API: create, add and remove stats_fs
 sources and values
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>, kvm@vger.kernel.org
References: <20200504110344.17560-1-eesposit@redhat.com>
 <20200504110344.17560-3-eesposit@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a4e7489-bac4-23dc-b612-73eb91babb6f@infradead.org>
Date: Mon, 4 May 2020 15:11:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504110344.17560-3-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-mips@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Jim Mattson <jmattson@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/4/20 4:03 AM, Emanuele Giuseppe Esposito wrote:
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f08fbbfafd9a..1b0de0f19e96 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -328,4 +328,10 @@ source "fs/unicode/Kconfig"
>  config IO_WQ
>  	bool
>  
> +config STATS_FS
> +	bool "Statistics Filesystem"
> +	help
> +	  stats_fs is a virtual file system that provides counters and
> +	  other statistics about the running kernel.
> +
>  endmenu

Hi,

This kconfig entry should be under (inside) "Pseudo filesystems",
i.e., between 'menu "Pseudo filesystems"' and its corresponding
"endmenu".

Thanks.
-- 
~Randy

