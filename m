Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:01:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B524D2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="oItDusSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B524D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4478t50029zDqGX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 16:01:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4478r72smczDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 15:59:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="oItDusSQ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4478r66Dmbz9s71; Mon, 25 Feb 2019 15:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551070774; bh=dndVbf+6J7HZ46a4yN0+aJ3egBdytRb6gAdL6sFWA68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oItDusSQbTiNNcfsI9FdY3iIfrZYwbwEBGIV0JAWViYZe/B+v6lDVg3GGzRgMIOfK
 Wqm1ZKJ8Gs/eA08uVy06ofTseW64qLjH5papCtM/rtj9FIdeeyWbhktfNaAODmhNxW
 v7GzQxiGoF2QhK7+BuzqlKk2hhr5YHkWhwPLxuwgjDc6jTc7rQxUGHBpZetC/q/UNG
 lW4QIZv6AppGf1uX+5VXlBXFb9H6jbVfvFqy8AAVh2O8DV+/EarU67nVWgsTsaCRUl
 i208O7mSQxwDSLPsvGNRcpxL8bk13CyocVJrwZE5dOHVg3nkihTA4XMeYFDBFE0I6j
 RPYrC9fUUvCNA==
Date: Mon, 25 Feb 2019 15:59:31 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
Message-ID: <20190225045931.GB20501@blackberry>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org>
 <20190225003527.GG7668@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225003527.GG7668@umbus.fritz.box>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 25, 2019 at 11:35:27AM +1100, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:27PM +0100, Cédric Le Goater wrote:
> > +	xc->xive = xive;
> > +	xc->vcpu = vcpu;
> > +	xc->server_num = cpu;
> > +	xc->vp_id = xive->vp_base + cpu;
> 
> Hrm.  This ties the internal VP id to the userspace chosen server
> number, which isn't ideal.  It puts a constraint on those server
> numbers that you wouldn't otherwise have.

We should probably do the same as the xics-on-xive code, which is to
put the server number through kvmppc_pack_vcpu_id(), which is a
folding function that maps the QEMU vcpu id (which is the server
number) down to the range 0..KVM_MAX_VCPUS-1, and works for the
allocation patterns used in the various vSMT modes.

Paul.

