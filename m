Return-Path: <SRS0=o3hI=CF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E77C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 21:26:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8190F20825
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 21:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE4no8bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8190F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BcwlS54VnzDqlX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2020 07:26:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::841;
 helo=mail-qt1-x841.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nE4no8bO; dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bcwhs3p7YzDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2020 07:24:10 +1000 (AEST)
Received: by mail-qt1-x841.google.com with SMTP id 60so1902031qtc.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=MVC75WhA7d+0oDQazfX2DGa6cSUtXkIL8si5LFw8QKo=;
 b=nE4no8bOYuNaI5l9TjJ+/StsPJHYNmB5V/L+olDFa1PVPA7CS6C3e0hRxqk8ekmyf2
 wM+xTgli8KOZ7u4BtEI/0+bMj2IEG6DOUpfI9ixOqMmH2Z7j3d8M8zSBU/6brb6Yc9ck
 DeVirLgs0ikpFF+uYb326kItTsvAUTWiHOjNKXB9y+vwfo+ik4N16fAQ74H4RfcT5DJ4
 ry45RgjADUO7zljmmW743bRbLkCjlE8nZBpDYkzEGXrHJy6bTrCwaGCrfKTCJPoENv8t
 rvzm8S2d+o5mIyNPpHScJAS9ASCyi+voRmangDBQgBMftLlNoNeZOpAgNMP56BcEAoni
 c6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=MVC75WhA7d+0oDQazfX2DGa6cSUtXkIL8si5LFw8QKo=;
 b=nxLdLoque4T05ymmUX9VGuKaVXtv8IeTRlXIv65ZiVTgSr0Gw9rnTKEhN4Z/007KpT
 4tId5NoLm9Q3eL9rhOTnVfYAVH6J6Kl+nAo4XTZT0zwtE/k+xAcyODDAExiJtEOPUEFE
 xlLhQYomGBMkP5T+9zwIQJS/OTztxOXHi/+2pkgulm27qzHScJK7dEF/lbX6NW+tXY3Z
 5FI6L/G7h8RSi2z0pkk/2slbVOqYO3Nw7I7S5SEFWWpGytxm5LaMum9SK25Jy+/nXAuD
 XAt/OlQWxrkgJ4COuf9qQs5heI3+3O4gvdxqT6I+mBD79gPNvXRpSU0VGhqxOVHMSllg
 urOQ==
X-Gm-Message-State: AOAM533i6EEjcwNh/1w1/dD7W8TbszexifAIAppOCe5Ov77h6TydKPS5
 /6D58/I/c6KrQWMRlcVw2C8=
X-Google-Smtp-Source: ABdhPJye21DrpNVQ72mgNG9+VcshecC/+jLXcFU32/VkAcT9ulqX6b5xuxHB/dXaesYuiXTDwU1ViA==
X-Received: by 2002:ac8:66d3:: with SMTP id m19mr21062282qtp.276.1598563447427; 
 Thu, 27 Aug 2020 14:24:07 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
 by smtp.gmail.com with ESMTPSA id u41sm3022336qth.42.2020.08.27.14.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 14:24:06 -0700 (PDT)
Message-ID: <e06630576e199db4e93d64b55e565eff8456a2e4.camel@gmail.com>
Subject: Re: [PATCH v1 05/10] powerpc/pseries/iommu: Add
 iommu_pseries_alloc_table() helper
From: Leonardo Bras <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>,  Joel Stanley <joel@jms.id.au>, Thiago Jung
 Bauermann <bauerman@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,  Brian
 King <brking@linux.vnet.ibm.com>, Murilo Fossa Vicentini
 <muvic@linux.ibm.com>, David Dai <zdai@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2020 18:23:59 -0300
In-Reply-To: <e4ea6264-578d-f8ea-a0c4-3b279b5c0411@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
 <20200817234033.442511-6-leobras.c@gmail.com>
 <e4ea6264-578d-f8ea-a0c4-3b279b5c0411@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-08-24 at 10:38 +1000, Alexey Kardashevskiy wrote:
> 
> On 18/08/2020 09:40, Leonardo Bras wrote:
> > Creates a helper to allow allocating a new iommu_table without the need
> > to reallocate the iommu_group.
> > 
> > This will be helpful for replacing the iommu_table for the new DMA window,
> > after we remove the old one with iommu_tce_table_put().
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 8fe23b7dff3a..39617ce0ec83 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -53,28 +53,31 @@ enum {
> >  	DDW_EXT_QUERY_OUT_SIZE = 2
> >  };
> >  
> > -static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> > +static struct iommu_table *iommu_pseries_alloc_table(int node)
> >  {
> > -	struct iommu_table_group *table_group;
> >  	struct iommu_table *tbl;
> >  
> > -	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
> > -			   node);
> > -	if (!table_group)
> > -		return NULL;
> > -
> >  	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
> >  	if (!tbl)
> > -		goto free_group;
> > +		return NULL;
> >  
> >  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> >  	kref_init(&tbl->it_kref);
> > +	return tbl;
> > +}
> >  
> > -	table_group->tables[0] = tbl;
> > +static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> > +{
> > +	struct iommu_table_group *table_group;
> > +
> > +	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
> 
> I'd prefer you did not make unrelated changes (sizeof(struct
> iommu_table_group) -> sizeof(*table_group)) so the diff stays shorter
> and easier to follow. You changed  sizeof(struct iommu_table_group) but
> not sizeof(struct iommu_table) and this confused me enough to spend more
> time than this straight forward change deserves.

Sorry, I will keep this in mind for future patches.
Thank you for the tip!

> 
> Not important in this case though so
> 
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thank you!


