Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD2BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC36820818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="NQtoOTsn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQ1NolWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC36820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445BdH5kMRzDqTX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:13:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="NQtoOTsn"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="cQ1NolWA"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Bbf713ZzDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 11:11:58 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2E72721DA6;
 Thu, 21 Feb 2019 19:11:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 19:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 FNd4Cn7WvHska6I/7VkOpFrTaCEZha8lOQPmi9WBbq8=; b=NQtoOTsnL60EtTDb
 pkt2V/QMIxo0Ojv1hM8AUJWjZLK0QmfGiWeHOJ420Ll51J9JtS95pGM+AHYXnX2t
 k3nUlUHeE6EFjvlfxpwm+WmhTpqbbs2JRiTJPFbE5KqElVsb/c6zd8EGb9De3ceB
 BfxwxknPCgyyns7fbyD1+PHsjsCLC/qbRwnd76wpLGqmjnqhSO7Nffa1f9v9CK/J
 QDK/CYlggM8LAiIN/VJyAmIRz0U3AJ4K7ZkUQI5Th63E+GY5N3MMsrGzFK6FgQg2
 VxXZCU+eBKI2iBe9dUF+Fn+hjnTbWl5A5VVHQ9Zt20nEczQUYUuV1+acfj6RY2s4
 Lf/HPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=FNd4Cn7WvHska6I/7VkOpFrTaCEZha8lOQPmi9WBb
 q8=; b=cQ1NolWAymbEsJjr8yeHOQqoQLb4yhqXvyaPUvI2D1LG9V9YFAWogW+P9
 /3BcHwqRZxHJYz0OejsCa3vvCkqWA0JGkfpBP3nQ0f7VNzDX4wIfvkRzfkjKtsko
 VjjfT1AWclriHw3qdcJb/IbZGnjCj6cq+wNf4QJIL/8dB4wVBucXfrh0s1AUo9T9
 tUKeRLXO6OlhK47qQUdcU1n6EWg9IKh62S//9aGvszTtTCPBqmio4N1A27iDIt8Z
 NR/BMDVpXO0cgoIog3v3JKMrsB+3tVHq39WNJFygt6CnrN+QwAMJZ2oRbaQMpmWz
 hERLHf+SNlXiwTRrYevDc72FQ9JgA==
X-ME-Sender: <xms:Sj5vXNBVrYB_p5kgF65zutyb5ub7T2ymWxCxxPEHWYhtLRRyGNMz7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdelgddujeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdludehmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddv
 rdelledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruh
 hsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Sj5vXOS18Chzaj96gge-ld5SQZjEM4emlbqRpB3ryyqpKTP9TWDPkA>
 <xmx:Sj5vXFfldKthe4Z_vqThEQjfm5dz7GPPi5shpmIThq9RSs3zi7lG-Q>
 <xmx:Sj5vXPSABOIoGJxrTVqj2jstgU3Bvi2KA8bIciWz32dBux2t99KaDw>
 <xmx:TD5vXLqUepPGrUlIBTtyuUNXabeYqKs6LRggS468E_Z5ZgC_BUFqVw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 75BDEE419A;
 Thu, 21 Feb 2019 19:11:52 -0500 (EST)
Message-ID: <3ee891ded467e1fd473c9b075658b959e091e8f6.camel@russell.cc>
Subject: Re: [PATCH 3/7] powerpc/mm: Add a framework for Kernel Userspace
 Access Protection
From: Russell Currey <ruscur@russell.cc>
To: Mark Rutland <mark.rutland@arm.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>
Date: Fri, 22 Feb 2019 11:11:49 +1100
In-Reply-To: <20190221144818.GI33673@lakrids.cambridge.arm.com>
References: <20190221093601.27920-1-ruscur@russell.cc>
 <20190221093601.27920-4-ruscur@russell.cc>
 <adb2b7c9-3472-2b9c-37e1-6150697d0940@c-s.fr>
 <20190221144818.GI33673@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-21 at 14:48 +0000, Mark Rutland wrote:
> On Thu, Feb 21, 2019 at 11:46:06AM +0100, Christophe Leroy wrote:
> > 
> > Le 21/02/2019 à 10:35, Russell Currey a écrit :
> > > From: Christophe Leroy <christophe.leroy@c-s.fr>
> > > 
> > > This patch implements a framework for Kernel Userspace Access
> > > Protection.
> > > 
> > > Then subarches will have to possibility to provide their own
> > > implementation by providing setup_kuap() and
> > > lock/unlock_user_access()
> > > 
> > > Some platform will need to know the area accessed and whether it
> > > is
> > > accessed from read, write or both. Therefore source, destination
> > > and
> > > size and handed over to the two functions.
> > 
> > Should we also consider adding user_access_begin() and the 3 other
> > associated macros ?
> > 
> > See x86 for details.
> 
> As a heads-up, there are some potential issues with
> user_access_{begin,end}() that may affect PPC. There's a long thread
> starting at:
> 
> https://lkml.kernel.org/r/1547560709-56207-4-git-send-email-julien.thierry@arm.com/

I'd say we should look at adding those macros, but as follow-up work
after this series (and after we know what's going on with those issues)

- Russell

> 
> Thanks,
> Mark.

