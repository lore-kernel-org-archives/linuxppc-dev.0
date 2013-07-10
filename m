Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7592A2C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 10:06:48 +1000 (EST)
Date: Tue, 9 Jul 2013 19:06:37 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <BD85AACF-5975-459D-9D28-8DB672D6B5C3@suse.de> (from
 agraf@suse.de on Tue Jul  9 16:44:24 2013)
Message-ID: <1373414797.8183.212@snotra>
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

On 07/09/2013 04:44:24 PM, Alexander Graf wrote:
>=20
> On 09.07.2013, at 20:46, Scott Wood wrote:
> > I suspect that tlbsx is faster, or at worst similar.  And unlike =20
> comparing tlbsx to lwepx (not counting a fix for the threading =20
> problem), we don't already have code to search the guest TLB, so =20
> testing would be more work.
>=20
> We have code to walk the guest TLB for TLB misses. This really is =20
> just the TLB miss search without host TLB injection.
>=20
> So let's say we're using the shadow TLB. The guest always has its say =20
> 64 TLB entries that it can count on - we never evict anything by =20
> accident, because we store all of the 64 entries in our guest TLB =20
> cache. When the guest faults at an address, the first thing we do is =20
> we check the cache whether we have that page already mapped.
>=20
> However, with this method we now have 2 enumeration methods for guest =20
> TLB searches. We have the tlbsx one which searches the host TLB and =20
> we have our guest TLB cache. The guest TLB cache might still contain =20
> an entry for an address that we already invalidated on the host. =20
> Would that impose a problem?
>=20
> I guess not because we're swizzling the exit code around to instead =20
> be an instruction miss which means we restore the TLB entry into our =20
> host's TLB so that when we resume, we land here and the tlbsx hits. =20
> But it feels backwards.

Any better way?  Searching the guest TLB won't work for the LRAT case, =20
so we'd need to have this logic around anyway.  We shouldn't add a =20
second codepath unless it's a clear performance gain -- and again, I =20
suspect it would be the opposite, especially if the entry is not in =20
TLB0 or in one of the first few entries searched in TLB1.  The tlbsx =20
miss case is not what we should optimize for.

> At least this code has to become something more generic, such as =20
> kvmppc_read_guest(vcpu, addr, TYPE_INSN) and move into the host mmu =20
> implementation, as it's 100% host mmu specific.

I agree that e500_mmu_host.c is a better place for it (with an ifdef =20
for BOOKEHV), but supporting anything other than instruction fetches =20
could wait until we have a user for it (it means extra code to figure =20
out if permissions are correct).

-Scott=
