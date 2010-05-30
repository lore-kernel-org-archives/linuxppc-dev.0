Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 9CC31B7D30
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 May 2010 10:54:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: mmio_nvram.c users ?
Date: Sun, 30 May 2010 02:54:22 +0200
References: <1274773439.1931.238.camel@pasglop>
	<1275104704.1931.528.camel@pasglop>
	<20100529134143.GL24511@zod.rchland.ibm.com>
In-Reply-To: <20100529134143.GL24511@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005300254.22984.arnd@arndb.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 29 May 2010, Josh Boyer wrote:
> On Sat, May 29, 2010 at 01:45:04PM +1000, Benjamin Herrenschmidt wrote:
> >On Tue, 2010-05-25 at 07:00 -0400, Josh Boyer wrote:
> >> On Tue, May 25, 2010 at 05:43:59PM +1000, Benjamin Herrenschmidt wrote:
> >> >Hi folks !
> >> >
> >> >Anybody aware of anything other than Cell using that driver ?
> >> >
> >> >I'd like to make it a platform driver instead of having something that
> >> >pokes at anything that has a "device_type" set to "nvram" (which is
> >> >gross and bogus). But I need to know what platforms to fixup...
> >> 
> >> Why bother?  You could just use either drivers/mtd/devices/{phram.c or slram.c}
> >> and get the same functionality at that point, couldn't you?
> >
> >Won't that break existing userspace ?
> 
> Probably.  Maybe we shouldn't have duplicated a driver in our platform code to
> begin with.

The reason we have the driver is so that we're able to use the kernel
internal functions for arch/powerpc/kernel/nvram_64.c on it, which
operated on the well-defined interface for partitions inside of the
nvram memory.

mtd/phram provides a completely different abstraction, which is normally
used for block- or file system based access. They also both have
the character device, but that's not really the main point.

The part that is unfortunate is the device_type matching in the driver,
which was a result of clueluess firmware and Linux developers (i.e. me)
at the time.

	Arnd
