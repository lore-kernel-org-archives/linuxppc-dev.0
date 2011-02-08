Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D19C8B716D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 12:49:02 +1100 (EST)
Date: Mon, 7 Feb 2011 17:30:25 -0800
From: Greg KH <greg@kroah.com>
To: Alexander Gordeev <lasaine@lvk.cs.msu.su>
Subject: Re: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	Interface Layer
Message-ID: <20110208013025.GA3151@kroah.com>
References: <1295477852-14735-1-git-send-email-tmarri@apm.com>
	<20110126191734.5dff9641@desktopvm.lvknet>
	<4d3a1de3bf1ff8a4f69bf2d90da0a1cf@mail.gmail.com>
	<20110208031925.60bd1118@apollo.gnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110208031925.60bd1118@apollo.gnet>
Cc: Tirumala Marri <tmarri@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 08, 2011 at 03:19:25AM +0300, Alexander Gordeev wrote:
> В Mon, 7 Feb 2011 10:53:25 -0800
> Tirumala Marri <tmarri@apm.com> пишет:
> 
> > dwc_read_reg32 is used nowhere throughout the code. One of dwc_read32 and
> > dwc_read_reg32 should be removed IMO. There was once only dwc_read_reg32. In
> > version 5 of your patchset I believe. Why did you add another function?
> > AFAIK it is not correct to store pointers in u32 because they need 8 bytes
> > on 64-bit archs. So it was ok with the old dwc_read_reg32.
> > [Marri] If u32 is 8bytes isn't pointer type would be 8bytes as well.
> 
> Sorry, I don't understand that. I think u32 is always 32bit = 4byte on
> all archs. Right?

Yes.

Use an unsigned long if you want to hold a pointer correctly on all
arches.

thanks,

greg k-h
