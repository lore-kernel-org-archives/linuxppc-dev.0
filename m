Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57DAAB6F67
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 00:11:49 +1000 (EST)
Date: Thu, 7 Jul 2011 07:11:25 -0700
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
Message-ID: <20110707141125.GE27648@kroah.com>
References: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
	<1308828839-27349-1-git-send-email-galak@kernel.crashing.org>
	<20110701220900.GA28971@kroah.com>
	<597354F4-D1D4-4BC0-9251-FDDC31B1E2A1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <597354F4-D1D4-4BC0-9251-FDDC31B1E2A1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 07, 2011 at 08:55:44AM -0500, Kumar Gala wrote:
> 
> On Jul 1, 2011, at 5:09 PM, Greg KH wrote:
> 
> > On Thu, Jun 23, 2011 at 06:33:57AM -0500, Kumar Gala wrote:
> >> On some architectures we need to setup pdev_archdata before we add the
> >> device.  Waiting til a bus_notifier is too late since we might need the
> >> pdev_archdata in the bus notifier.  One example is setting up of dma_mask
> >> pointers such that it can be used in a bus_notifier.
> >> 
> >> We add noop version of arch_setup_pdev_archdata() in
> >> <asm-generic/platform_device.h> and allow the arch code to override with
> >> access the full definitions of struct device, struct platform_device, and
> >> struct pdev_archdata.
> > 
> > Isn't there some way to use "weak" symbols to keep us from having to
> > create this .h file in every single arch and then if the arch wants to
> > define it, it does so?
> > 
> > That should make this patch simpler, right?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Changing to weak should be doable if we are ok with the additional
> function call always happening.

Given that this is not a fast path, and the function call for the
"normal" case would do nothing, it should be fine, right?

greg k-h
