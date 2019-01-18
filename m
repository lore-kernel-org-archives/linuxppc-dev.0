Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95726C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 00:53:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54FD20873
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 00:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54FD20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tmux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gj951BFJzDqty
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gj7T3GTlzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:51:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tmux.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43gj7T2D3vz8t4h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:51:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43gj7T1gzPz9sDr; Fri, 18 Jan 2019 11:51:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=fail (mailfrom) smtp.mailfrom=tmux.org
 (client-ip=2001:41d0:a:1408::1; helo=atom2.tmux.org;
 envelope-from=tobiasu@tmux.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tmux.org
Received: from atom2.tmux.org (unknown [IPv6:2001:41d0:a:1408::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43gj7S3DrTz9sCh
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 11:51:31 +1100 (AEDT)
Received: by atom2.tmux.org (Postfix, from userid 1000)
 id 458D461F9F; Fri, 18 Jan 2019 00:51:24 +0000 (UTC)
Date: Fri, 18 Jan 2019 01:51:24 +0100
From: Tobias Ulmer <tobiasu@tmux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
Message-ID: <20190118005124.oktx5nebsyy47zbg@atom2.tmux.org>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
 <8f112153558ae8ffdefba905d83329c8e896d3a9.camel@kernel.crashing.org>
 <20190117094214.26t72sdqknfzxvlx@atom2.tmux.org>
 <ae9672a789b29a546c12149650f0a7f6ab6b762d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9672a789b29a546c12149650f0a7f6ab6b762d.camel@kernel.crashing.org>
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
Cc: linuxppc-dev@ozlabs.org, Rob Herring <robh@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 09:32:07AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2019-01-17 at 10:42 +0100, Tobias Ulmer wrote:
> > On Wed, Jan 16, 2019 at 12:15:14PM +1100, Benjamin Herrenschmidt wrote:
> > > On Tue, 2019-01-15 at 23:49 +0100, Tobias Ulmer wrote:
> > > > Hi,
> > > > 
> > > > both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
> > > > 
> > > > Surely I'm not the first to run into this, but I couldn't find any
> > > > discussion or bug report. Sorry if you're already aware.
> > > > 
> > > > You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
> > > > the watchdog triggers a reboot:
> > > > 
> > > > https://i.imgur.com/UiCVRuG.jpg
> > > > 
...
> I'll be back on monday or tuesday, let me know where you got up to then
> and I'll take it from there. Also email me your .config please.


Hi,

this was caused by 5c63e407aaabb0464236cfc6279a2d79aede7073
(fbdev: Convert to using %pOFn instead of device_node.name)

name can't be NULL into offb_init_fb, there's a printk and the call to
offb_init_palette_hacks where name is matched against OF device names.

With the partial revert below, both 5.0-rc2+ and 4.20 are happy.

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 31f769d67195..77c0a2f45b3b 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -419,13 +419,9 @@ static void __init offb_init_fb(const char *name,
 	var = &info->var;
 	info->par = par;
 
-	if (name) {
-		strcpy(fix->id, "OFfb ");
-		strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
-		fix->id[sizeof(fix->id) - 1] = '\0';
-	} else
-		snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
-
+	strcpy(fix->id, "OFfb ");
+	strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
+	fix->id[sizeof(fix->id) - 1] = '\0';
 
 	var->xres = var->xres_virtual = width;
 	var->yres = var->yres_virtual = height;
@@ -648,7 +644,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") == 0)
 			address += 0x1000;
-		offb_init_fb(no_real_node ? "bootx" : NULL,
+		offb_init_fb(no_real_node ? "bootx" : dp->name,
 			     width, height, depth, pitch, address,
 			     foreign_endian, no_real_node ? NULL : dp);
 	}
