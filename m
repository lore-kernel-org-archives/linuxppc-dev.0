Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C58E67B59
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 17:12:20 +1000 (EST)
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061020064456.GA3946@aepfle.de>
References: <20061017132243.GA6773@lst.de> <4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 17:11:54 +1000
Message-Id: <1161328314.10524.168.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Sven Luther <sl@bplan-gmbh.de>, tilmann@bitterberg.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-20 at 08:44 +0200, Olaf Hering wrote:
> On Fri, Oct 20, Sven Luther wrote:
> 
> > Ben, would it make sense to add two informations to /proc/cpuinfo ?
> > It would be great to have a field there which will allow to check for the
> > kernel flavour to run, namely if the kernel/processor/whatever is running in
> > 32bit or 64bit mode. The second field would be a generalized machine field,
> > or plateform or whatever, which would easily allow to differentiate between an
> > apple machine, a ibm chrp, a pegasos or other genesi product, etc. Without
> > necessarily having to maintain a huge amount of userlanf mappings from all
> > those different machine: fields, which all have CHRP, true, but no finer
> > grained informations, while we do have it in the kernel.
> 
> /proc/device-tree/{model,device_type,compatible} is enough to map
> everything reliable in the installer. Dont pollute /proc/cpuinfo
> further. There has already enough stuff that doesnt belong there, like
> pmac-generation, 'pmac flags', 'detected as', motherboard and machine.
> Oh, and bogomips...

Some powermac detection bits for older models are not actually available
via the device-tree :)

> About 32bit/64bit, maybe VmallocTotal from /proc/meminfo can be used.
> incredible large numer == must be a 64bit kernel
> No idea how reliable it is. There are those 36bit systems, but I bet
> they dont run a distro.

But why are you absolutely trying to defeat uname ?

If somebody is trying to fake it, then use the faked version !

Ben.
