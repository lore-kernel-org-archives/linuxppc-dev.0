Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEBC10F03
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D997920896
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvxECnfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D997920896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Sfcd3SxWzDqKb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 03:20:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=larry.finger@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SvxECnfS"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SfZg1bygzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 03:18:34 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id v7so7418198oie.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RLDRoiBNbIAcIdIMLPqBzAQAHLBoEDdVU4Q4wOwG8Ms=;
 b=SvxECnfSRkC11p+C5ALfZTkc9meVsdEhIfzq7trghnm0/pb2EXiT6M9azSNm1JOYZk
 qPvdzYkGFaVFlK5Jij1L+zl+09EhR/TWwrQ+ODeYvEkhGt9injuE83BpO88WiRy9Y239
 qPpHGNdkvE3mvxd02l696jBoLuE9Qh5MT8iRqi55Y2oHSY0RXLOc/EhNiWFKl8Y0CO1j
 /jVStQo4fwar6VJZnTzu/lVyUQKEe1GAM92oZBmShgoC65F+stAEzurPhILNWg2lvPln
 GbVEF+bMA6jDWIJPewjXX/HwnLXYOmXcx0rLyecXHdyCBQs/e5KLZ9v1XaTmRvDcaECl
 LLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RLDRoiBNbIAcIdIMLPqBzAQAHLBoEDdVU4Q4wOwG8Ms=;
 b=rf//Xh5DuAOUiU6rQbvcgoKe7kkATwH3Z8uQ6ZszgYOCdyqt7Lh98swZ/0XgloBf3Y
 Agk0NaNMwvYC1bqlATmnqlHX/4Qz/hfyzQbQn1pUhtAL6pxDKCOGsywCq9LP+ABdzABp
 haXpoTNwKULr0rja61/Fr/tnTed60joDJKY74ND29aNiMAwWtK3CJ9dj+KwGNopP0C34
 g7Xq9a2bQ16K9mcLq7ItB2BVIrLKEX50yhpisepukZMUzpjjvv/vTQorJHMEOMZpolvb
 zcxXKrdbK6eicL9nzUQxcEwWYt21f4dtF/1dtp12JV4fedGWo6ECJBQn21v2ZWv6vyOY
 C0jw==
X-Gm-Message-State: APjAAAXllWjSvs09wRHO4+PVKPLi4r1TzW5Iq7Mm25PBHs2deOLtlOJy
 +8ka/jKWrci+n27HW2vxdxLiBlFp
X-Google-Smtp-Source: APXvYqzS7odJS1ZMxA3shGVmeIIDMUwsBye/FsKIe8gQKuJ71NTAV2ToHkYbPlits7tnpLa/fXvOJg==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr12392419oif.91.1553530709863; 
 Mon, 25 Mar 2019 09:18:29 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com.
 [24.31.245.230])
 by smtp.gmail.com with ESMTPSA id g17sm2288215otq.45.2019.03.25.09.18.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Mar 2019 09:18:29 -0700 (PDT)
Subject: Re: [PATCH] powerpc/rtas: fix early boot failure.
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <04c77eea-bda1-2bad-062f-d86d2ce6f192@lwfinger.net>
Date: Mon, 25 Mar 2019 11:18:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/25/19 3:43 AM, Christophe Leroy wrote:
> Commit 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing
> stack pointer while in RTAS") changes the code to use a field in
> thread struct to store the stack pointer while in RTAS instead of
> using SPRN_SPRG2. It therefore converts all places which were
> manipulating SPRN_SPRG2 to use that field. During early startup,
> the zeroing of SPRN_SPRG2 has been replaced by a zeroing of that
> field in thread struct. But at least in start_here, that's done
> wrongly because it used the physical address of the fields while
> MMU is on at that time.
> 
> So the virtual address of the field should be used instead, but in
> the meantime, thread struct has already been zeroised and initialised
> so we can just drop this initialisation.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Fixes: 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

My PPC box now boots OK.

Larry

