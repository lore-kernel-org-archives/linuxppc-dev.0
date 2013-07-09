Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 062D32C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 04:47:27 +1000 (EST)
Date: Tue, 9 Jul 2013 13:46:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <51DC4C00.70509@suse.de> (from agraf@suse.de on Tue Jul  9
 12:44:32 2013)
Message-ID: <1373395605.8183.198@snotra>
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

On 07/09/2013 12:44:32 PM, Alexander Graf wrote:
> On 07/09/2013 07:13 PM, Scott Wood wrote:
>> On 07/08/2013 08:39:05 AM, Alexander Graf wrote:
>>>=20
>>> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>>>=20
>>> > lwepx faults needs to be handled by KVM and this implies =20
>>> additional code
>>> > in DO_KVM macro to identify the source of the exception =20
>>> originated from
>>> > host context. This requires to check the Exception Syndrome =20
>>> Register
>>> > (ESR[EPID]) and External PID Load Context Register (EPLC[EGS]) =20
>>> for DTB_MISS,
>>> > DSI and LRAT exceptions which is too intrusive for the host.
>>> >
>>> > Get rid of lwepx and acquire last instuction in =20
>>> kvmppc_handle_exit() by
>>> > searching for the physical address and kmap it. This fixes an =20
>>> infinite loop
>>>=20
>>> What's the difference in speed for this?
>>>=20
>>> Also, could we call lwepx later in host code, when =20
>>> kvmppc_get_last_inst() gets invoked?
>>=20
>> Any use of lwepx is problematic unless we want to add overhead to =20
>> the main Linux TLB miss handler.
>=20
> What exactly would be missing?

If lwepx faults, it goes to the normal host TLB miss handler.  Without =20
adding code to it to recognize that it's an external-PID fault, it will =20
try to search the normal Linux page tables and insert a normal host =20
entry.  If it thinks it has succeeded, it will retry the instruction =20
rather than search for an exception handler.  The instruction will =20
fault again, and you get a hang.

> I'd also still like to see some performance benchmarks on this to =20
> make sure we're not walking into a bad direction.

I doubt it'll be significantly different.  There's overhead involved in =20
setting up for lwepx as well.  It doesn't hurt to test, though this is =20
a functional correctness issue, so I'm not sure what better =20
alternatives we have.  I don't want to slow down non-KVM TLB misses for =20
this.

>>> > +    addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
>>> > +           (geaddr & ((1ULL << psize_shift) - 1ULL));
>>> > +
>>> > +    /* Map a page and get guest's instruction */
>>> > +    page =3D pfn_to_page(addr >> PAGE_SHIFT);
>>>=20
>>> So it seems to me like you're jumping through a lot of hoops to =20
>>> make sure this works for LRAT and non-LRAT at the same time. Can't =20
>>> we just treat them as the different things they are?
>>>=20
>>> What if we have different MMU backends for LRAT and non-LRAT? The =20
>>> non-LRAT case could then try lwepx, if that fails, fall back to =20
>>> read the shadow TLB. For the LRAT case, we'd do lwepx, if that =20
>>> fails fall back to this logic.
>>=20
>> This isn't about LRAT; it's about hardware threads.  It also fixes =20
>> the handling of execute-only pages on current chips.
>=20
> On non-LRAT systems we could always check our shadow copy of the =20
> guest's TLB, no? I'd really like to know what the performance =20
> difference would be for the 2 approaches.

I suspect that tlbsx is faster, or at worst similar.  And unlike =20
comparing tlbsx to lwepx (not counting a fix for the threading =20
problem), we don't already have code to search the guest TLB, so =20
testing would be more work.

-Scott=
