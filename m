Return-Path: <SRS0=SBso=6B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F8C2BB1D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 22:56:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B944F214AF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 22:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B944F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 493s024tYZzDrhm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 08:56:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 493ry13GmczDrRM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 08:54:33 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1jPZoE-0007S8-1q; Fri, 17 Apr 2020 17:50:06 -0500
Message-ID: <eb73fb40c2d102f24cf4d9a4ba26ffeea278b715.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: =?UTF-8?Q?=E7=8E=8B=E6=96=87=E8=99=8E?= <wenhu.wang@vivo.com>
Date: Fri, 17 Apr 2020 17:50:04 -0500
In-Reply-To: <APIAAAABCKquIIhDNOkcHqp9.3.1587132987353.Hmail.wenhu.wang@vivo.com>
References: <APIAAAABCKquIIhDNOkcHqp9.3.1587132987353.Hmail.wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, gregkh@linuxfoundation.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, kernel@vivo.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v4,4/4] drivers: uio: new driver for fsl_85xx_cache_sram
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
Cc: Rob Herring <robh@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@vivo.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-04-17 at 22:16 +0800, 王文虎 wrote:
> > On Fri, 2020-04-17 at 09:42 +0200, Greg KH wrote:>> On Thu, Apr 16, 2020
> > at 11:58:29PM -0500, Scott Wood wrote:
> > > > On Fri, 2020-04-17 at 10:31 +0800, 王文虎 wrote:
> > > > > Sounds it is. And does the modification below fit well?
> > > > > ---
> > > > > -static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> > > > > -       {       .compatible = "uio,mpc85xx-cache-sram", },
> > > > > -       {},
> > > > > +#ifdef CONFIG_OF
> > > > > +static struct of_device_id uio_fsl_85xx_cache_sram_of_match[] = {
> > > > > +       { /* This is filled with module_parm */ },
> > > > > +       { /* Sentinel */ },
> > > > >  };
> > > > > +MODULE_DEVICE_TABLE(of, uio_fsl_85xx_cache_sram_of_match);
> > > > > +module_param_string(of_id,
> > > > > uio_fsl_85xx_cache_sram_of_match[0].compatible,
> > > > > +                           sizeof(uio_fsl_85xx_cache_sram_of_match[
> > > > > 0].c
> > > > > ompa
> > > > > tible), 0);
> > > > > +MODULE_PARM_DESC(of_id, "platform device id to be handled by cache-
> > > > > sram-
> > > > > uio");
> > > > > +#endif
> > > > 
> > > > No.  The point is that you wouldn't be configuring this with the
> > > > device
> > > > tree
> > > > at all.
> > > 
> > > Wait, why not?  Don't force people to use module parameters, that is
> > > crazy.  DT describes the hardware involved, if someone wants to bind to
> > > a specific range of memory, as described by DT, why can't they do so?
> > 
> > Yes, DT describes the hardware, and as I've said a couple times already,
> > this
> > isn't hardware description.
> > 
> > I'm not forcing people to use module parameters.  That was a least-effort
> > suggestion to avoid abusing the DT.  I later said I'd try to come up with
> > a
> > patch that allocates regions dynamically (and most likely doesn't use UIO
> > at
> > all).
> > 
> > > I can understand not liking the name "uio" in a dt tree, but there's no
> > > reason that DT can not describe what a driver binds to here.
> > 
> > The DT already describes this hardware, and there is already code that
> > binds
> > to it.  This patch is trying to add a second node for it with
> > configuration.
> > 
> 
> Hi, Scott, Greg,
> Seems like no balance here. How about I implement a driver of uio including
> the l2ctrl and cache_sram related implementations?
> And this way, the driver would be a hardware level driver and targeted for
> uio.

No, duplicating the code makes no sense whatsoever.  Please just wait a bit
and I'll send a patch to have the existing driver expose a dynamic allocation
interface to userspace.

-Scott


