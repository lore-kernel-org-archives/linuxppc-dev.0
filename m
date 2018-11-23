Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD72C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 07:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9398C206B2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 07:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x5vsebnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9398C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431Shc3PkDzDqK6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 18:33:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="x5vsebnT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="x5vsebnT"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431Sdn18vszDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 18:30:36 +1100 (AEDT)
Received: from localhost (unknown [40.114.107.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AEF920861;
 Fri, 23 Nov 2018 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542958234;
 bh=FiCDtrn2TJ7QNnw/0Qlqo5XiIab9DrroFiYvC51RGug=;
 h=Date:From:To:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
 References:From;
 b=x5vsebnTHFKUQiBB4G4k8sG7O4bwbZGCXBwG1g1k8qnPzt9amC3keXnZPIDvghTBI
 TsVHXL9V2wkthPhTcvKCFFJltm9oMIIlAGPO2FMSxgOJevD4/yb2s/jao/4i/sGIuO
 SKgNwbQqzup6+gk9oYoRWTKUZa2QzM/rRlH8Uc4U=
Date: Fri, 23 Nov 2018 07:30:33 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [for-next][PATCH 09/18] powerpc/function_graph: Simplify with
 function_graph_entry()
In-Reply-To: <20181122003332.643482042@goodmis.org>
References: <20181122003332.643482042@goodmis.org>
Message-Id: <20181123073034.4AEF920861@mail.kernel.org>
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
Cc: , linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 03274a3ffb44 tracing/fgraph: Adjust fgraph depth before calling trace return callback.

The bot has tested the following trees: v4.19.3, v4.14.82, v4.9.138, v4.4.164, v3.18.126.

v4.19.3: Build OK!
v4.14.82: Build OK!
v4.9.138: Failed to apply! Possible dependencies:
    Unable to calculate

v4.4.164: Failed to apply! Possible dependencies:
    Unable to calculate

v3.18.126: Failed to apply! Possible dependencies:
    Unable to calculate


How should we proceed with this patch?

--
Thanks,
Sasha
