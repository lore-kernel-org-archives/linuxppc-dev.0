Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwKZd73frzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:52:09 +1000 (AEST)
In-Reply-To: <1461301069-12331-1-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, Frank Haverkamp <HAVERKAM@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] cxl: Keep IRQ mappings on context teardown
Message-Id: <3qwKZd5Y59z9t6M@ozlabs.org>
Date: Thu, 28 Apr 2016 11:52:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-22-04 at 04:57:48 UTC, Michael Neuling wrote:
> Keep IRQ mappings on context teardown.  This won't leak IRQs as if we
> allocate the mapping again, the generic code will give the same
> mapping used last time.
> 
> Doing this works around a race in the generic code. Masking the
> interrupt introduces a race which can crash the kernel or result in
> IRQ that is never EOIed. The lost of EOI results in all subsequent
> mappings to the same HW IRQ never receiving an interrupt.
> 
> We've seen this race with cxl test cases which are doing heavy context
> startup and teardown at the same time as heavy interrupt load.
> 
> A fix to the generic code is being investigated also.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> cc: stable@vger.kernel.org # 3.8
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d6776bba44d9752f6cdf640046

cheers
