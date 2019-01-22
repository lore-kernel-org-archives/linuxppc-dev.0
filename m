Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A5C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:55:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1A220879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SoyO4wVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1A220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHgs6ldxzDq5n
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:55:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPy1xMmzDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:43:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SoyO4wVf"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPt3m7dz9sBn; Tue, 22 Jan 2019 16:42:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135778; bh=WwvrGeXy1XuTbwAKCBNrKkOlbvMM+ohvhXPpV2cMuqw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SoyO4wVflJ6viF1cWyPgI/L0IKmTDumN1Xum3xD8rMEBuyPef1YmbYvXwvpJBSyj1
 WZ5sJOuBIXVfLAnmBsxNzRBUquJ4wh17JAL5XCNwEd/KtJN5XGZFC/jPBuR5aLn7v2
 YDvVxOHXofs94AAM19gvb4CzQ7rWvCnxLOYx9Efh9kh+F2V+85ySqkyfI7GP4t4tND
 inoof7U0k+3DnN1Ybdbo9xnNOLWNCQGAj1Kkt9XouW0Vw0Dx7AktmyY6i9aegVnq6y
 eMhxZvjb8LmwzHuGjxGDaFME6bZUEDP72MkVtAazILPVmxmWl6K+FJtIW82VYbRY/z
 hHQsueA/2p5yw==
Date: Tue, 22 Jan 2019 16:14:30 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 08/19] KVM: PPC: Book3S HV: add a VC_BASE control to the
 XIVE native device
Message-ID: <20190122051430.GE15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107184331.8429-9-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 07, 2019 at 07:43:20PM +0100, Cédric Le Goater wrote:
> The ESB MMIO region controls the interrupt sources of the guest. QEMU
> will query an fd (GET_ESB_FD ioctl) and map this region at a specific
> address for the guest to use. The guest will obtain this information
> using the H_INT_GET_SOURCE_INFO hcall. To inform KVM of the address
> setting used by QEMU, add a VC_BASE control to the KVM XIVE device

This needs a little more explanation.  I *think* the only way this
gets used is that it gets returned to the guest by the new
hypercalls.  If that is indeed the case it would be useful to mention
that in the patch description, because otherwise taking a value that
userspace provides and which looks like it is an address, and not
doing any validation on it, looks a bit scary.

Paul.
