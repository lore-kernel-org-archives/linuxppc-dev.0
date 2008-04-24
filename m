Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1280ADDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 13:10:42 +1000 (EST)
Date: Thu, 24 Apr 2008 12:07:22 +0900 (JST)
Message-Id: <20080424.120722.-1300531374.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
In-Reply-To: <1208396890.6958.323.camel@pasglop>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

I'm sorry to have kept you waiting for my response.

I just finished reviewing your patch.  Your patch works well on
Celleb, and I found I also should do the same thing for Celleb as you
pointed.  I will send a new patch which includes your fix.


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> So I found a few issues with your patch. Below is a "Fixup" patch that
> fixes the QS20 cell blades for me, but I would like you to apply that
> directly to your series and post a new version of it so that there
> is no breakage of QS20 during bisection.
> 
> Note that I believe Celleb may have some problems too. See below.
> 
> So the base issue was that on QS20, there was no struct device, thus the
> dma mapping would crash.
> 
> I fixed that by changing the Cell blades code to create
> of_platform_device's for the PCI busses like it does on QS21 or later,
> and removed the initial call to the rtas PCI bus creation.
> 
> Now, that doesn't fix it all....
> 
> One thing I noticed in celleb_pci is that you initialize the workarounds
> for the bus after it's been created at device_initcall time. This is not
> good because at that time, drivers can already have been loaded &
> initialized, quirks have been run, etc... so it's actually too late to
> initialize the workarounds. They need to be initialized earlier.

You are right.  It seems that celleb_pci happened to be initialized
earlier than PCI device drivers, so troubles (except that for quirks)
have been avoided.  I will fix it by the new patch.


> I've tried something around the lines of initializing them from within
> the PHB setup callback, which happens before the PCI probe. You should
> be able to use the same approach for Celleb I suppose. Seems to work for
> me so far...

I will do the same way. Thanks for your advice.


> In addition, your patch would have called io_workaround_init() on QS21
> which doesn't need them (no Spider), thus slowing down access on
> machines that don't need the workarounds.
> 
> My new code should hopefully only call this when needed. I made the call
> safe to call multiple time to avoid having to test in the caller.
> 
> Another thing I noticed is that you removed the workaround to disable
> PCI prefetch. Is there a reason for that ? As far as I understand,
> prefetch is broken and can cause errors ranging from data corruption to
> iommu exceptions if the iommu is enabled. Maybe you want to make it
> depend on the revision of Spider in case your SCC has that fixed ?

Sorry, this was my mistake.  I will put it back in a new patch.


> My patch doesn't change that but we might need to...
> 
> So here is the patch. Please integrate my changes in your patch serie
> and re-post it (minus the two patches that Paulus already accepted).

Thanks, I'll do so.  Can I add your 'Signed-off'?

Best regards,
Kou Ishizaki
