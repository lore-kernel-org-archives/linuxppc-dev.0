Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90754B6FB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 02:22:22 +1000 (EST)
Date: Fri, 3 Jun 2011 11:22:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Message-ID: <20110603112213.4f4d1b4e@schlenkerla.am.freescale.net>
In-Reply-To: <201106031728.43707.arnd@arndb.de>
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de>
	<20110601172412.761ff799@schlenkerla.am.freescale.net>
	<201106031728.43707.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: greg@kroah.com, kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, linux-console@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 3 Jun 2011 17:28:43 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 02 June 2011, Scott Wood wrote:
> > I wanted to have the hypervisor take an update dtb (we already have special
> > meta-properties for things like deletion as part of the hv config
> > mechanism).  But others on the project wanted to keep it simple, and so
> > get/set property it was. :-/
> > 
> > It's unlikely to change at this point without a real need.
> > 
> > As for a filesystem interface, it's not a good match either. 
> > You can't iterate over anything to read out the full tree from the hv.
> 
> kexec iterates over /proc/device-tree to create a dts blob.

That's irrelevant, because we're not talking about that device tree.  We're
talking about the device tree of another hypervisor guest.

> > You can't delete anything. 
> 
> rm, rmdir
> 
> > You can't create empty nodes.
> 
> mkdir

I know how to operate a filesystem.  You can't do these operations *on
another guest's device tree through the hv interface*.

> > There would still be other ioctls needed for starting/stopping the
> > partition, etc.
> 
> Right, although you could model them as a file interface as well.
> KVMfs is one example doing that.

And what would be the benefit of this major restructuring and added
complexity?

-Scott
