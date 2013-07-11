Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DE2D2C02EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 10:15:38 +1000 (EST)
Date: Wed, 10 Jul 2013 19:15:28 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <1C54E9AA-5CE3-4540-A37D-5C2FD535EA89@suse.de> (from
 agraf@suse.de on Wed Jul 10 17:50:01 2013)
Message-ID: <1373501728.8183.239@snotra>
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

On 07/10/2013 05:50:01 PM, Alexander Graf wrote:
>=20
> On 10.07.2013, at 20:42, Scott Wood wrote:
>=20
> > On 07/10/2013 05:15:09 AM, Alexander Graf wrote:
> >> On 10.07.2013, at 02:06, Scott Wood wrote:
> >> > On 07/09/2013 04:44:24 PM, Alexander Graf wrote:
> >> >> On 09.07.2013, at 20:46, Scott Wood wrote:
> >> >> > I suspect that tlbsx is faster, or at worst similar.  And =20
> unlike comparing tlbsx to lwepx (not counting a fix for the threading =20
> problem), we don't already have code to search the guest TLB, so =20
> testing would be more work.
> >> >> We have code to walk the guest TLB for TLB misses. This really =20
> is just the TLB miss search without host TLB injection.
> >> >> So let's say we're using the shadow TLB. The guest always has =20
> its say 64 TLB entries that it can count on - we never evict anything =20
> by accident, because we store all of the 64 entries in our guest TLB =20
> cache. When the guest faults at an address, the first thing we do is =20
> we check the cache whether we have that page already mapped.
> >> >> However, with this method we now have 2 enumeration methods for =20
> guest TLB searches. We have the tlbsx one which searches the host TLB =20
> and we have our guest TLB cache. The guest TLB cache might still =20
> contain an entry for an address that we already invalidated on the =20
> host. Would that impose a problem?
> >> >> I guess not because we're swizzling the exit code around to =20
> instead be an instruction miss which means we restore the TLB entry =20
> into our host's TLB so that when we resume, we land here and the =20
> tlbsx hits. But it feels backwards.
> >> >
> >> > Any better way?  Searching the guest TLB won't work for the LRAT =20
> case, so we'd need to have this logic around anyway.  We shouldn't =20
> add a second codepath unless it's a clear performance gain -- and =20
> again, I suspect it would be the opposite, especially if the entry is =20
> not in TLB0 or in one of the first few entries searched in TLB1.  The =20
> tlbsx miss case is not what we should optimize for.
> >> Hrm.
> >> So let's redesign this thing theoretically. We would have an exit =20
> that requires an instruction fetch. We would override =20
> kvmppc_get_last_inst() to always do kvmppc_ld_inst(). That one can =20
> fail because it can't find the TLB entry in the host TLB. When it =20
> fails, we have to abort the emulation and resume the guest at the =20
> same IP.
> >> Now the guest gets the TLB miss, we populate, go back into the =20
> guest. The guest hits the emulation failure again. We go back to =20
> kvmppc_ld_inst() which succeeds this time and we can emulate the =20
> instruction.
> >
> > That's pretty much what this patch does, except that it goes =20
> immediately to the TLB miss code rather than having the extra =20
> round-trip back to the guest.  Is there any benefit from adding that =20
> extra round-trip?  Rewriting the exit type instead doesn't seem that =20
> bad...
>=20
> It's pretty bad. I want to have code that is easy to follow - and I =20
> don't care whether the very rare case of a TLB entry getting evicted =20
> by a random other thread right when we execute the exit path is =20
> slower by a few percent if we get cleaner code for that.

I guess I just don't see how this is so much harder to follow than =20
returning to guest.  I find it harder to follow the flow when there are =20
more round trips to the guest involved.  "Treat this as an ITLB miss" =20
is simpler than, "Let this fail, and make sure we retry the trapping =20
instruction on failure.  Then, an ITLB miss will happen."

Also note that making kvmppc_get_last_inst() able to fail means =20
updating several existing callsites, both for the change in function =20
signature and to actually handle failures.

I don't care that deeply either way, it just doesn't seem obviously =20
better.

> >> I think this works. Just make sure that the gateway to the =20
> instruction fetch is kvmppc_get_last_inst() and make that failable. =20
> Then the difference between looking for the TLB entry in the host's =20
> TLB or in the guest's TLB cache is hopefully negligible.
> >
> > I don't follow here.  What does this have to do with looking in the =20
> guest TLB?
>=20
> I want to hide the fact that we're cheating as much as possible, =20
> that's it.

How are we cheating, and what specifically are you proposing to do to =20
hide that?  How is the guest TLB involved at all in the change you're =20
asking for?

-Scott=
