Return-Path: <SRS0=rI0D=Y6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D115C5DF62
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 06:05:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28B2214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 06:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="VHiP8nxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28B2214D8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477GGN6BQGzF5bF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 17:05:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477G6q4rnpzF3nL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2019 16:58:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="VHiP8nxh"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 477G6q1YXnz9sP6; Wed,  6 Nov 2019 16:58:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1573019907; bh=fe1cfYqlG7NpLDENgEEgJGCJ15l6iPBAhlJyBRCiARo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VHiP8nxhMyffu/D9d9yF1JnkErmzswDreT+8f+fPbuQgyBQSZ3CZzopDPCERkENrd
 FzxnwBZPsu9KtkRYrsl0FmjxNEw5p0Xba9Q+qSsA62WPZJORrz9ZJuM9fej42+ImA5
 0Wi7JoXEqENFNgM80xi0pE3fhr+UAtsAFybft4Fn5TduNkcT4cWbQX19lxfCu1weWW
 2Vu2Dvk3h/rMEU9P/LMRsIJD5Jgqqre+AjPWu4uNWkPvAeoYrA4Y2lCELjxObrT5lW
 mCl7MKn6N2GfPUKj9sWSHT4jfak3uCfqWi3YOL32lNx7hb+cuTIy51WRubgzc8p10a
 zufv0lF3FxTUw==
Date: Wed, 6 Nov 2019 16:58:23 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v10 4/8] KVM: PPC: Radix changes for secure guest
Message-ID: <20191106055823.GE12069@oak.ozlabs.ibm.com>
References: <20191104041800.24527-1-bharata@linux.ibm.com>
 <20191104041800.24527-5-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104041800.24527-5-bharata@linux.ibm.com>
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
Cc: linuxram@us.ibm.com, cclaudio@linux.ibm.com, kvm-ppc@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 04, 2019 at 09:47:56AM +0530, Bharata B Rao wrote:
> - After the guest becomes secure, when we handle a page fault of a page
>   belonging to SVM in HV, send that page to UV via UV_PAGE_IN.
> - Whenever a page is unmapped on the HV side, inform UV via UV_PAGE_INVAL.
> - Ensure all those routines that walk the secondary page tables of
>   the guest don't do so in case of secure VM. For secure guest, the
>   active secondary page tables are in secure memory and the secondary
>   page tables in HV are freed when guest becomes secure.

Why do we free the page tables?  Just to save a little memory?  It
feels like it would make things more fragile.

Also, I don't see where the freeing gets done in this patch.

Paul.
