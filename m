Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB766C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 08:36:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B08F206C3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi1iTpYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B08F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wQTq6BXmzDqdb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 18:36:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oi1iTpYH"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wQSQ61NNzDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 18:35:34 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB30D206C3;
 Fri,  3 May 2019 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556872532;
 bh=FSlo1Nq4/yEaFf/hwJ2VQgNN7KqmlI02Yct8KIHddrc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oi1iTpYH+AES0GvQxMfCV5xS58SpL8Wg/t2n2aYg2Qhr5kEUeVWH+pZ/wPneGe2TF
 gLv4Vydz7/byN9b/K38GN49tStVZ1uKbi+W9dJvfaHzaiBHLgjIuyUJ6JeZEg3i/4l
 hRLqqmV0Q7WdgGLJttl2E5cOYGaLST/ZxDL0F1tQ=
Date: Fri, 3 May 2019 10:35:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/powernv: Restrict OPAL symbol map to only be
 readable by root
Message-ID: <20190503083529.GA17715@kroah.com>
References: <20190503075253.22798-1-ajd@linux.ibm.com>
 <20190503075916.GA14960@kroah.com>
 <f584ce91-a49b-ef33-7090-cb0a91b87e82@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f584ce91-a49b-ef33-7090-cb0a91b87e82@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Stewart Smith <stewart@linux.ibm.com>, Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 03, 2019 at 06:27:18PM +1000, Andrew Donnellan wrote:
> On 3/5/19 5:59 pm, Greg KH wrote:>> -static BIN_ATTR_RO(symbol_map, 0);
> > > +static struct bin_attribute symbol_map_attr = {
> > > +	.attr = {.name = "symbol_map", .mode = 0400},
> > > +	.read = symbol_map_read
> > > +};
> > 
> > There's no real need to rename the structure, right?  Why not just keep
> > the bin_attr_symbol_map name?  That would make this patch even smaller.
> 
> No real need but it's locally more consistent with the rest of the PPC code.
> (Though perhaps the other cases should use the BIN_ATTR macro...)
> 
> Given this is for stable I'm happy to change that if the smaller patch is
> more acceptable.

stable doesn't care, and if this is more consistent, that's fine with
me, I didn't see the larger picture here, just providing unsolicited
patch review :)

> > >   static void opal_export_symmap(void)
> > >   {
> > > @@ -698,10 +701,10 @@ static void opal_export_symmap(void)
> > >   		return;
> > >   	/* Setup attributes */
> > > -	bin_attr_symbol_map.private = __va(be64_to_cpu(syms[0]));
> > > -	bin_attr_symbol_map.size = be64_to_cpu(syms[1]);
> > > +	symbol_map_attr.private = __va(be64_to_cpu(syms[0]));
> > > +	symbol_map_attr.size = be64_to_cpu(syms[1]);
> > > -	rc = sysfs_create_bin_file(opal_kobj, &bin_attr_symbol_map);
> > > +	rc = sysfs_create_bin_file(opal_kobj, &symbol_map_attr);
> > 
> > Meta-comment, odds are you are racing userspace when you create this
> > sysfs file, why not add it to the device's default attributes so the
> > driver core creates it for you at the correct time?
> 
> I was not previously aware of default attributes...
> 
> Are we actually racing against userspace in a subsys initcall?

You can be, if you subsys is a module :)

thanks,

greg k-h
