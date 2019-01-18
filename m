Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AF1C43444
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 09:46:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF652086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 09:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF652086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tmux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gx102tQ0zDqvK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 20:46:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gwyt1pJRzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 20:44:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tmux.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43gwyt0FV3z8tRR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 20:44:54 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43gwys6wt3z9sDr; Fri, 18 Jan 2019 20:44:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=fail (mailfrom) smtp.mailfrom=tmux.org
 (client-ip=2001:41d0:a:1408::1; helo=atom2.tmux.org;
 envelope-from=tobiasu@tmux.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tmux.org
Received: from atom2.tmux.org (unknown [IPv6:2001:41d0:a:1408::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43gwyr69vHz9sBZ
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 20:44:52 +1100 (AEDT)
Received: by atom2.tmux.org (Postfix, from userid 1000)
 id 1CA8961FA1; Fri, 18 Jan 2019 09:44:42 +0000 (UTC)
Date: Fri, 18 Jan 2019 10:44:42 +0100
From: Tobias Ulmer <tobiasu@tmux.org>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
Message-ID: <20190118094441.g2izgpvte6hvq354@atom2.tmux.org>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
 <20190118022241.GA21381@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118022241.GA21381@blackberry>
User-Agent: NeoMutt/20170113 (1.7.2)
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

On Fri, Jan 18, 2019 at 01:22:41PM +1100, Paul Mackerras wrote:
> On Tue, Jan 15, 2019 at 11:49:45PM +0100, Tobias Ulmer wrote:
> > Hi,
> > 
> > both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
> 
> Interesting, I just built v4.20 with g5_defconfig for my quad and it
> booted just fine.  I'll try Linus' latest.
> 
> It could be config-related; could you send me your .config (off-list)?
> 
> Paul.

dmesg: http://ix.io/1yAB
config: http://ix.io/1yAC

Have fun :)
