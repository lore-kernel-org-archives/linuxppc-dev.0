Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1Ts507lZzDsNN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 15:24:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S PR: only call slbmte for valid SLB
 entries
In-Reply-To: <20170926035638.GI12504@umbus>
References: <150607286967.26027.12529646475118424696.stgit@bahia.lan>
 <20170926035638.GI12504@umbus>
Date: Tue, 26 Sep 2017 15:24:05 +1000
Message-ID: <87mv5if2x6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Fri, Sep 22, 2017 at 11:34:29AM +0200, Greg Kurz wrote:
>> Userland passes an array of 64 SLB descriptors to KVM_SET_SREGS,
>> some of which are valid (ie, SLB_ESID_V is set) and the rest are
>> likely all-zeroes (with QEMU at least).
>> 
>> Each of them is then passed to kvmppc_mmu_book3s_64_slbmte(), which
>> assumes to find the SLB index in the 3 lower bits of its rb argument.
>> When passed zeroed arguments, it happily overwrites the 0th SLB entry
>> with zeroes. This is exactly what happens while doing live migration
>> with QEMU when the destination pushes the incoming SLB descriptors to
>> KVM PR. When reloading the SLBs at the next synchronization, QEMU first
>> clears its SLB array and only restore valid ones, but the 0th one is
>> now gone and we cannot access the corresponding memory anymore:
>> 
>> (qemu) x/x $pc
>> c0000000000b742c: Cannot access memory
>> 
>> To avoid this, let's filter out non-valid SLB entries, like we
>> already do for Book3S HV.
>> 
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>
> This seems like a good idea, but to make it fully correct, don't we
> also need to fully flush the SLB before inserting the new entries.

We would need to do that yeah.

But I don't think I like this patch, it would mean userspace has no way
of programming an invalid SLB entry. It's true that in general that
isn't something we care about doing, but the API should allow it.

For example the kernel could leave invalid entries in place and flip the
valid bit when it wanted to make them valid, and this patch would
prevent that state being successfully migrated IIUIC.

cheers
