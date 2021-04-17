Return-Path: <SRS0=JxsT=JO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA225C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 02:40:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E7461107
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 02:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E7461107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMckb5jfZz3c6C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 12:40:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=d+i0hnWp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=d+i0hnWp; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMck41Jw0z2yjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 12:39:55 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id t22so20430553pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Apr 2021 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=rjTC8IKkPWGWDKmkZjVmpYAuXFrvSVsRIGffPplx4nk=;
 b=d+i0hnWpFX+Mj0V53vmK2vj8eRQNdZ7OmdBSqZs2JJu/wGdZaWjUSK5j03u+Qpqm/L
 JZoSxrNu88qDz90SkZdyhY8BYMglj4UmZjcr6iTK6UWLU0FqAmcd8fGLlLW1/vwJH7wv
 uZwheH6dxMQ1lPMdfOj75qaFpNBsekFCKLNIKBUCKAHiCRAF0DdRBY6UyDKiQziz4PNl
 OXUB/cWg0CbBphwRIMSOla1jFmUsP8imKGMwzwRREmU2d5lIuEVgaf0gxRGcDX3ZhLHv
 QWLgav7Bm3QDC+X/8lCvPBVXjQw1dbC6orZs1vwa6Fgu1hfu0U5vP03SdT7jUqw9PySn
 oCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=rjTC8IKkPWGWDKmkZjVmpYAuXFrvSVsRIGffPplx4nk=;
 b=eZ0PBsiYwD3kn7eXcvp05GryToO+l8okBzd6FakWJFJJGU7p3Divmtu/AoaNd+XJVM
 b6rdsZXptXZeroXoof/JQxKSj9CySqWJOSR06/2hukDE+i/RLNlD+rr/3gmBDqlBG1Us
 QtNx+jZDvAR9OuAtJMDD3HWYqep86B7mUMfPQcxw+qaCSvDKd2tBgHZzA68ZOx0plXbK
 rMWsMOc/pEp66ktICdP7fDEIDd9V4vWlkswnM2D2xwJlZ1wtVx1AlgtCAom7u2yRqivk
 MQWrZnFeSqw8AUgBo45IfLh+O0cDEyyw8INUzVQUpCAu7YCgH68qHYHxC3BY1JZnp6rV
 uItA==
X-Gm-Message-State: AOAM533LA07c1Sqkv6OzfRZ40WIT974RPclBsQL2Sq9MmoJ4cayuUbCG
 fMywLNyqOuBDhWfVL2nOv6w=
X-Google-Smtp-Source: ABdhPJzKHRpN7gEF064yyI6uHK9DoHuLx2LLT4PLDM9LCYl5VihNm2cIzm1UeMD0xnn7UN5ajHvQVg==
X-Received: by 2002:a63:28c2:: with SMTP id o185mr1752428pgo.40.1618627191851; 
 Fri, 16 Apr 2021 19:39:51 -0700 (PDT)
Received: from localhost (193-116-90-211.tpgi.com.au. [193.116.90.211])
 by smtp.gmail.com with ESMTPSA id k19sm6304711pgl.1.2021.04.16.19.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 19:39:51 -0700 (PDT)
Date: Sat, 17 Apr 2021 12:39:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
To: Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
References: <20210317062402.533919-1-npiggin@gmail.com>
 <20210317062402.533919-15-npiggin@gmail.com>
 <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
 <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
In-Reply-To: <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1618627160.9nazv519mt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Ding Tianhong <dingtianhong@huawei.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 =?iso-8859-1?q?Rick=0A?= Edgecombe <rick.p.edgecombe@intel.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Andrew Morton's message of April 16, 2021 4:55 am:
> On Thu, 15 Apr 2021 12:23:55 +0200 Christophe Leroy <christophe.leroy@csg=
roup.eu> wrote:
>> > +	 * is done. STRICT_MODULE_RWX may require extra work to support this
>> > +	 * too.
>> > +	 */
>> >  =20
>> > -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP=
_KERNEL,
>> > -				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>>=20
>>=20
>> I think you should add the following in <asm/pgtable.h>
>>=20
>> #ifndef MODULES_VADDR
>> #define MODULES_VADDR VMALLOC_START
>> #define MODULES_END VMALLOC_END
>> #endif
>>=20
>> And leave module_alloc() as is (just removing the enclosing #ifdef MODUL=
ES_VADDR and adding the=20
>> VM_NO_HUGE_VMAP  flag)
>>=20
>> This would minimise the conflits with the changes I did in powerpc/next =
reported by Stephen R.
>>=20
>=20
> I'll drop powerpc-64s-radix-enable-huge-vmalloc-mappings.patch for now,
> make life simpler.

Yeah that's fine.

> Nick, a redo on top of Christophe's changes in linux-next would be best
> please.

Will do.

Thanks,
Nick
