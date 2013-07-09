Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 119612C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 07:44:31 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373395605.8183.198@snotra>
Date: Tue, 9 Jul 2013 23:44:24 +0200
Message-Id: <BD85AACF-5975-459D-9D28-8DB672D6B5C3@suse.de>
References: <1373395605.8183.198@snotra>
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


On 09.07.2013, at 20:46, Scott Wood wrote:

> On 07/09/2013 12:44:32 PM, Alexander Graf wrote:
>> On 07/09/2013 07:13 PM, Scott Wood wrote:
>>> On 07/08/2013 08:39:05 AM, Alexander Graf wrote:
>>>> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>>>> > lwepx faults needs to be handled by KVM and this implies =
additional code
>>>> > in DO_KVM macro to identify the source of the exception =
originated from
>>>> > host context. This requires to check the Exception Syndrome =
Register
>>>> > (ESR[EPID]) and External PID Load Context Register (EPLC[EGS]) =
for DTB_MISS,
>>>> > DSI and LRAT exceptions which is too intrusive for the host.
>>>> >
>>>> > Get rid of lwepx and acquire last instuction in =
kvmppc_handle_exit() by
>>>> > searching for the physical address and kmap it. This fixes an =
infinite loop
>>>> What's the difference in speed for this?
>>>> Also, could we call lwepx later in host code, when =
kvmppc_get_last_inst() gets invoked?
>>> Any use of lwepx is problematic unless we want to add overhead to =
the main Linux TLB miss handler.
>> What exactly would be missing?
>=20
> If lwepx faults, it goes to the normal host TLB miss handler.  Without =
adding code to it to recognize that it's an external-PID fault, it will =
try to search the normal Linux page tables and insert a normal host =
entry.  If it thinks it has succeeded, it will retry the instruction =
rather than search for an exception handler.  The instruction will fault =
again, and you get a hang.

:(

So we either have to rewrite IVOR / IVPR or add a branch in the hot TLB =
miss interrupt handler. Both alternatives suck.

>=20
>> I'd also still like to see some performance benchmarks on this to =
make sure we're not walking into a bad direction.
>=20
> I doubt it'll be significantly different.  There's overhead involved =
in setting up for lwepx as well.  It doesn't hurt to test, though this =
is a functional correctness issue, so I'm not sure what better =
alternatives we have.  I don't want to slow down non-KVM TLB misses for =
this.

Yeah, I concur on that part. It probably won't get better. Sigh.

>=20
>>>> > +    addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
>>>> > +           (geaddr & ((1ULL << psize_shift) - 1ULL));
>>>> > +
>>>> > +    /* Map a page and get guest's instruction */
>>>> > +    page =3D pfn_to_page(addr >> PAGE_SHIFT);
>>>> So it seems to me like you're jumping through a lot of hoops to =
make sure this works for LRAT and non-LRAT at the same time. Can't we =
just treat them as the different things they are?
>>>> What if we have different MMU backends for LRAT and non-LRAT? The =
non-LRAT case could then try lwepx, if that fails, fall back to read the =
shadow TLB. For the LRAT case, we'd do lwepx, if that fails fall back to =
this logic.
>>> This isn't about LRAT; it's about hardware threads.  It also fixes =
the handling of execute-only pages on current chips.
>> On non-LRAT systems we could always check our shadow copy of the =
guest's TLB, no? I'd really like to know what the performance difference =
would be for the 2 approaches.
>=20
> I suspect that tlbsx is faster, or at worst similar.  And unlike =
comparing tlbsx to lwepx (not counting a fix for the threading problem), =
we don't already have code to search the guest TLB, so testing would be =
more work.

We have code to walk the guest TLB for TLB misses. This really is just =
the TLB miss search without host TLB injection.

So let's say we're using the shadow TLB. The guest always has its say 64 =
TLB entries that it can count on - we never evict anything by accident, =
because we store all of the 64 entries in our guest TLB cache. When the =
guest faults at an address, the first thing we do is we check the cache =
whether we have that page already mapped.

However, with this method we now have 2 enumeration methods for guest =
TLB searches. We have the tlbsx one which searches the host TLB and we =
have our guest TLB cache. The guest TLB cache might still contain an =
entry for an address that we already invalidated on the host. Would that =
impose a problem?

I guess not because we're swizzling the exit code around to instead be =
an instruction miss which means we restore the TLB entry into our host's =
TLB so that when we resume, we land here and the tlbsx hits. But it =
feels backwards.

At least this code has to become something more generic, such as =
kvmppc_read_guest(vcpu, addr, TYPE_INSN) and move into the host mmu =
implementation, as it's 100% host mmu specific.


Alex
