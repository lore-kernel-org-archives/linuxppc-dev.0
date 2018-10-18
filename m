Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EFFECDE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:38:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73B12054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5fxnTBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73B12054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bPBB5SynzF3CP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 20:38:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g5fxnTBj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=jz9f=m6=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="g5fxnTBj"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bP5C6LFczF3R8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 20:34:20 +1100 (AEDT)
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net
 [213.127.77.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43BA821473;
 Thu, 18 Oct 2018 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539855258;
 bh=XI2odgU4mrQHDnzv0Msmko8h7M+fcuGTzJtGToKlFqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g5fxnTBjQ9XxZ/i7MfjE/N9YlEDjgc3ve85i27O6n6rWsRvTS1qqW/VRP6pGiNV+L
 fujmh7cA2eF/IIs1C6R61twTSZZm6kiI2pDLraQv7WwrfMdmGR4WG/7+NwsOvMRPnh
 3CRgm+VIS3cNDAMY67DBl8faRn3YucSF+hn3j0Tk=
Date: Thu, 18 Oct 2018 11:34:16 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: David Gounaris <David.Gounaris@infinera.com>
Subject: Re: SV: MPC8321 boot failure
Message-ID: <20181018093416.GA22779@kroah.com>
References: <CY1PR10MB020424967E404E0B1BBE1E82EFFF0@CY1PR10MB0204.namprd10.prod.outlook.com>
 <0cbfec90-0e58-e267-71ae-c5fc8a8e0640@c-s.fr>
 <d534ec86-840e-11c9-fee6-f758370a9a0e@c-s.fr>
 <CY1PR10MB0204796CBD711EBA4F5286A4EFF80@CY1PR10MB0204.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY1PR10MB0204796CBD711EBA4F5286A4EFF80@CY1PR10MB0204.namprd10.prod.outlook.com>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Mathias Thore <Mathias.Thore@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 18, 2018 at 08:51:46AM +0000, David Gounaris wrote:
> Hi, I can also confirm that it works after cherry-picking the proposed commit.
> 
> Reported-and-tested-by: David Gounaris <david.gounaris@infinera.com<mailto:David.Gounaris@infinera.com>>
> 

Now queued up, thanks.

greg k-h
