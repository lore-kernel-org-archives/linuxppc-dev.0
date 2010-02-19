Return-Path: <garyhade@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D5D2B7CF1
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 11:58:51 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1J0qQV9023171
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 17:52:26 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1J0wgSd125146
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 17:58:42 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1J10xfl019213
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 18:01:00 -0700
Date: Thu, 18 Feb 2010 16:58:36 -0800
From: Gary Hade <garyhade@us.ibm.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v4 0/5] PCI: try "pci=use_crs" again
Message-ID: <20100219005836.GA26564@us.ibm.com>
References: <20100217201654.4013.70201.stgit@bob.kio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100217201654.4013.70201.stgit@bob.kio>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>,
	linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Peter Haight <peterh@sapros.com>,
	Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2010 at 01:19:47PM -0700, Bjorn Helgaas wrote:
> Historically, Linux has assumed a single PCI host bridge, with that bridge
> claiming all the address space left after RAM and legacy devices are taken out.
> 
> If the system contains multiple host bridges, we can no longer operate under
> that assumption.  We have to know what parts of the address space are claimed
> by each bridge so that when we assign resources to a PCI device, we take them
> from a range claimed by the upstream host bridge.
> 
> On x86 and ia64, we use ACPI to enumerate all the PCI host bridges in the
> system, and part of the host bridge description is the "_CRS" (current resource
> settings" property, which lists the address space used by the bridge.  On x86,
> we currently ignore most of the _CRS information.  This patch series changes
> this, so we will use _CRS to learn about the host bridge windows.
> 
> Since most x86 machines with multiple host bridges are relatively new, this
> series only turns this on for machines with BIOS dates of 2008 or newer.

I just tried your changes on an IBM x3850 with a 12/01/2008 BIOS
date.  After booting without pci=use_crs I observed the expected
  PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
message.  I then loaded 'acpiphp' and was able to successfully 
hot-remove and hot-add PCI-X and PCIe cards.  Without pci=use_crs
a hot-add operation would have previously caused a machine check.

   Tested-by: Gary Hade <garyhade@us.ibm.com>

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc
