Return-Path: <jbarnes@virtuousgeek.org>
Received: from outboundproxy6.bluehost.com (outbound-mail-313.bluehost.com
	[67.222.54.6]) by ozlabs.org (Postfix) with SMTP id 06736B6F08
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 05:06:31 +1100 (EST)
Date: Tue, 23 Feb 2010 10:06:26 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v5 0/5] PCI: try "pci=use_crs" again
Message-ID: <20100223100626.693b50b6@jbarnes-piketon>
In-Reply-To: <20100223172355.17242.55927.stgit@bob.kio>
References: <20100223172355.17242.55927.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>,
	linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Peter Haight <peterh@sapros.com>,
	Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org,
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

On Tue, 23 Feb 2010 10:24:15 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Historically, Linux has assumed a single PCI host bridge, with that
> bridge claiming all the address space left after RAM and legacy
> devices are taken out.
> 
> If the system contains multiple host bridges, we can no longer
> operate under that assumption.  We have to know what parts of the
> address space are claimed by each bridge so that when we assign
> resources to a PCI device, we take them from a range claimed by the
> upstream host bridge.
> 
> On x86 and ia64, we use ACPI to enumerate all the PCI host bridges in
> the system, and part of the host bridge description is the
> "_CRS" (current resource settings" property, which lists the address
> space used by the bridge.  On x86, we currently ignore most of the
> _CRS information.  This patch series changes this, so we will use
> _CRS to learn about the host bridge windows.
> 
> Since most x86 machines with multiple host bridges are relatively
> new, this series only turns this on for machines with BIOS dates of
> 2008 or newer.
> 
> Changes from v4 to v5:
>     - Add EXPORT_SYMBOL_GPL(pci_bus_resource_n) for module builds.

Thanks, it built this time.  Pushed to my linux-next branch.

-- 
Jesse Barnes, Intel Open Source Technology Center
