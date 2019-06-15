Return-Path: <SRS0=8zLz=UO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A003EC31E47
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:51:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8CC206B7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SYwry4YV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8CC206B7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QqRZ4z3WzDrR9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 17:51:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45QqMR2BKjzDrQS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 17:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SYwry4YV"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 45QqMQ6vDrz9sNt; Sat, 15 Jun 2019 17:47:46 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45QqMQ68b2z9sNT; Sat, 15 Jun 2019 17:47:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1560584866; bh=Omhq+JfRZdaBwAdpC7ZMYBk9IkvNPM4ETCl/bppBLP4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SYwry4YVdi1T2o5VEEsKyPMbd3wqwA4NHhCqKjlzzhHPseX72gCQzM7tl3ABvBcQ+
 dhu7MjyeTDmSpxevdX8s2ibjbwFuvej4/KKFQpG/nu2as2W/a+GEUkicKmKkci55Xy
 axIzqd87vr3K1pLVzu58DfR2vxVyJeXpvxwSUmvgKNA3P69DMQo0NBjTaFIwLR7poI
 KK/ShRl8i3Q7hHkZsTkyeCs55htDxFhKhambnmHH0j9YmLWWzgQEYfLwtT9ql8vJ5V
 3XlblyH+4McHXfzr4qvxB/DhHe/prTgbG60V+rY41fCTjgxfw4eAMr07QTDkJbUoR9
 lk+KGfwfMeRmQ==
Date: Sat, 15 Jun 2019 17:47:43 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v3 9/9] KVM: PPC: Ultravisor: Check for MSR_S during
 hv_reset_msr
Message-ID: <20190615074743.GF24709@blackberry>
References: <20190606173614.32090-1-cclaudio@linux.ibm.com>
 <20190606173614.32090-10-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606173614.32090-10-cclaudio@linux.ibm.com>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauermann@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2019 at 02:36:14PM -0300, Claudio Carvalho wrote:
> From: Michael Anderson <andmike@linux.ibm.com>
> 
>  - Check for MSR_S so that kvmppc_set_msr will include. Prior to this

Will include what? "it" maybe?

>    change return to guest would not have the S bit set.
> 
>  - Patch based on comment from Paul Mackerras <pmac@au1.ibm.com>
> 
> Signed-off-by: Michael Anderson <andmike@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>

but you should reword the commit message fix that first sentence.

Paul.
