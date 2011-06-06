Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id 08FF1B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 01:53:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Mon, 6 Jun 2011 17:53:09 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106031728.43707.arnd@arndb.de>
	<20110603112213.4f4d1b4e@schlenkerla.am.freescale.net>
In-Reply-To: <20110603112213.4f4d1b4e@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106061753.10154.arnd@arndb.de>
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

On Friday 03 June 2011, Scott Wood wrote:
> On Fri, 3 Jun 2011 17:28:43 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Thursday 02 June 2011, Scott Wood wrote:
> > > I wanted to have the hypervisor take an update dtb (we already have special
> > > meta-properties for things like deletion as part of the hv config
> > > mechanism).  But others on the project wanted to keep it simple, and so
> > > get/set property it was. :-/
> > > 
> > > It's unlikely to change at this point without a real need.
> > > 
> > > As for a filesystem interface, it's not a good match either. 
> > > You can't iterate over anything to read out the full tree from the hv.
> > 
> > kexec iterates over /proc/device-tree to create a dts blob.
> 
> That's irrelevant, because we're not talking about that device tree.  We're
> talking about the device tree of another hypervisor guest.

I understand that it's a different device tree. That doesn't mean we
can't use the same tools.

> > > You can't delete anything. 
> > 
> > rm, rmdir
> > 
> > > You can't create empty nodes.
> > 
> > mkdir
> 
> I know how to operate a filesystem.  You can't do these operations *on
> another guest's device tree through the hv interface*.

Why not? From a device driver perspective, it's not much of a difference
whether you export a device (or hypervisor, firmware, ...) setting
as an ioctl or an inode operation.

> > > There would still be other ioctls needed for starting/stopping the
> > > partition, etc.
> > 
> > Right, although you could model them as a file interface as well.
> > KVMfs is one example doing that.
> 
> And what would be the benefit of this major restructuring and added
> complexity?

I think it would be a slightly better abstraction, and the complexity
is not as big as you make it sound. I'm mainly countering your statement
that it would be a bad interface or that would not possible to do.

I'm not that opposed to having an ioctl interface for your hypervisor
interface, but I am opposed to making design choices based on
a bad representations of facts or not having considered the options
that other people suggest.

	Arnd
