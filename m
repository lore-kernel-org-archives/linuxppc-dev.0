Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 8DD64B6FB4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 01:28:52 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Fri, 3 Jun 2011 17:28:43 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de>
	<20110601172412.761ff799@schlenkerla.am.freescale.net>
In-Reply-To: <20110601172412.761ff799@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106031728.43707.arnd@arndb.de>
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

On Thursday 02 June 2011, Scott Wood wrote:
> I wanted to have the hypervisor take an update dtb (we already have special
> meta-properties for things like deletion as part of the hv config
> mechanism).  But others on the project wanted to keep it simple, and so
> get/set property it was. :-/
> 
> It's unlikely to change at this point without a real need.
> 
> As for a filesystem interface, it's not a good match either. 
> You can't iterate over anything to read out the full tree from the hv.

kexec iterates over /proc/device-tree to create a dts blob.

> You can't delete anything. 

rm, rmdir

> You can't create empty nodes.

mkdir

> The hv interface was meant to enable some specific management actions,
> rather than to provide general device tree access.  This driver is a thin
> wrapper around the management hcalls.

A file system would be a slightly more abstract interface to do the
same thing, I gues.

> There would still be other ioctls needed for starting/stopping the
> partition, etc.

Right, although you could model them as a file interface as well.
KVMfs is one example doing that.

	Arnd
