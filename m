Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr3tL3KMbzDrRT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 23:22:50 +1100 (AEDT)
From: Michael Ellerman <michael@ellerman.id.au>
To: David Gibson <david@gibson.dropbear.id.au>,
 Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix use after free in HPT resizing code and related
 minor improvements
In-Reply-To: <20171204061025.GQ2130@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <20171204061025.GQ2130@umbus.fritz.box>
Date: Mon, 04 Dec 2017 23:22:47 +1100
Message-ID: <87indmsmw8.fsf@concordia.ellerman.id.au>
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

> On Wed, Nov 29, 2017 at 11:38:22AM -0500, Serhii Popovych wrote:
>> It is possible to trigger use after free during HPT resize
>> causing host kernel to crash. More details and analysis of
>> the problem can be found in change with corresponding subject
>> (KVM: PPC: Book3S HV: Fix use after free in case of multiple
>> resize requests).
>> 
>> We need some changes to prepare for the fix, especially
>> make ->error in HPT resize instance single point for
>> tracking allocation state, improve kvmppc_allocate_hpt()
>> and kvmppc_free_hpt() so they can be used more safely.
>> 
>> See individual commit description message to get more
>> information on changes presented.
>
> I spoke with Paul Mackerras about these patches on IRC today.  We want
> this as a fix, ASAP, in 4.15.  However, he's uncomfortable with
> pushing some of extra cleanups which aren't necessary for the bug fix
> this late for 4.15, and was having trouble following what was the core
> of the fix.  He was also nervous about the addition of more BUG_ON()s.

As was I.

> To avoid the round trip to Ukraine time and back, I've made revised
> versions of patches 1 & 3 which should apply standalone, replaced the
> BUG_ON()s with WARN_ON()s

Thanks.

cheers
