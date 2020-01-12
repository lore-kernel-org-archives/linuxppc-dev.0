Return-Path: <SRS0=2lRn=3C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF6C33CA9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 01:11:22 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A762221744
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 01:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="BzVxd3D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A762221744
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47wwX63997zDqMT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 12:11:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47wwTt638nzDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2020 12:09:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=BzVxd3D4; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47wwTt37Jgz9s4Y; Mon, 13 Jan 2020 12:09:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 47wwTt1qsQz9sP3; Mon, 13 Jan 2020 12:09:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1578877762; bh=leii6v6Dj/RGlbG1OQ5MHtdg57WwGh/HerboWbNo31w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BzVxd3D47/6AlSFNN18mP1fF7j3C2FvNmqK++vMCc11szGYsp9hUzPoieaE4nV8YS
 wdAuWkO4ieSjY7J+H5XwsITPyk9QGZou5x6G2p/SddUCiVZyHsGeNTiA9VX3bC6/kp
 7/tv2YdHkRdjaj5e6v0fHqcKMeog/sEE0AHImJgCxMuOBOgsgwt7Vm4qMQ6H3KR/f9
 ZmxBF5bINAuh+Kn1JRNJBI4EOwbBqBRrrbI7BdeDNX9wfl0Dg3R7ZugvR/BW5UbygK
 dDwxSTMEx6DCl/fwNGzzR+PlUiLzV3am0wSvZZftmFsM29BSx8ppy0V/dDAwphu+u7
 CyScF/c54n0sg==
Date: Mon, 13 Jan 2020 08:48:22 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries/svm: Disable BHRB/EBB/PMU access
Message-ID: <20200112214822.GA3536@blackberry>
References: <20200110051957.31714-1-sukadev@linux.ibm.com>
 <20200110051957.31714-2-sukadev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110051957.31714-2-sukadev@linux.ibm.com>
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
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 09, 2020 at 09:19:57PM -0800, Sukadev Bhattiprolu wrote:
> Ultravisor disables some CPU features like BHRB, EBB and PMU in
> secure virtual machines (SVMs). Skip accessing those registers
> in SVMs to avoid getting a Program Interrupt.

It would be useful to have more explanation of the rationale for the
ultravisor disabling access to those features, and indicate whether
this is a temporary restriction or a permanent one.  If SVMs are never
going to be able to use the PMU then that is a bad thing in my
opinion.  In other words, the commit message should tell us whether
the restriction is just because the ultravisor doesn't yet have code
for managing and context-switching the PMU, or if there is there some
reason why using the PMU in a SVM will always be prohibited for some
security-related reason.

Also, the only way that a SVM would be getting into the KVM code that
you are patching is if it is trying to do nested virtualization.
However, the SVM should already know that it is not able to do nested
virtualization because the ultravisor should be intercepting and
failing the H_SET_PARTITION_TABLE hypercall.  So I think there is no
good reason for patching the KVM code like you are doing unless the
PMU restriction is permanent and we are intending someday to enable
SVMs to have nested guests.

Paul.
