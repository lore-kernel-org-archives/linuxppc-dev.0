Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AD2B1A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 14:52:35 +1000 (AEST)
Message-ID: <1437540754.16792.10.camel@ellerman.id.au>
Subject: Re: [RFC, 7/8] powerpc/xmon: Drop 'valid' from the condition inside
 'dump_segments'
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
Date: Wed, 22 Jul 2015 14:52:34 +1000
In-Reply-To: <55AE30E0.6060002@linux.vnet.ibm.com>
References: <20150721100018.98F93140DBC@ozlabs.org>
 <55AE30E0.6060002@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-21 at 17:15 +0530, Anshuman Khandual wrote:
> On 07/21/2015 03:30 PM, Michael Ellerman wrote:
> > On Tue, 2015-21-07 at 06:58:45 UTC, Anshuman Khandual wrote:
> >> > From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> >> > 
> >> > Value of 'valid' is zero when 'esid' is zero and it does not matter
> >> > when 'esid' is non-zero. 
> > Yes it does. It tells you whether the entry is valid?
> 
> Yeah but it does not change the outcome of the if condition check
> here. Non-zero esid will make the condition test pass irrespective
> of the value of 'valid'. Yes, valid will be checked inside the code
> block to print details, the point was value of valid does not make
> any difference to the 'if' condition check in the first place.
> Unless I am getting tricked here some how :)

No you're right, I was confused by the bitwise or.

Please make it:  if (esid || vsid)

And drop valid entirely, just do the check in the if condition.

And fix the change log:

  Hence the variable 'value'
                      ^
		      valid


cheers
