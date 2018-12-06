Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DDC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:42:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E1120989
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439QyP0cVwzDqK3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:42:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=osadl.at
 (client-ip=178.115.242.59; helo=mail.osadl.at; envelope-from=hofrat@osadl.at;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=hofr.at
X-Greylist: delayed 414 seconds by postgrey-1.36 at bilbo;
 Thu, 06 Dec 2018 17:40:37 AEDT
Received: from mail.osadl.at (178.115.242.59.static.drei.at [178.115.242.59])
 by lists.ozlabs.org (Postfix) with ESMTP id 439Qw55nVGzDr0k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 17:40:37 +1100 (AEDT)
Received: by mail.osadl.at (Postfix, from userid 1001)
 id 768FD5C0F63; Thu,  6 Dec 2018 06:32:57 +0000 (UTC)
Date: Thu, 6 Dec 2018 07:32:57 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
Message-ID: <20181206063257.GA30835@osadl.at>
References: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
 <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, hofrat@osadl.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 02:42:55PM -0600, Li Yang wrote:
> On Sun, Dec 2, 2018 at 3:07 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > devm_kstrdup() may return NULL if internal allocation failed.
> > soc_dev_attr.machine  should be checked (although its only use
> > in pr_info() would be safe even with a NULL). Therefor
> > in the unlikely case of allocation failure, fsl_guts_probe() returns
> > -ENOMEM as this allocating failing is an indication of something
> > more serious going wrong at system level.
> >
> > As  machine  is from the device tree which I assume to be RO - if
> > that assumption is always correct - a better alternative would be
> > to use devm_kstrdup_const() here. That would then simply copy the
> > reference to the RO data and not perform any allocation at all.
> 
> I think your assumption is correct.  Do you want to send a new and
> better version?  :)

The issue was actually more general that I did not find a reliable
method to assure that some object is *always* RO. Even for device
tree data it was not clear to me if there could be systems where
it is not RO.
Anyway - will send the version using devm_kstrdup_const() then.

thx!
hofrat

> 
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
> > ---
> >
> > Problem located by experimental coccinelle script
> >
> > Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)
> >
> > Patch is against 4.20-rc4 (localversion-next is next-20181130)
> >
> >  drivers/soc/fsl/guts.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> > index 302e0c8..a0c751b 100644
> > --- a/drivers/soc/fsl/guts.c
> > +++ b/drivers/soc/fsl/guts.c
> > @@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
> >         if (of_property_read_string(root, "model", &machine))
> >                 of_property_read_string_index(root, "compatible", 0, &machine);
> >         of_node_put(root);
> > -       if (machine)
> > +       if (machine) {
> >                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> > +               if (!soc_dev_attr.machine)
> > +                       return -ENOMEM;
> > +       }
> >
> >         svr = fsl_guts_get_svr();
> >         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> > --
> > 2.1.4
> >
