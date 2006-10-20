Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 9A999679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:45:15 +1000 (EST)
Date: Fri, 20 Oct 2006 08:44:56 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020064456.GA3946@aepfle.de>
References: <20061017132243.GA6773@lst.de> <4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061020062431.GB14390@powerlinux.fr>
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

On Fri, Oct 20, Sven Luther wrote:

> Ben, would it make sense to add two informations to /proc/cpuinfo ?
> It would be great to have a field there which will allow to check for the
> kernel flavour to run, namely if the kernel/processor/whatever is running in
> 32bit or 64bit mode. The second field would be a generalized machine field,
> or plateform or whatever, which would easily allow to differentiate between an
> apple machine, a ibm chrp, a pegasos or other genesi product, etc. Without
> necessarily having to maintain a huge amount of userlanf mappings from all
> those different machine: fields, which all have CHRP, true, but no finer
> grained informations, while we do have it in the kernel.

/proc/device-tree/{model,device_type,compatible} is enough to map
everything reliable in the installer. Dont pollute /proc/cpuinfo
further. There has already enough stuff that doesnt belong there, like
pmac-generation, 'pmac flags', 'detected as', motherboard and machine.
Oh, and bogomips...

About 32bit/64bit, maybe VmallocTotal from /proc/meminfo can be used.
incredible large numer == must be a 64bit kernel
No idea how reliable it is. There are those 36bit systems, but I bet
they dont run a distro.
