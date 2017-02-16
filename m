Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPFYg1YpczDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 23:18:31 +1100 (AEDT)
In-Reply-To: <20170216024921.GB19110@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: powerpc/64: Disable use of radix under a hypervisor
Message-Id: <3vPFYg08d6z9s8S@ozlabs.org>
Date: Thu, 16 Feb 2017 23:18:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-16 at 02:49:21 UTC, Paul Mackerras wrote:
> Currently, if the kernel is running on a POWER9 processor under a
> hypervisor, it may try to use the radix MMU even though it doesn't have
> the necessary code to do so (it doesn't negotiate use of radix, and it
> doesn't do the H_REGISTER_PROC_TBL hcall).  If the hypervisor supports
> both radix and HPT, then it will set up the guest to use HPT (since the
> guest doesn't request radix in the CAS call), but if the radix feature
> bit is set in the ibm,pa-features property (which is valid, since
> ibm,pa-features is defined to represent the capabilities of the
> processor) the guest will try to use radix, resulting in a crash when
> it turns the MMU on.
> 
> This makes the minimal fix for the current code, which is to disable
> radix unless we are running in hypervisor mode.
> 
> Fixes: 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for early init routines")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3f91a89d424a79f8082525db5a375e

cheers
