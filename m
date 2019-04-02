Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 15:51:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C45720645
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 15:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLAlb+hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C45720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YYbC2QJpzDqNZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 02:51:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YYY26FrfzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 02:49:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="mLAlb+hs"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44YYY16QM7z8tQ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 02:49:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44YYY14qY9z9sTk; Wed,  3 Apr 2019 02:49:09 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="mLAlb+hs"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44YYY10gK8z9sTd
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 02:49:08 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E828420645;
 Tue,  2 Apr 2019 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1554220146;
 bh=FMMA7wqmvVJHagFCEFtG4EdDDjz1YWDF9d1ibcUiS2o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mLAlb+hsNN8toctm1rYynEfokTCD8Fwn3Yxp0iqc/7+3exuTmk4AIFISSEjrvFjXW
 6Vjy11amaKFxFPP7LYdt5hCxEK763MZF9xPVMwF9RBDr/ZM1bh9gbKqUgpYBhE+Mql
 oWDl/pFBzrKcIHqzoGzf5VFcLVoLMocCdVzpZSQ4=
Date: Tue, 2 Apr 2019 17:49:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Diana Madalina Craciun <diana.craciun@nxp.com>
Subject: Re: [PATCH stable v4.14 00/32] powerpc spectre backports for 4.14
Message-ID: <20190402154904.GA18023@kroah.com>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
 <20190329145116.GA23019@kroah.com>
 <20190329150921.GA1002@kroah.com>
 <87v9zzl68u.fsf@concordia.ellerman.id.au>
 <VI1PR0401MB246396C22088623F2971A0DCFF560@VI1PR0401MB2463.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB246396C22088623F2971A0DCFF560@VI1PR0401MB2463.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: "msuchanek@suse.de" <msuchanek@suse.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 02, 2019 at 03:21:09PM +0000, Diana Madalina Craciun wrote:
> On 3/31/2019 12:53 PM, Michael Ellerman wrote:
> > Greg KH <gregkh@linuxfoundation.org> writes:
> >> On Fri, Mar 29, 2019 at 03:51:16PM +0100, Greg KH wrote:
> >>> On Fri, Mar 29, 2019 at 10:25:48PM +1100, Michael Ellerman wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1 Hi Greg, Please queue
> >>>> up these powerpc patches for 4.14 if you have no objections. 
> >>> Some of these also need to go to 4.19, right? Want me to add them
> >>> there, or are you going to provide a backported series? 
> > Yes some of them do, but I wasn't sure if they'd go cleanly.
> >> Nevermind, I've queued up the missing ones to 4.19.y, and one missing
> >> one to 5.0.y. If I've missed anything, please let me know. 
> > Thanks. I'll check everything's working as expected.
> 
> I have validated on NXP PowerPC and worked as expected on both kernel
> 4.14 and kernel 4.19.

Great, thanks for testing!

greg k-h
