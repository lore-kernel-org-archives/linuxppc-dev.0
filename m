Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:00:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2542173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzcX37ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2542173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443VTR4MryzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:00:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pzcX37ew"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443VRX6QZYzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 16:59:04 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id r124so9580268pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 21:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=S/9vsMMEndvojzP8+Kh5j0p0UEwS1gq0QBIxNlzokYM=;
 b=pzcX37ewNVfCd0L/fU7jA0ox1oIv/WlT0nOkQn/a4oLidpbumY5X6L7XqqpUOHy2wE
 l5f3WZjKvV7i/f6h6bc9HbS678RivuFxGQxsHqC6RZgjiTS4TomQBpH6fsdsYM/2ao7B
 Rzze87MbxaoiF7afwYP5mtqrT1XRg701R2SG6soLj2NAAQjjPotPFNyitXeeiswSzESi
 TkI1kEB/zYVc98yg3uPBVT8KDS1yQhAyZ1WvzB0eiE9jVVdgnCswtJ8eWhBErlgURjx/
 3HFRqnXfYPdoLvtLuu13Ab49JxJcF95QBptB212IYEu3tderLNlUCClJO8NfqVRKTORb
 +qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=S/9vsMMEndvojzP8+Kh5j0p0UEwS1gq0QBIxNlzokYM=;
 b=bNR3f9b0scawUaYBcLZyNC8azaA/sISDBoZtUG4xXJlt952dOJsHux393z5qvtGRIV
 PMwzypxwZgFgSAqPUelZje9wu0IP+StII7NqFoRKBWsqV6T1l+xcaBK4zJrBFrFFQgfR
 JglVSDkTRtvAmQ8VZo4n6NnwUA07xkLHNah+LR6crGyFs0upZAw95X3W3uhb4AEvRdnA
 f/eip+z//1FEiy+Q/tvBiAimQmDHImKxFTpcwF2qxQiCpwBeOAbeCFDQ82EMMhHHb/vO
 g/8UT8UL41QT6hd/0PhPD2V4joLCpM3wIuZ/nedocBbkozmOZFWSpvbLbjZ4Lim9GLV8
 GSiw==
X-Gm-Message-State: AHQUAua0cFMVCRGfYCaQogLpDbCCazcy0FaMzD0+8cI7+1EkarzCQmdA
 z4VdQsPTPmTAru7nhPajsCo=
X-Google-Smtp-Source: AHgI3Iau7F9juUYCJpqQh4Idf4CHBilfrYoIgr2RoMyGWBc7DWNY8J3hy7MCXlSbeEetA5555/YJKg==
X-Received: by 2002:a62:48c1:: with SMTP id q62mr24476880pfi.113.1550555942669; 
 Mon, 18 Feb 2019 21:59:02 -0800 (PST)
Received: from localhost ([61.69.157.156])
 by smtp.gmail.com with ESMTPSA id o23sm43733834pfa.140.2019.02.18.21.59.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 21:59:02 -0800 (PST)
Date: Tue, 19 Feb 2019 15:58:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 2/2] powerpc/mm/hash64: Map all the kernel mapping in
 the same 0xc range
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org, Daniel Axtens
 <dja@axtens.net>, mpe@ellerman.id.au, paulus@samba.org
References: <20190217051609.24140-1-aneesh.kumar@linux.ibm.com>
 <20190217051609.24140-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190217051609.24140-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550555813.fmra4d124d.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Aneesh Kumar K.V's on February 17, 2019 3:16 pm:
> This patch maps vmap, IO and vmemap regions in the 0xc address range
> instead of the current 0xd and 0xf range. This brings the mapping closer
> to radix translation mode.

What was the reason for that address layout in the first place?

Thanks,
Nick

=
