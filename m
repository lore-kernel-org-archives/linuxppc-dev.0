Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7457BECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:51:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36E121526
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi+951KH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36E121526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZkrM6PzlzF3Xv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 18:50:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gi+951KH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=2cro=m5=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gi+951KH"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zknh2qsCzF3NT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 18:48:36 +1100 (AEDT)
Received: from localhost (unknown [188.88.119.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 05FE2214C3;
 Wed, 17 Oct 2018 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539762514;
 bh=DH0a2DtgbaKHK9xmp9Xrj/M2dX3cgPzO9DrTkfK4MeA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gi+951KH3zqKli0DmzmNbwMdXNnBuBcURr648sYbdFD0zt+r0+OgQhq5D/hW54VeE
 4bgyD1p5/e+ZYFcuU3EY7+sdcofHndVpVY1fFnAHgPf4WAOeTvZcA3Q9hTaWBDVGvq
 Pms/eZwwpRub2BSbe3Kic5vcI1GezcR09ho4FtoI=
Date: Wed, 17 Oct 2018 09:48:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 4.18 086/135] KVM: PPC: Book3S HV: Dont use
 compound_order to determine host mapping size
Message-ID: <20181017074831.GF25537@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170521.241312038@linuxfoundation.org>
 <20181016223224.GA27627@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016223224.GA27627@blackberry>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>,
 stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 17, 2018 at 09:32:25AM +1100, Paul Mackerras wrote:
> On Tue, Oct 16, 2018 at 07:05:16PM +0200, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > [ Upstream commit 71d29f43b6332badc5598c656616a62575e83342 ]
> 
> If you take 71d29f43b633 then you also need 6579804c4317 ("KVM: PPC:
> Book3S HV: Avoid crash from THP collapse during radix page fault",
> 2018-10-04).

Thanks, now queued up.

greg k-h
