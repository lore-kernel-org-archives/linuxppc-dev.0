Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id E3952B7056
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 06:20:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 22:20:22 +0200
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<201106090929.23671.arnd@arndb.de> <4DF11715.5030001@freescale.com>
In-Reply-To: <4DF11715.5030001@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106092220.22246.arnd@arndb.de>
Cc: konrad.wilk@oracle.com, kumar.gala@freescale.com, cmetcalf@tilera.com,
	akpm@kernel.org, linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 09 June 2011 20:55:17 Timur Tabi wrote:
> Arnd Bergmann wrote:
> > Then get rid of all the code that takes apart the ioctl command numbers
> > again and just do a switch/case based on the command.
> 
> I still need to keep that code to maintain binary compatibility with existing
> applications that pass the union as a parameter.
> 
> I'll fix that after we've updated the applications.  But we have a
> chicken-or-the-egg problem where we need the same application to work with the
> new and old ioctl interface for a period of time.

The lesson to learn here is obviously not to ship binaries of applications
to customers before the driver has been merged in a mainline kernel.

The best way out that I can see is to make the driver carry the proper
interface in the upstream version, but to have a private patch to support
both interface versions in the kernel you ship on machines that require
backwards compatibility. Once you have phased out the user application,
you can then drop that patch and use the upstream version of the
interfaces.

	Arnd
