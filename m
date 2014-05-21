Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 730861A007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 10:24:03 +1000 (EST)
Message-ID: <1400631832.3986.154.camel@pasglop>
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 21 May 2014 10:23:52 +1000
In-Reply-To: <20140520123914.GA28441@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3AA7.7040106@suse.de> <537B3C68.8080102@suse.de>
 <20140520114031.GA20397@shangw> <537B4015.7030404@suse.de>
 <20140520122147.GA26483@shangw> <537B49C9.4000302@suse.de>
 <20140520123914.GA28441@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-20 at 22:39 +1000, Gavin Shan wrote:
> >>Yeah. How about this? :-)
> >>
> >>- Move eeh-vfio.c to drivers/vfio/pci/
> >>- From eeh-vfio.c, dereference arch/powerpc/kernel/eeh.c::eeh_ops, which
> >>   is arch/powerpc/plaforms/powernv/eeh-powernv.c::powernv_eeh_ops. Call
> >
> >Hrm, I think it'd be nicer to just export individual functions that
> >do thing you want to do from eeh.c.
> >
> 
> Ok. Got it. Thanks for your comments :)

The interesting thing with this approach is that VFIO per-se can work
with EEH RTAS backend too in the host.

IE, with PR KVM for example or with non-KVM uses of VFIO, it would be
possible to use a device in a user process and exploit EEH even when
running under a PAPR hypervisor.

That is, vfio-eeh uses "generic" exported EEH APIs from the EEH core
that will work on both powernv and RTAS backends.

Note to Alex: This definitely kills the notifier idea for now though,
at least as a first class citizen of the design. We can add it as an
optional optimization on top later.

Cheers,
Ben.
