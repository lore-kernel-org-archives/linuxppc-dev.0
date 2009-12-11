Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 69B7DB6F15
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Dec 2009 08:17:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Deprecating of_platform, the path from here...
Date: Fri, 11 Dec 2009 21:17:43 +0000
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<200912111625.29674.arnd@arndb.de>
	<fa686aa40912110844l5990d6fbh7c9c0928513b055d@mail.gmail.com>
In-Reply-To: <fa686aa40912110844l5990d6fbh7c9c0928513b055d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912112117.44022.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 December 2009 16:44:32 Grant Likely wrote:

> platform users far outnumber of_platform users.  I actually don't care
> which becomes the 'preferred' bus, just as long as one is chosen.  It
> is easy to migrate features between them.  When I look at the work
> required though, I think it is far more feasible to fold of_platform
> features into platform bus than it is to ask current platform users to
> migrate over to of_platform.

Yes, I think you have convinced me. For me the key argument is that
we can extend platform_bus to do everything that of_platform_bus
does today. 

If we can automatically turn "reg" and "interrupt" properties into
resources for the platform_devices created from a device tree,
and add interfaces to platform_device to operate directly on properties
of the underlying device, I'm happy.

DMA address translation is something that will require some care
to get right with platform_device, and it's important that we come
up with a nice syntax to define properties for regular
platform_devices that do not come from a device tree.

> Now, if consensus can be reached among architecture maintainers to
> make of_platform the preferred approach, and to deprecate platform
> bus, then I'm all for it and I'll work towards it  However, I
> personally don't think it will fly and so I'm not spending any effort
> on that direction.

Right.

	Arnd <><
