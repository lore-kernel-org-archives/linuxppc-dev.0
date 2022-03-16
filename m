Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C5C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Mar 2022 18:18:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJdnS4nkwz30Cm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Mar 2022 05:18:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qVEYGKYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qVEYGKYG; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJdmn4tr1z306h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2022 05:18:01 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E5267B81C85;
 Wed, 16 Mar 2022 18:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EE3C340E9;
 Wed, 16 Mar 2022 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647454676;
 bh=ty9fvidTblGxeLPSwUlqHqYfuHutWabBH5Zz8wkNXLw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qVEYGKYGGO4BM45uQ9udLJ8IPF7bPv56c0a+MYMQIBujOuB1YObzev6L/4CPhIeb9
 DArNEKl94nlSAvom7vVJsntVJTxguxyReefSjRCb9IlCOkHwzFJpE3vBIlXcYuNSGV
 kMJB7nAdSFwauBIX3rC6sA+opf8vt3WIG2O8uBQefJRTNICExBfzD2iWPrDbo71qCM
 0rqZndnIyT/WEL1lAchK2OBYR1en4OeA/E0UAlU1VK70RxI21Xuq4XZBy3u5a/Q5LS
 m45Z3kAEEvMQmd++h1iLqkEhZHbl/5h/aqBtL91NTl202fRszYj+wkhC2OC8vR/Qi7
 9nKZeSRnfagPA==
Date: Wed, 16 Mar 2022 11:17:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Subject: Re: [EXT] Re: bnx2x: ppc64le: Unable to set message level greater
 than 0x7fff
Message-ID: <20220316111754.5316bfb5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <BY3PR18MB4612AD5E7F7D59233990A21DAB119@BY3PR18MB4612.namprd18.prod.outlook.com>
References: <0497a560-8c7b-7cf8-84ee-bde1470ae360@molgen.mpg.de>
 <20220315183529.255f2795@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <db796473-69cf-122e-ec40-de62659517b0@molgen.mpg.de>
 <ade0ed87-be4f-e3c7-5e01-4bfdb78fae07@molgen.mpg.de>
 <BY3PR18MB4612AD5E7F7D59233990A21DAB119@BY3PR18MB4612.namprd18.prod.outlook.com>
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
Cc: Michal Kubecek <mkubecek@suse.cz>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Ariel Elior <aelior@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "it+netdev@molgen.mpg.de" <it+netdev@molgen.mpg.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Sudarsana Reddy Kalluru <skalluru@marvell.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 16 Mar 2022 11:49:39 +0000 Manish Chopra wrote:
> As ethtool over netlink has some limitations of the size,
> I believe you can configure ethtool with "--disable-netlink" and set those message levels fine

Yup, IIUC it works for Paul on a 5.17 system, that system likely has
old ethtool user space tool which uses ioctls instead of netlink.

What makes the netlink path somewhat non-trivial is that there is 
an expectation that the communication can be based on names (strings)
as well as bit positions. I think we'd need a complete parallel
attribute to carry vendor specific bits :S
