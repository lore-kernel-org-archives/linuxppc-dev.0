Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6B8C76186
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 06:33:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72ADA206E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 06:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72ADA206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xqd427p4zDqMf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.72; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0072.hostedemail.com
 [216.40.44.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xqb46lmYzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 16:31:27 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id AC68383777ED;
 Mon, 29 Jul 2019 06:31:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: star39_8018288ec7e4b
X-Filterd-Recvd-Size: 3529
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA;
 Mon, 29 Jul 2019 06:31:20 +0000 (UTC)
Message-ID: <b0deb4e6b12ea1f943855440a3cc99a6e47d0717.camel@perches.com>
Subject: Re: [EXTERNAL][PATCH 1/5] PCI: Convert pci_resource_to_user to a
 weak function
From: Joe Perches <joe@perches.com>
To: Paul Burton <paul.burton@mips.com>, Denis Efremov <efremov@linux.com>
Date: Sun, 28 Jul 2019 23:31:18 -0700
In-Reply-To: <20190728224953.kezztdozc6k24ya3@pburton-laptop>
References: <20190728202213.15550-1-efremov@linux.com>
 <20190728202213.15550-2-efremov@linux.com>
 <20190728224953.kezztdozc6k24ya3@pburton-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
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
Cc: Michal Simek <monstr@monstr.eu>, James Hogan <jhogan@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2019-07-28 at 22:49 +0000, Paul Burton wrote:
> Hi Denis,
> 
> On Sun, Jul 28, 2019 at 11:22:09PM +0300, Denis Efremov wrote:
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9e700d9f9f28..1a19d0151b0a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1870,25 +1870,13 @@ static inline const char *pci_name(const struct pci_dev *pdev)
> >  	return dev_name(&pdev->dev);
> >  }
> >  
> > -
> >  /*
> >   * Some archs don't want to expose struct resource to userland as-is
> >   * in sysfs and /proc
> >   */
> > -#ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
> > -void pci_resource_to_user(const struct pci_dev *dev, int bar,
> > -			  const struct resource *rsrc,
> > -			  resource_size_t *start, resource_size_t *end);
> > -#else
> > -static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
> > -		const struct resource *rsrc, resource_size_t *start,
> > -		resource_size_t *end)
> > -{
> > -	*start = rsrc->start;
> > -	*end = rsrc->end;
> > -}
> > -#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
> > -
> > +void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
> > +				 const struct resource *rsrc,
> > +				 resource_size_t *start, resource_size_t *end);
> >  
> >  /*
> >   * The world is not perfect and supplies us with broken PCI devices.
> 
> This is wrong - using __weak on the declaration in a header will cause
> the weak attribute to be applied to all implementations too (presuming
> the C files containing the implementations include the header). You then
> get whichever impleentation the linker chooses, which isn't necessarily
> the one you wanted.
> 
> checkpatch.pl should produce an error about this - see the
> WEAK_DECLARATION error introduced in commit 619a908aa334 ("checkpatch:
> add error on use of attribute((weak)) or __weak declarations").

Unfortunately, checkpatch is pretty stupid and only emits
this on single line declarations.


