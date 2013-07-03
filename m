Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20FDF2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 01:42:08 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Date: Wed, 3 Jul 2013 15:41:57 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3BDA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <4A7356DD-BD24-49B3-AB17-B3237F71CF88@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A38B0@039-SN2MPN1-013.039d.mgd.msft.net>
 <C4820C32-33E6-4E34-A24C-C49BD7CC8307@suse.de>
In-Reply-To: <C4820C32-33E6-4E34-A24C-C49BD7CC8307@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >>> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
> >>> returning to guest instead of each sched in. Without this improvement
> >>> an interrupt may also claim floting point corrupting guest state.
> >>
> >> Not sure I follow. Could you please describe exactly what's happening?
> >
> > This was already discussed on the list, I will forward you the thread.
>=20
> The only thing I've seen in that thread was some pathetic theoretical
> case where an interrupt handler would enable fp and clobber state
> carelessly. That's not something I'm worried about.

Neither me though I don't find it pathetic. Please refer it to Scott.

>=20
> I really don't see where this patch improves anything tbh. It certainly
> makes the code flow more awkward.

I was pointing you to this: The idea of FPU/AltiVec laziness that the kerne=
l
is struggling to achieve is to reduce the number of store/restore operation=
s.
Without this improvement we restore the unit each time we are sched it. If =
an
other process take the ownership of the unit (on SMP it's even worse but do=
n't
bother with this) the kernel store the unit state to qemu task. This can ha=
ppen
multiple times during handle_exit().

Do you see it now?=20

-Mike
