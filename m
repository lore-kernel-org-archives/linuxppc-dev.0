Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A8C43444
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 05:34:13 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9A020651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 05:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6fF8bXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9A020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dzXy0sv9zDqfG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:34:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="m6fF8bXI"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dzWD4DxJzDqbh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 16:32:40 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id h193so2815201ita.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 21:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H/Olo4Zo97UTApRdojgY9u8WeJGg3GDT9ZjHatNwaRQ=;
 b=m6fF8bXIVc6PWxgcCfFajs4IaHv7C0LorIWbySRC2P5gkUZfYyidyACmBfCbkdlqBu
 2SvZXnzDqtsqwAadvs/m29LnUoU6VaRQ8HJ+qamcCGIUZl/IaWKwjTn/YKcqnkSr5bCF
 +XCiNjzzt9f5jrM3uvakBSKBl3BRCMTtaDmW7fNREoIt7cn2cQfV8CXqoSAk7kwkHUpr
 V0UxIg6vkn1RQJpHm2me+/aeajx6MYJbMk5dO6TdCrp8pVEzBvdN3l6mX3l82+pyDDz8
 GRFQwIHqf2Qazm0YwazgrIE3Pv6/b4KxxuN2dYE3a78RDocIkp+lThSHLxl+rB+8Lgdq
 K2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H/Olo4Zo97UTApRdojgY9u8WeJGg3GDT9ZjHatNwaRQ=;
 b=HM19duZKNPib7BxnVWtXSaTbOMn567M8sbYIoGUVjtXhlpTXbzIJmbTHCVNu/clTki
 IwD0sY4+xS2XKZb7R7ZTkJ/meVl6Fof69KJhgZiCo2RoY24eeAprrUJwP+hNSwWIbK6e
 4SlFQ/yysEJ0lARHb1Xnh2VPYNvrprk9XK/w+aqMkPixC7FdrI0Lwrqr2gpU7GFY5Ega
 rtewlvSMDx6wWWuf0w4X6EcYzw6PPWSiIueco5oWzjSFILMzWz9EXPJXkzSvFCST0axQ
 tutHgzYr/Xply479VSx8tQdBAukDdB2+B0CHgTGI75WYbXmZ4TZVvFVULmKxTL0oqHCo
 kHmQ==
X-Gm-Message-State: AJcUuke8GAs6wBfTgdoJOY1F2vzOIzVY1dUcEvm5z4DX0R8CgmMSs/lg
 5rFq5bMzVlMruDAkPCC2Z7oZdrrfxTgexvYsgg==
X-Google-Smtp-Source: ALg8bN5O2lFzZTWu9TqA8JEFzWVvOWjL1NUo8it6as3mUcu/spjDS7kq3BiHGG9R0CwV9dXZcpnV/rdIvwa6dDOvGok=
X-Received: by 2002:a24:7a94:: with SMTP id a142mr1314367itc.88.1547530358246; 
 Mon, 14 Jan 2019 21:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20190114082416.30939-1-mhocko@kernel.org>
 <87pnszzg9s.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pnszzg9s.fsf@concordia.ellerman.id.au>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 15 Jan 2019 13:32:26 +0800
Message-ID: <CAFgQCTsEtjKnCdUb=0d9aTNL94L1=XQGDtot=2MqmqQ-fqmr1g@mail.gmail.com>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[...]
> >
> > I would appreciate a help with those architectures because I couldn't
> > really grasp how the memoryless nodes are really initialized there. E.g.
> > ppc only seem to call setup_node_data for online nodes but I couldn't
> > find any special treatment for nodes without any memory.
>
> We have a somewhat dubious hack in our hotplug code, see:
>
> e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with memoryless nodes")
>
> Which basically onlines the node when we hotplug a CPU into it.
>
This bug should be related with the present state of numa node during
boot time. On PowerNV and PSeries, the boot code seems not to bring up
all nodes if memoryless. Then it can not avoid this bug.

Thanks,
Pingfan
