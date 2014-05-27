Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21E601A05CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 06:41:31 +1000 (EST)
Message-ID: <1401223281.20915.89.camel@pasglop>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 28 May 2014 06:41:21 +1000
In-Reply-To: <1401223069.3289.653.camel@ul30vt.home>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <1401222649.20915.83.camel@pasglop>
 <1401223069.3289.653.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-27 at 14:37 -0600, Alex Williamson wrote:

> > The usual way is the driver asks for one or the other, this plumbs back
> > into the guest EEH code which itself plumbs into the PCIe error recovery
> > framework in Linux.
> 
> So magic?

Yes. The driver is expected to more or less knows what kind of reset it
wants for its device. Ideally hot reset is sufficient but some drivers
knows that the device they drive is crappy enough that it mostly ignores
hot reset and really needs a PERST for example...

Also we have other reasons to expose those interfaces outside of EEH. 

For example, some drivers might want to specifically trigger a PERST
after a microcode update. IE. There are path outside of EEH error
recovery where drivers in the guest might want to trigger a reset
to the device and they have control under some circumstances on
which kind of reset they are doing (and the guest Linux does  have
different code path to do a hot reset vs. a fundamental reset).

So we need to expose that distinction to be able to honor the guest
decision.

Cheers,
Ben.
