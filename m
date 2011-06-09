Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7466EB6FEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 17:38:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org,
	Linux Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 09:38:22 +0200
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<20110608161009.7b05d305.randy.dunlap@oracle.com>
In-Reply-To: <20110608161009.7b05d305.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106090938.23027.arnd@arndb.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, konrad.wilk@oracle.com,
	greg@kroah.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org,
	linux-console@vger.kernel.org, Timur Tabi <timur@freescale.com>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 09 June 2011 01:10:09 Randy Dunlap wrote:
> On Wed, 8 Jun 2011 17:45:54 -0500 Timur Tabi wrote:
> 
> > Add the drivers/virt directory, which houses drivers that support
> > virtualization environments, and add the Freescale hypervisor management
> > driver.
> 
> It can't go in linux/virt or linux/virt/fsl instead?  why drivers/ ?
> 
> or maybe linux/virt should be drivers/virt ?

See discussion for v2 of this patch. I suggested that drivers/firmware and virt/
as options, the counterarguments were that drivers/firmware is for passive
firmware as opposed to firmware that acts as a hypervisor, and that virt/ is
for the host side of hypervisors like kvm, not for guests.

The driver in here most closely resembles the xen dom0 model, where a
priviledged guest controls other guests, but unlike xen there is a single
driver file, so there is no need to have drivers/fsl-hv directory just
for this one file. We do have a number of other hypervisors that fit in the
same category, so they can be added here later.

	Arnd
