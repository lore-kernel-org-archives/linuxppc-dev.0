Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EB231A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 15:01:14 +1000 (EST)
Message-ID: <1400821255.29150.62.camel@pasglop>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Alex Williamson
 <alex.williamson@redhat.com>
Date: Fri, 23 May 2014 15:00:55 +1000
In-Reply-To: <20140523043722.GA11572@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home> <20140523043722.GA11572@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 14:37 +1000, Gavin Shan wrote:
> >There's no notification, the user needs to observe the return value an
> >poll?  Should we be enabling an eventfd to notify the user of the state
> >change?
> >
> 
> Yes. The user needs to monitor the return value. we should have one notification,
> but it's for later as we discussed :-)

 ../..

> >How does the guest learn about the error?  Does it need to?
> 
> When guest detects 0xFF's from reading PCI config space or IO, it's going
> check the device (PE) state. If the device (PE) has been put into frozen
> state, the recovery will be started.

Quick recap for Alex W (we discussed that with Alex G).

While a notification looks like a worthwhile addition in the long run, it
is not sufficient and not used today and I prefer that we keep that as something
to add later for those two main reasons:

 - First, the kernel itself isn't always notified. For example, if we implement
on top of an RTAS backend (PR KVM under pHyp) or if we are on top of PowerNV but
the error is a PHB "fence" (the entire PCI Host bridge gets fenced out in hardware
due to an internal error), then we get no notification. Only polling of the
hardware or firmware will tell us. Since we don't want to have a polling timer
in the kernel, that means that the userspace client of VFIO (or alternatively
the KVM guest) is the one that polls.

 - Second, this is how our primary user expects it: The primary (and only initial)
user of this will be qemu/KVM for PAPR guests and they don't have a notification
mechanism. Instead they query the EEH state after detecting an all 1's return from
MMIO or config space. This is how PAPR specifies it so we are just implementing the
spec here :-)

Because of these, I think we shouldn't worry too much about notification at
this stage.

Cheers,
Ben.
