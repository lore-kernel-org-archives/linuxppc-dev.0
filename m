Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnh9J6QjlzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 19:27:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Shriya R . Kulkarni" <shriykul@in.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc64/hw_breakpoints: Handle data breakpoints in
 radix mode
In-Reply-To: <4b6d375c-cebc-16b9-f660-48ec51f98456@linux.vnet.ibm.com>
References: <20170613184200.22541-1-naveen.n.rao@linux.vnet.ibm.com>
 <4b6d375c-cebc-16b9-f660-48ec51f98456@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 19:27:00 +1000
Message-ID: <87shj23onv.fsf@concordia.ellerman.id.au>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 06/14/2017 12:12 AM, Naveen N. Rao wrote:
>> On P9, trying to use data breakpoints throws the splat shown below (*).
>> This is because the check for a data breakpoint in DSISR is in
>> do_hash_page(). Move this check to handle_page_fault() so as to catch
>> data breakpoints in both hash and radix MMU modes.
>
> Why cant we check for DSISR inside do_hash_page() on P9 ?

We can.

But we also need to check inside handle_page_fault(), because when we're
in Radix mode we don't go via do_hash_page().

So rather than doing it in two places, the patch changes the logic so we
check in handle_page_fault(), and teaches the do_hash_page() code to go
there if DSISR_DABRMATCH is set.

cheers
