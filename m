Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyp4h4Rz2zDr4g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 15:24:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Tell OPAL about our MMU mode
In-Reply-To: <1498655175.3651.43.camel@kernel.crashing.org>
References: <1498421118.31581.110.camel@kernel.crashing.org>
 <87a84sd72z.fsf@concordia.ellerman.id.au>
 <1498655175.3651.43.camel@kernel.crashing.org>
Date: Thu, 29 Jun 2017 15:24:36 +1000
Message-ID: <87efu3bc2z.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2017-06-28 at 15:17 +1000, Michael Ellerman wrote:
>> Which doesn't really make sense. FSP says it's running (runtime).
>> 
>> The end of the OPAL log is below.
>> 
>> I think your patch means we're now calling slw_reinit(), whereas
>> previously we would skip it?
>
> Ugh... and slw_reinit() is somewhat broken I suppose these days. Drat.
>
> Mikey, we probably need to key that off arch 300 or check for a DT prop
> skiboot would put in that tells Linux it can do this.

DT prop of accepted reinit flags seems like it would work.

No prop means HILE_LE/HILE_BE.

cheers
