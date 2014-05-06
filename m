Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B96CA1413BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 01:48:08 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH v2 1/4] KVM: PPC: e500mc: Revert "add load inst fixup"
Date: Tue, 6 May 2014 15:48:02 +0000
Message-ID: <887e9723335940fdae0073000ba2d299@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-2-git-send-email-mihai.caraman@freescale.com>
 <53636436.60002@suse.de> <1399072472827.57968@freescale.com>
 <76DD19C1-EBCD-485A-B847-21304903E139@suse.de>
In-Reply-To: <76DD19C1-EBCD-485A-B847-21304903E139@suse.de>
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

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Sunday, May 04, 2014 1:14 AM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 1/4] KVM: PPC: e500mc: Revert "add load inst
> fixup"
>=20
>=20
>=20
> Am 03.05.2014 um 01:14 schrieb "mihai.caraman@freescale.com"
> <mihai.caraman@freescale.com>:
>=20
> >> From: Alexander Graf <agraf@suse.de>
> >> Sent: Friday, May 2, 2014 12:24 PM

> > This was the first idea that sprang to my mind inspired from how DO_KVM
> > is hooked on PR. I actually did a simple POC for e500mc/e5500, but this
> will
> > not work on e6500 which has shared IVORs between HW threads.
>=20
> What if we combine the ideas? On read we flip the IVOR to a separate
> handler that checks for a field in the PACA. Only if that field is set,
> we treat the fault as kvm fault, otherwise we jump into the normal
> handler.
>=20
> I suppose we'd have to also take a lock to make sure we don't race with
> the other thread when it wants to also read a guest instruction, but you
> get the idea.

This might be a solution for TLB eviction but not for execute-but-not-read
entries which requires access from host context.

>=20
> I have no idea whether this would be any faster, it's more of a
> brainstorming thing really. But regardless this patch set would be a move
> into the right direction.
>=20
> Btw, do we have any guarantees that we don't get scheduled away before we
> run kvmppc_get_last_inst()? If we run on a different core we can't read
> the inst anymore. Hrm.

It was your suggestion to move the logic from kvmppc_handle_exit() irq
disabled area to kvmppc_get_last_inst():

http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/tree/arch/powerpc/k=
vm/booke.c

Still, what is wrong if we get scheduled on another core? We will emulate
again and the guest will populate the TLB on the new core.

-Mike
