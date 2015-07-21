Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23B391A0072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 19:46:07 +1000 (AEST)
In-Reply-To: <1437461926-8908-2-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [RFC,
 2/8] powerpc/slb: Rename all the 'entry' occurrences to 'slot'
Message-Id: <20150721094606.DBFC7140E10@ozlabs.org>
Date: Tue, 21 Jul 2015 19:46:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-21-07 at 06:58:40 UTC, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> 
> These are essentially SLB individual slots what we are dealing with
> in these functions. Usage of both 'entry' and 'slot' synonyms makes
> it real confusing sometimes. This patch makes it uniform across the
> file by replacing all those 'entry's with 'slot's.

No I think it would be better the other way around.

Currently we use entry in 14 places and slot in 3.

Both can be correct in some places, but not always.

For example:

> -	 * Clear the ESID first so the entry is not valid while we are
> +	 * Clear the ESID first so the slot is not valid while we are

That doesn't make sense with "slot", a slot is not valid, only an entry in a
slot is valid.

Looking at the existing uses of slot they will all make sense if you change
them to entry.

cheers
