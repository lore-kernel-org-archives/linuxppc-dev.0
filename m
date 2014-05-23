Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by lists.ozlabs.org (Postfix) with ESMTP id 977EA1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 00:37:05 +1000 (EST)
Message-ID: <1400855815.3289.454.camel@ul30vt.home>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 23 May 2014 08:36:55 -0600
In-Reply-To: <1400821255.29150.62.camel@pasglop>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home> <20140523043722.GA11572@shangw>
 <1400821255.29150.62.camel@pasglop>
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

On Fri, 2014-05-23 at 15:00 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2014-05-23 at 14:37 +1000, Gavin Shan wrote:
> > >There's no notification, the user needs to observe the return value an
> > >poll?  Should we be enabling an eventfd to notify the user of the state
> > >change?
> > >
> > 
> > Yes. The user needs to monitor the return value. we should have one notification,
> > but it's for later as we discussed :-)
> 
>  ../..
> 
> > >How does the guest learn about the error?  Does it need to?
> > 
> > When guest detects 0xFF's from reading PCI config space or IO, it's going
> > check the device (PE) state. If the device (PE) has been put into frozen
> > state, the recovery will be started.
> 
> Quick recap for Alex W (we discussed that with Alex G).
> 
> While a notification looks like a worthwhile addition in the long run, it
> is not sufficient and not used today and I prefer that we keep that as something
> to add later for those two main reasons:
> 
>  - First, the kernel itself isn't always notified. For example, if we implement
> on top of an RTAS backend (PR KVM under pHyp) or if we are on top of PowerNV but
> the error is a PHB "fence" (the entire PCI Host bridge gets fenced out in hardware
> due to an internal error), then we get no notification. Only polling of the
> hardware or firmware will tell us. Since we don't want to have a polling timer
> in the kernel, that means that the userspace client of VFIO (or alternatively
> the KVM guest) is the one that polls.
> 
>  - Second, this is how our primary user expects it: The primary (and only initial)
> user of this will be qemu/KVM for PAPR guests and they don't have a notification
> mechanism. Instead they query the EEH state after detecting an all 1's return from
> MMIO or config space. This is how PAPR specifies it so we are just implementing the
> spec here :-)
> 
> Because of these, I think we shouldn't worry too much about notification at
> this stage.

Ok, I was asking more about an error log that indicates what error
occurred to freeze the hardware so that the user can make a more
educated guess whether recovery is an option.  Given that you have cases
where there may be no notification and your guest/user already handles
this, the plan to start with polling makes sense.  Thanks,

Alex
