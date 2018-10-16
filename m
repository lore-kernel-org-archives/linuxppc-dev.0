Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF90C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 22:35:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98092147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 22:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OxOz+enG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98092147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZVW22gx3zF3Vn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 09:35:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OxOz+enG";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZVRx1MHrzF3HJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 09:32:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OxOz+enG"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42ZVRx07pYz9s55; Wed, 17 Oct 2018 09:32:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1539729149; bh=ieHK1LElWknoHtQSrw7Q5v19iJecG+LdS4f2LoAPCKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OxOz+enG5agVgS5mFRoHjXdaA/5qPrETUy2Xhfw1imG3fPL+cxkmzhy9etGeFrbgx
 DsgJcypzpEGQWuKp/OwyYHEUI8JnFUujo6UuO4W4wkPH6HNMB8OJfHKWEI6PWhzo19
 /YBsyCmbtXL/2Tphm5iY4HEKiUyny/FOUoIgUdlX347LE6tUb7NoqL1bovKPavC0tl
 GVoNLDxpfgm6BGfpsjnTCyKcesRmiPZBU8i2VvXXKqoQbY0MhyPb7R0xaxAQx1sYTS
 3M6Hy1YruydNQCgBW/KG2Ws8wHWHJY2QJKdAdxfoD8OlaEksxjuQfvzCrC1xWP2+C3
 TocFVCP282wrQ==
Date: Wed, 17 Oct 2018 09:32:25 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4.18 086/135] KVM: PPC: Book3S HV: Dont use
 compound_order to determine host mapping size
Message-ID: <20181016223224.GA27627@blackberry>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170521.241312038@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016170521.241312038@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>,
 stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 16, 2018 at 07:05:16PM +0200, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> [ Upstream commit 71d29f43b6332badc5598c656616a62575e83342 ]

If you take 71d29f43b633 then you also need 6579804c4317 ("KVM: PPC:
Book3S HV: Avoid crash from THP collapse during radix page fault",
2018-10-04).

Thanks,
Paul.
