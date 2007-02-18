Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46AD0DDE25
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 11:49:54 +1100 (EST)
Subject: Re: [PATCH 2.6.21-rc1] powerpc: Make of_device_uevent()
	compatible	with ibmebus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joachim Fenkes <FENKES@de.ibm.com>
In-Reply-To: <OF8D0E4DD6.8DF18C46-ON85257286.00002C8B-85257286.0001FC97@de.ibm.com>
References: <OF8D0E4DD6.8DF18C46-ON85257286.00002C8B-85257286.0001FC97@de.ibm.com>
Content-Type: text/plain
Date: Sun, 18 Feb 2007 11:37:25 +1100
Message-Id: <1171759045.5644.148.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-02-17 at 19:21 -0500, Joachim Fenkes wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 17.02.2007 
> 16:56:39:
> 
> > On Sat, 2007-02-17 at 17:28 +0100, Hoang-Nam Nguyen wrote:
> > > ibmebus has a fake root device that's not associated with an ofdt 
> node.
> > > Filter out any such devices in of_device_uevent().
> > 
> > Doh ! You are creating an of_device with no attached device-node ? That
> > is totally evil ! Why do you need that ?
> 
> The driver creates a fake "ibmebus" device so all ibmebus based devices 
> have
> a common parent device -- the vio bus does the same.
> 
> What do you think about linking this device to the device tree "/" node? 
> All
> ibmebus-based devices are linked to dt nodes residing directly beneath 
> "/",
> so the mapping would fit.

No. If you do that, it shouldn't be an of_device based device.

If you want then to be below a common parent, then create that parent of
a basic struct device type, that sort of thing. You should never
instanciate an of_device that has a NULL device node.

vio is different since it's not a "subclass" of of_device though I tend
to also disagree with the way it does things.

It's a generic problem with sysfs, I agree it somewhat sucks.

Ben.
