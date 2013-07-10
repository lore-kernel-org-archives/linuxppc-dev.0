Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id E952E2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 20:15:14 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373414797.8183.212@snotra>
Date: Wed, 10 Jul 2013 12:15:09 +0200
Message-Id: <2750D29D-8CE6-40D3-922D-864F447FEFD8@suse.de>
References: <1373414797.8183.212@snotra>
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


On 10.07.2013, at 02:06, Scott Wood wrote:

> On 07/09/2013 04:44:24 PM, Alexander Graf wrote:
>> On 09.07.2013, at 20:46, Scott Wood wrote:
>> > I suspect that tlbsx is faster, or at worst similar.  And unlike =
comparing tlbsx to lwepx (not counting a fix for the threading problem), =
we don't already have code to search the guest TLB, so testing would be =
more work.
>> We have code to walk the guest TLB for TLB misses. This really is =
just the TLB miss search without host TLB injection.
>> So let's say we're using the shadow TLB. The guest always has its say =
64 TLB entries that it can count on - we never evict anything by =
accident, because we store all of the 64 entries in our guest TLB cache. =
When the guest faults at an address, the first thing we do is we check =
the cache whether we have that page already mapped.
>> However, with this method we now have 2 enumeration methods for guest =
TLB searches. We have the tlbsx one which searches the host TLB and we =
have our guest TLB cache. The guest TLB cache might still contain an =
entry for an address that we already invalidated on the host. Would that =
impose a problem?
>> I guess not because we're swizzling the exit code around to instead =
be an instruction miss which means we restore the TLB entry into our =
host's TLB so that when we resume, we land here and the tlbsx hits. But =
it feels backwards.
>=20
> Any better way?  Searching the guest TLB won't work for the LRAT case, =
so we'd need to have this logic around anyway.  We shouldn't add a =
second codepath unless it's a clear performance gain -- and again, I =
suspect it would be the opposite, especially if the entry is not in TLB0 =
or in one of the first few entries searched in TLB1.  The tlbsx miss =
case is not what we should optimize for.

Hrm.

So let's redesign this thing theoretically. We would have an exit that =
requires an instruction fetch. We would override kvmppc_get_last_inst() =
to always do kvmppc_ld_inst(). That one can fail because it can't find =
the TLB entry in the host TLB. When it fails, we have to abort the =
emulation and resume the guest at the same IP.

Now the guest gets the TLB miss, we populate, go back into the guest. =
The guest hits the emulation failure again. We go back to =
kvmppc_ld_inst() which succeeds this time and we can emulate the =
instruction.

I think this works. Just make sure that the gateway to the instruction =
fetch is kvmppc_get_last_inst() and make that failable. Then the =
difference between looking for the TLB entry in the host's TLB or in the =
guest's TLB cache is hopefully negligible.

>=20
>> At least this code has to become something more generic, such as =
kvmppc_read_guest(vcpu, addr, TYPE_INSN) and move into the host mmu =
implementation, as it's 100% host mmu specific.
>=20
> I agree that e500_mmu_host.c is a better place for it (with an ifdef =
for BOOKEHV), but supporting anything other than instruction fetches =
could wait until we have a user for it (it means extra code to figure =
out if permissions are correct).

Works for me, as long as it's either documented through BUG_ON/WARN_ON's =
or an explicit naming convention.


Alex
