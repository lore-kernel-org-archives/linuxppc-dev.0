Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 353F8B70C0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2011 15:39:13 +1000 (EST)
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-8-git-send-email-agraf@suse.de>
	<20110812033529.GS30552@yookeroo.fritz.box>
In-Reply-To: <20110812033529.GS30552@yookeroo.fritz.box>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <D03414E2-97E0-4439-BD88-E3FFCCF1E5FB@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 07/10] KVM: PPC: Add PAPR hypercall code for PR mode
Date: Fri, 12 Aug 2011 07:38:54 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 12.08.2011 um 05:35 schrieb David Gibson <david@gibson.dropbear.id.au>:

> On Tue, Aug 09, 2011 at 06:31:45PM +0200, Alexander Graf wrote:
>> When running a PAPR guest, we need to handle a few hypercalls in kernel s=
pace,
>> most prominently the page table invalidation (to sync the shadows).
>>=20
>> So this patch adds handling for a few PAPR hypercalls to PR mode KVM. I t=
ried
>> to share the code with HV mode, but it ended up being a lot easier this w=
ay
>> around, as the two differ too much in those details.
>=20
> Are these strictly necessary, or just an optimization?  Because you're
> using the space allocated by qemu for the guest hash table, it seems
> to be you could just let h_enter fall through to qemu which will put
> the right thing into the guest hash table which you can then walk in
> the kernel translation code.

Every time a PTE can be invalidated, we need to do so in kvm to keep the SPT=
 in sync. IIRC h_enter can evict/overwrite a previous entry, so we need to h=
andle it in kvm as well :). Removal definitely needs to happin in-kernel.


Alex

>=20
