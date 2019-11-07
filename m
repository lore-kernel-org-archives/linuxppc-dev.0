Return-Path: <SRS0=Sk7F=Y7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17343C5DF61
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 11:29:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B252187F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 11:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jkRQnBHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B252187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4781Qj0NhjzF39k
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 22:29:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4781LM3yq3zF68P
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2019 22:26:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="jkRQnBHy"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4781LL3cxkz9sP3;
 Thu,  7 Nov 2019 22:26:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1573125962;
 bh=VbKQCHFNvZUP34UghNzkYjIMJ6sgMjuxT0RvYS5Whl4=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=jkRQnBHyb7SrZeIAYVTwPml4x0yEYkywFLBJEGWTq+qRv0ZnkZaZ+xbmPerjptuXb
 mELHEXVg4NLoTpiIia/s0e65aDumixbxegskWm8VcTkgEMU+datlgoyXFTo6kTqAdi
 o0H4Gxg64kyneRYnk6vKTbMyhvk5hdxd8gKghyfNQZIHr3f+drqJK6vV3TG3urpf+t
 h3p8YftYjbPujKSTj3Df1YvdLaKSyLaha3yE1QcWxemnIvQE0Eca7GFoQaV3fAXbvo
 WyGShtgWR2QjWYjl3LJbuJnv2tpqN12BfaImOqCSoHN369V3tEnmgVQz0p3lqkqc2j
 UrL7ETMLAYJTw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
 Thomas Falcon <tlfalcon@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/9] Fixes and Enablement of ibm,drc-info property
In-Reply-To: <02380316-a751-6545-2991-13cce71f20f5@linux.ibm.com>
References: <1572967453-9586-1-git-send-email-tyreld@linux.ibm.com>
 <6958da5b-c518-64c2-50e3-db3f169d2337@linux.ibm.com>
 <02380316-a751-6545-2991-13cce71f20f5@linux.ibm.com>
Date: Thu, 07 Nov 2019 22:26:00 +1100
Message-ID: <87blto53nb.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 11/5/19 9:03 AM, Thomas Falcon wrote:
>> On 11/5/19 9:24 AM, Tyrel Datwyler wrote:
..
>>>
>>> This serious fixs the short comings of the previous submission
>> 
>> Either "seriously fixes the shortcomings", or "fixes the serious shortcomings?"

> Should be "series" as in this "patch series".

This serious series seriously fixes the series of serious shortcomings?

:P

cheers
