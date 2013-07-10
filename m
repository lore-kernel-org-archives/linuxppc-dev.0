Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0963C2C02CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 04:44:05 +1000 (EST)
Date: Wed, 10 Jul 2013 13:42:42 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <2750D29D-8CE6-40D3-922D-864F447FEFD8@suse.de> (from
 agraf@suse.de on Wed Jul 10 05:15:09 2013)
Message-ID: <1373481762.8183.220@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 05:15:09 AM, Alexander Graf wrote:
>=20
> On 10.07.2013, at 02:06, Scott Wood wrote:
>=20
> > On 07/09/2013 04:44:24 PM, Alexander Graf wrote:
> >> On 09.07.2013, at 20:46, Scott Wood wrote:
> >> > I suspect that tlbsx is faster, or at worst similar.  And unlike =20
> comparing tlbsx to lwepx (not counting a fix for the threading =20
> problem), we don't already have code to search the guest TLB, so =20
> testing would be more work.
> >> We have code to walk the guest TLB for TLB misses. This really is =20
> just the TLB miss search without host TLB injection.
> >> So let's say we're using the shadow TLB. The guest always has its =20
> say 64 TLB entries that it can count on - we never evict anything by =20
> accident, because we store all of the 64 entries in our guest TLB =20
> cache. When the guest faults at an address, the first thing we do is =20
> we check the cache whether we have that page already mapped.
> >> However, with this method we now have 2 enumeration methods for =20
> guest TLB searches. We have the tlbsx one which searches the host TLB =20
> and we have our guest TLB cache. The guest TLB cache might still =20
> contain an entry for an address that we already invalidated on the =20
> host. Would that impose a problem?
> >> I guess not because we're swizzling the exit code around to =20
> instead be an instruction miss which means we restore the TLB entry =20
> into our host's TLB so that when we resume, we land here and the =20
> tlbsx hits. But it feels backwards.
> >
> > Any better way?  Searching the guest TLB won't work for the LRAT =20
> case, so we'd need to have this logic around anyway.  We shouldn't =20
> add a second codepath unless it's a clear performance gain -- and =20
> again, I suspect it would be the opposite, especially if the entry is =20
> not in TLB0 or in one of the first few entries searched in TLB1.  The =20
> tlbsx miss case is not what we should optimize for.
>=20
> Hrm.
>=20
> So let's redesign this thing theoretically. We would have an exit =20
> that requires an instruction fetch. We would override =20
> kvmppc_get_last_inst() to always do kvmppc_ld_inst(). That one can =20
> fail because it can't find the TLB entry in the host TLB. When it =20
> fails, we have to abort the emulation and resume the guest at the =20
> same IP.
>=20
> Now the guest gets the TLB miss, we populate, go back into the guest. =20
> The guest hits the emulation failure again. We go back to =20
> kvmppc_ld_inst() which succeeds this time and we can emulate the =20
> instruction.

That's pretty much what this patch does, except that it goes =20
immediately to the TLB miss code rather than having the extra =20
round-trip back to the guest.  Is there any benefit from adding that =20
extra round-trip?  Rewriting the exit type instead doesn't seem that =20
bad...

> I think this works. Just make sure that the gateway to the =20
> instruction fetch is kvmppc_get_last_inst() and make that failable. =20
> Then the difference between looking for the TLB entry in the host's =20
> TLB or in the guest's TLB cache is hopefully negligible.

I don't follow here.  What does this have to do with looking in the =20
guest TLB?

-Scott=
