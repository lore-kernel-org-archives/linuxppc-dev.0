Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC12C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:39:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1822192C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1822192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MCTM5g0SzDqY6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MCRG3hBMzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 15:38:02 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gaZ0s-0000VD-Fz; Fri, 21 Dec 2018 22:35:47 -0600
Message-ID: <5f83750ca7c146f7080444b85dc58f51cc0b3b35.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Andy Tang <andy.tang@nxp.com>
Date: Fri, 21 Dec 2018 22:35:45 -0600
In-Reply-To: <VI1PR04MB43332FE4914896FCBE8E997FF3A70@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20181031065736.32719-1-andy.tang@nxp.com>
 <09ee2f91765add47e628e0ab03776d468cec0914.camel@buserror.net>
 <VI1PR04MB43332FE4914896FCBE8E997FF3A70@VI1PR04MB4333.eurprd04.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: andy.tang@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 1/2 v3] powerpc/fsl: Use new clockgen binding
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-12-12 at 01:57 +0000, Andy Tang wrote:
> > -----Original Message-----
> > From: Scott Wood <oss@buserror.net>
> > Sent: 2018年11月26日 9:19
> > To: Andy Tang <andy.tang@nxp.com>
> > Cc: mturquette@baylibre.com; sboyd@kernel.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; benh@kernel.crashing.org; paulus@samba.org;
> > mpe@ellerman.id.au; linux-clk@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/2 v3] powerpc/fsl: Use new clockgen binding
> > 
> > On Wed, 2018-10-31 at 14:57 +0800, Yuantian Tang wrote:
> > > From: Scott Wood <oss@buserror.net>
> > > 
> > > The driver retains compatibility with old device trees, but we don't
> > > want the old nodes lying around to be copied, or used as a reference
> > > (some of the mux options are incorrect), or even just being clutter.
> > > 
> > > 
> > > +sysclk: sysclk {
> > > +	compatible = "fixed-clock";
> > > +	#clock-cells = <0>;
> > > +	clock-frequency = <100000000>;
> > > +	clock-output-names = "sysclk";
> > > +};
> > > +
> > >  clockgen: global-utilities@e1000 {
> > 
> > The U-Boot fixup won't work with this.  U-Boot patches the frequency
> > directly into the clockgen node (BTW, this is another reason to preserve
> > the generic
> > 1.0/2.0 compatible string).  The new binding does not require an input
> > clock node when it is provided as clock-frequency directly in the clockgen
> > node -- and the sysclk node was not in my original patch (nor did you note
> > that you made changes from that original).  Why did you add it?
> > 
> > I would just remove it when applying, but I'm concerned that this
> > indicates
> > a lack of testing (and I don't have the hardware access to test it myself,
> > except on t4240) -- unless the 100 MHz sysclk just happened to be correct
> > on the machines you tested (which would also be a test coverage
> > problem)?
> 
> [Andy] You are right. Sysclk may not be useful anymore. 
> Uboot will fixup the clockgen node correctly. Please apply this patch
> without sysclk. We will
> test it and catch the error if the clock is not fixed correctly.

OK.

> BTW, which git tree are you going to apply it on? This one?
> 
https://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git/log/?h=next

That will be the branch I use to send the patches to Michael, but it's not a
branch that is kept constantly updated.  If you're asking what tree to base
future patches on, that would generally be the next branch of
powerpc/linux.git (unless you depend on something else that isn't there yet).

-Scott


