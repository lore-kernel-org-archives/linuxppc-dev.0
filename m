Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B339D1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 10:45:07 +1000 (EST)
Message-ID: <1401324295.8262.42.camel@pasglop>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 29 May 2014 10:44:55 +1000
In-Reply-To: <20140529000543.GA9645@shangw>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>
 <1401294731.2412.42.camel@ul30vt.home> <20140529000543.GA9645@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-29 at 10:05 +1000, Gavin Shan wrote:
> The log stuff is TBD and I'll figure it out later.
> 
> About to what are the errors, there are a lot. Most of them are related
> to hardware level, for example unstable PCI link. Usually, those error
> bits defined in AER fatal error state register contribute to EEH errors.
> It could be software related, e.g. violating IOMMU protection (read/write
> permission etc), or even one PCI device isn't capable of DMAing. Hopefully,
> it's the explaination you're looking for? :-)

Note to Alex('s) ...

The log we get from FW at the moment in the host is:

  - In the case of pHyp / RTAS host, opaque. Basically it's a blob that we store
and that can be sent to IBM service people :-) Not terribly practical.

  - On PowerNV, it's a IODA specific data structure (basically a dump of a 
bunch of register state and tables). IODA is our IO architecture (sadly the
document itself isn't public at this point) and we have two versions, IODA1
and IODA2. You can consider the structure as chipset specific basically.

What I want to do in the long run is:

  - In the case of pHyp/RTAS host, there's not much we can do, so basically
forward that log as-is.

  - In the case of PowerNV, forward the log *and* add a well-defined blob to
it that does some basic interpretation of it. In fact I want to do the latter
more generally in the host kernel for host kernel errors as well, but we
can forward it to the guest via VFIO too. What I mean by interpretation is
something along the lines of an error type "DMA IOMMU fault, MMIO error,
Link loss, PCIe UE, ..." among a list of well known error types that
represent the most common ones, with a little bit of added info when
available (for most DMA errors we can provide the DMA address that faulted
for example).

So Gavin and I need to work a bit on that, both in the context of the host
kernel to improve the reporting there, and in the context of what we pass to
user space.

However, no driver today cares about that information. The PCIe error recovery
system doesn't carry it and it has no impact on the EEH recovery procedures,
so EEH in that sense is useful without that reporting. It's useful for the
programmer (or user/admin) to identify what went wrong but it's not used by
the automated recovery process.

One last thing to look at is in the case of a VFIO device, we might want to
silence the host kernel printf's once we support guest EEH since otherwise
the guest has a path to flood the host kernel log by triggering a lot of
EEH errors purposefully.

Cheers,
Ben.
