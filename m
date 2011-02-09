Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 6558CB7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:35:50 +1100 (EST)
Date: Wed, 9 Feb 2011 15:35:45 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110209233544.GA5303@ovro.caltech.edu>
References: <1297208267-27087-1-git-send-email-iws@ovro.caltech.edu>
	<1297208267-27087-2-git-send-email-iws@ovro.caltech.edu>
	<20110209083325.GA7256@core.coreip.homeip.net>
	<20110209173532.GB21766@ovro.caltech.edu>
	<20110209182740.GC23867@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110209182740.GC23867@core.coreip.homeip.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2011 at 10:27:40AM -0800, Dmitry Torokhov wrote:

[ snip stuff I've already fixed in the next version ]

> > 
> > The requirement is that the device stay open during reconfiguration.
> > This provides for that. Readers just block for as long as the device is
> > not producing data.
> 
> OK, you still need to make sure you do not touch free/used buffer while
> device is disabled. Also, you need to kick readers if you unbind the
> driver, so maybe a new flag priv->exists should be introduced and
> checked.
> 

I don't understand what you mean by "kick readers if you unbind the
driver". The kernel automatically increases the refcount on a module
when a process is using the module. This shows up in the "Used by"
column of lsmod's output.

The kernel will not let you rmmod a module with a non-zero refcount. You
cannot get into the situation where you have rmmod'ed the module and a
reader is still blocking in read()/poll().

Thanks for the review. A v6 is coming right up.

Ira
