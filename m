Return-Path: <SRS0=O+98=EN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50413C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 01:32:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4900620728
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 01:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdjWOpRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4900620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CSfrH4SgNzDrR2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 12:32:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=PdjWOpRt; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CSfpK0c6VzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2020 12:30:32 +1100 (AEDT)
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown
 [163.114.132.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B01A320720;
 Sat,  7 Nov 2020 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604712630;
 bh=vF0C8wz4M/uY4AHsyooxIkvLo7CRA7A8pr3KQ0xdG0Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PdjWOpRtK7AjxbOkGxdiGSBetvTzSBlz1XEIUgWKYBIR+GPyNW8By8l8bUylXex6k
 IEChhmaEA1vk3ZTrfSOG1eV5Mv1lMGQX9yj7jpnfzsSjGw+qI1DeGwdDAhXj860q1N
 fJWzmNmy8jw4KFDy8ocFw/Qf4D6lI9u+Zx4wA6RM=
Date: Fri, 6 Nov 2020 17:30:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dany Madden <drt@linux.ibm.com>
Subject: Re: [PATCH net-next] Revert ibmvnic merge do_change_param_reset
 into do_reset
Message-ID: <20201106173028.2490f7b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201106191745.1679846-1-drt@linux.ibm.com>
References: <20201106191745.1679846-1-drt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri,  6 Nov 2020 14:17:45 -0500 Dany Madden wrote:
> This reverts commit 16b5f5ce351f8709a6b518cc3cbf240c378305bf
> where it restructures do_reset. There are patches being tested that
> would require major rework if this is committed first. 
> 
> We will resend this after the other patches have been applied.
> 
> Signed-off-by: Dany Madden <drt@linux.ibm.com>

Applied, thanks.
