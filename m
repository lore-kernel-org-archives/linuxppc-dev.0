Return-Path: <yorksun@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FB2ADDE09
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 05:18:57 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2SIIqgL019689
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 11:18:52 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m2SIIpX9013630
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:18:51 -0500 (CDT)
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610 and 5121 DIU
From: York Sun <yorksun@freescale.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080328174853.GA1438@localhost.localdomain>
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<47ED2B35.4030601@freescale.com>
	<20080328174853.GA1438@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 13:18:49 -0500
Message-Id: <1206728329.10785.12.camel@laptop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, akpm@linux-foundation.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-03-28 at 20:48 +0300, Anton Vorontsov wrote:
> > >+		if (copy_from_user(&pix_fmt, (void __user *)arg,
> > >+				sizeof(pix_fmt)))
> > 
> > OK, you fixed the cast here...
> 
> Maybe better would be to define "buf" at the top of this function as
> void __user *buf = (void __user *)arg;, i.e. just once?

I think it is a good idea.

> 
> > 
> > >+			return -EFAULT;
> > >+		ad->pix_fmt = pix_fmt;
> > >+		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
> > >+		break;
> > >+	case MFB_GET_PIXFMT:
> > >+		if (!arg)
> > >+			return -EINVAL;
> 
> This if (!arg) appears to be everywhere except default: label, maybe
> this could be placed on top too?
Will do that, too.

York
