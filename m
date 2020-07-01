Return-Path: <SRS0=cW2d=AM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3CC433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A642077D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBGRerMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A642077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49xjmb2DKbzDr5X
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 00:10:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::843;
 helo=mail-qt1-x843.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mBGRerMC; dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49xjfT14rczDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2020 00:05:04 +1000 (AEST)
Received: by mail-qt1-x843.google.com with SMTP id u12so18440468qth.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2020 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=dKLRMPvx4e5If/u9vqBy8PFpqo+Hv7NHrX++OyxL9zk=;
 b=mBGRerMCNxFIctzZf03eL4Edj/940LGq4tV6sR5SJluvuy2abXUBsaVwOpSk917JDF
 MUFNLxyoIQSy/lHyNjWfnvuRtBHhG1qrBwqWdaRvH5Le6qWPX9HroARvHWPYqcavwCW4
 VGxyqI1eX9dJHVOC7IOGKjZEYRoN4EAX1X0KyaZTY6txSFZ4xdJ5PBw8P/apfMRhzRma
 PGnxA8eILkNLedNijbf+49FFfirVL5toNicRXADnKLAjV6yi458BKTZ9oR5gusamCXMV
 LXdibpsevSFhvAJ+uFvsfY53uRhyOUGRdk+SO29eSU6P5zjYuIpzD0tX7Z1meRsusd5V
 VFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=dKLRMPvx4e5If/u9vqBy8PFpqo+Hv7NHrX++OyxL9zk=;
 b=tWzZhnXXzs2lIM42dO6X7J2PApBRcLJSrYbiPgH5pzVJJKVDVsrdmOqA1Qi4DRZEU+
 nFRB6o8IRTs7za+f55P9QRZL9McpJyqWBcz1pkgmzlu+gSrSzdAibH3ghGa+vavA0w0J
 5TBdA58Ur3/qdU68q8umqYAEWzTrLsSxcZ5HrmtQDo+5KrNEGCF4fsuGqsILCZlgmUy2
 Ylzv1gEv3hE8dy5qE98ixLkSwA9rt2a5rtQ15olTuab5nX7HKOiVo0w5CUR4ktx1DmTI
 I3aUOvwW8+NjsgOBJ80FIVXiBRWynmH6HTuopoOh/P/BDI/q7Jthdi85aW7f5oLD5cSo
 4JUw==
X-Gm-Message-State: AOAM532Lyvga01gKUt+eAjXDZsmm3O0YMqIWi5cXFpWKSg24MVuGblZI
 QPGE4ameN1Q1RnjNHmitPHY=
X-Google-Smtp-Source: ABdhPJzTesp1WPk/G9gOh5N0HtGE7YYIMpp0WDZKdLYwlzigI1i0bUdCqxb4lXSOyFdpUvGjDd64jQ==
X-Received: by 2002:ac8:5303:: with SMTP id t3mr25740304qtn.108.1593612301087; 
 Wed, 01 Jul 2020 07:05:01 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br.
 [200.236.245.17])
 by smtp.gmail.com with ESMTPSA id n2sm5719421qtp.45.2020.07.01.07.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:05:00 -0700 (PDT)
Message-ID: <fbcbc7eb298930195b7146221dc1eded6bf556e4.camel@gmail.com>
Subject: Re: [PATCH v2 2/6] powerpc/pseries/iommu: Update call to
 ibm,query-pe-dma-windows
From: Leonardo Bras <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thiago Jung Bauermann
 <bauerman@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>
Date: Wed, 01 Jul 2020 11:04:55 -0300
In-Reply-To: <5411e8a1-02a3-1287-40bf-ccc9db7a4f88@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
 <20200624062411.367796-3-leobras.c@gmail.com>
 <5411e8a1-02a3-1287-40bf-ccc9db7a4f88@ozlabs.ru>
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

On Wed, 2020-07-01 at 18:17 +1000, Alexey Kardashevskiy wrote:
> 
> > +#define DDW_EXT_SIZE		0
> > +#define DDW_EXT_RESET_DMA_WIN	1
> > +#define DDW_EXT_QUERY_OUT_SIZE	2
> 
> #define DDW_EXT_LAST (DDW_EXT_QUERY_OUT_SIZE + 1)
> ...
> 
> 
> > +
> >  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> >  {
> >  	struct iommu_table_group *table_group;
> > @@ -339,7 +343,7 @@ struct direct_window {
> >  /* Dynamic DMA Window support */
> >  struct ddw_query_response {
> >  	u32 windows_available;
> > -	u32 largest_available_block;
> > +	u64 largest_available_block;
> >  	u32 page_size;
> >  	u32 migration_capable;
> >  };
> > @@ -875,13 +879,29 @@ static int find_existing_ddw_windows(void)
> >  machine_arch_initcall(pseries, find_existing_ddw_windows);
> >  
> >  static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> > -			struct ddw_query_response *query)
> > +		     struct ddw_query_response *query,
> > +		     struct device_node *parent)
> >  {
> >  	struct device_node *dn;
> >  	struct pci_dn *pdn;
> > -	u32 cfg_addr;
> > +	u32 cfg_addr, query_out[5], ddw_ext[DDW_EXT_QUERY_OUT_SIZE + 1];
> 
> ... and use DDW_EXT_LAST here.

Because of the growing nature of ddw-extensions, I intentionally let
this be (DDW_EXT_QUERY_OUT_SIZE + 1). If we create a DDW_EXT_LAST, it
will be incremented in the future if more extensions come to exist.

I mean, I previously saw no reason for allocating space for extensions
after the desired one, as they won't be used here.

> 
> 
> >  	u64 buid;
> > -	int ret;
> > +	int ret, out_sz;
> > +
> > +	/*
> > +	 * From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can rule how many
> > +	 * output parameters ibm,query-pe-dma-windows will have, ranging from
> > +	 * 5 to 6.
> > +	 */
> > +
> > +	ret = of_property_read_u32_array(parent, "ibm,ddw-extensions",
> > +					 &ddw_ext[0],
> > +					 DDW_EXT_QUERY_OUT_SIZE + 1);

In this case, I made sure not to cross (DDW_EXT_QUERY_OUT_SIZE + 1)
while reading the extensions from the property.

What do you think about it? 

Best regards,
Leonardo 

