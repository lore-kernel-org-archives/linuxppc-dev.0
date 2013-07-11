Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 37F542C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 10:17:37 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373501728.8183.239@snotra>
Date: Thu, 11 Jul 2013 02:17:31 +0200
Message-Id: <FCC64AB7-1168-4365-8A5D-AEFE7E0E1D43@suse.de>
References: <1373501728.8183.239@snotra>
To: Scott Wood <scottwood@freescale.com>
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


On 11.07.2013, at 02:15, Scott Wood wrote:

> On 07/10/2013 05:50:01 PM, Alexander Graf wrote:
>> On 10.07.2013, at 20:42, Scott Wood wrote:
>> > On 07/10/2013 05:15:09 AM, Alexander Graf wrote:
>> >> On 10.07.2013, at 02:06, Scott Wood wrote:
>> >> > On 07/09/2013 04:44:24 PM, Alexander Graf wrote:
>> >> >> On 09.07.2013, at 20:46, Scott Wood wrote:
>> >> >> > I suspect that tlbsx is faster, or at worst similar.  And =
unlike comparing tlbsx to lwepx (not counting a fix for the threading =
problem), we don't already have code to search the guest TLB, so testing =
would be more work.
>> >> >> We have code to walk the guest TLB for TLB misses. This really =
is just the TLB miss search without host TLB injection.
>> >> >> So let's say we're using the shadow TLB. The guest always has =
its say 64 TLB entries that it can count on - we never evict anything by =
accident, because we store all of the 64 entries in our guest TLB cache. =
When the guest faults at an address, the first thing we do is we check =
the cache whether we have that page already mapped.
>> >> >> However, with this method we now have 2 enumeration methods for =
guest TLB searches. We have the tlbsx one which searches the host TLB =
and we have our guest TLB cache. The guest TLB cache might still contain =
an entry for an address that we already invalidated on the host. Would =
that impose a problem?
>> >> >> I guess not because we're swizzling the exit code around to =
instead be an instruction miss which means we restore the TLB entry into =
our host's TLB so that when we resume, we land here and the tlbsx hits. =
But it feels backwards.
>> >> >
>> >> > Any better way?  Searching the guest TLB won't work for the LRAT =
case, so we'd need to have this logic around anyway.  We shouldn't add a =
second codepath unless it's a clear performance gain -- and again, I =
suspect it would be the opposite, especially if the entry is not in TLB0 =
or in one of the first few entries searched in TLB1.  The tlbsx miss =
case is not what we should optimize for.
>> >> Hrm.
>> >> So let's redesign this thing theoretically. We would have an exit =
that requires an instruction fetch. We would override =
kvmppc_get_last_inst() to always do kvmppc_ld_inst(). That one can fail =
because it can't find the TLB entry in the host TLB. When it fails, we =
have to abort the emulation and resume the guest at the same IP.
>> >> Now the guest gets the TLB miss, we populate, go back into the =
guest. The guest hits the emulation failure again. We go back to =
kvmppc_ld_inst() which succeeds this time and we can emulate the =
instruction.
>> >
>> > That's pretty much what this patch does, except that it goes =
immediately to the TLB miss code rather than having the extra round-trip =
back to the guest.  Is there any benefit from adding that extra =
round-trip?  Rewriting the exit type instead doesn't seem that bad...
>> It's pretty bad. I want to have code that is easy to follow - and I =
don't care whether the very rare case of a TLB entry getting evicted by =
a random other thread right when we execute the exit path is slower by a =
few percent if we get cleaner code for that.
>=20
> I guess I just don't see how this is so much harder to follow than =
returning to guest.  I find it harder to follow the flow when there are =
more round trips to the guest involved.  "Treat this as an ITLB miss" is =
simpler than, "Let this fail, and make sure we retry the trapping =
instruction on failure.  Then, an ITLB miss will happen."
>=20
> Also note that making kvmppc_get_last_inst() able to fail means =
updating several existing callsites, both for the change in function =
signature and to actually handle failures.
>=20
> I don't care that deeply either way, it just doesn't seem obviously =
better.
>=20
>> >> I think this works. Just make sure that the gateway to the =
instruction fetch is kvmppc_get_last_inst() and make that failable. Then =
the difference between looking for the TLB entry in the host's TLB or in =
the guest's TLB cache is hopefully negligible.
>> >
>> > I don't follow here.  What does this have to do with looking in the =
guest TLB?
>> I want to hide the fact that we're cheating as much as possible, =
that's it.
>=20
> How are we cheating, and what specifically are you proposing to do to =
hide that?  How is the guest TLB involved at all in the change you're =
asking for?

It's not involved, but it's basically what we do on book3s pr kvm. There =
kvmppc_ld reads the guest htab, not the host htab. I think it's fine to =
expose both cases as the same thing to the rest of kvm.


Alex
