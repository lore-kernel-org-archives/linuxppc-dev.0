Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy5970M2wzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:40:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "stable\@vger.kernel.org" <stable@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH backport pre-4.9] powerpc/slb: Force a full SLB flush when
 we insert for a bad EA
In-Reply-To: <20170627105958.GA10609@kroah.com>
References: <87k244sed8.fsf@concordia.ellerman.id.au>
 <20170627105958.GA10609@kroah.com>
Date: Wed, 28 Jun 2017 11:40:55 +1000
Message-ID: <87fuekdh3s.fsf@concordia.ellerman.id.au>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Thu, Jun 22, 2017 at 04:52:51PM +1000, Michael Ellerman wrote:
>> The SLB miss handler calls slb_allocate_realmode() in order to create an
>> SLB entry for the faulting address. At the very start of that function
>> we check that the faulting Effective Address (EA) is less than
>> PGTABLE_RANGE (ignoring the region), ie. is it an address which could
>> possibly fit in the virtual address space.
...
>> ---
>>  arch/powerpc/mm/slb_low.S | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> Note this patch is not upstream. The bug fix was fixed differently in
>> upstream prior to the bug being identified.
>
> Now applied to 4.4 and 3.18-stable kernels, thanks,

Thanks.

cheers
