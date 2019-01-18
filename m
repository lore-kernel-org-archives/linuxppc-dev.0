Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D1C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 02:24:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2E920873
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 02:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="CXAMR9oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2E920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43glBW4Yk4zDqpf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 13:24:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gl8p0FHnzDqnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 13:22:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="CXAMR9oZ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 43gl8n5v1yz9sDn; Fri, 18 Jan 2019 13:22:49 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43gl8n4m4nz9sDr; Fri, 18 Jan 2019 13:22:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1547778169; bh=h+P8C3v/yrzZ/ZKgcQUZbjDoxhrv9s6KbjQLKC+AzFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CXAMR9oZsycQTVKcVDiLmeTmLHnEtL2IGi+OoKPTA5+V1QSP4YLt09VWAgcuhXj0u
 rMYkdveusW7585P5V+9JmraJpmPL2Nq/XEn0XlFv8C2Pv3waSdRPBMeNwqk5Djx+ne
 AXMfsWXFaXQd0fa87jR45EwBWpZ27XqyAHabfp4xTojc9EfOxnX8F+1ZYBj7H7RWv7
 HQOqGskHpVcXU3qV/Y3/ec0Y5ZmwOvo9ihQQ7zrUmSTMTID6NDYA/HYGqguFvN2TX8
 wNbEFVMEhwp7/xIVmDJQXzFiaMLTJaOs6QyN1IV6ZRJZJrYFhgeSrPlUq11b2IyHX9
 x4KHJW/1nnVSg==
Date: Fri, 18 Jan 2019 13:22:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Tobias Ulmer <tobiasu@tmux.org>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
Message-ID: <20190118022241.GA21381@blackberry>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 11:49:45PM +0100, Tobias Ulmer wrote:
> Hi,
> 
> both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.

Interesting, I just built v4.20 with g5_defconfig for my quad and it
booted just fine.  I'll try Linus' latest.

It could be config-related; could you send me your .config (off-list)?

Paul.
