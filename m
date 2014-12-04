Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 682521A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 17:03:23 +1100 (AEDT)
In-Reply-To: <20141203135812.4126.85795.stgit@bahia.local>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: remove the smt-enabled kernel parameter
Message-Id: <20141204060323.52E291400EA@ozlabs.org>
Date: Thu,  4 Dec 2014 17:03:23 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 13:58:13 UTC, Greg Kurz wrote:
> This parameter basically leaves unwanted cpus executing in firmware or
> wherever they happen to be. This is a hack that shoudn't be used in a
> production environment.
> 
> It also has an evil side effect on the split-core feature for powernv. The
> code needs all the cpus to participate to the split mode update: it relies
> on smp_send_reschedule() to get offline ones to do so. This doesn't work with
> cpus that haven't come up... The consequence is a kernel hang at boot time
> on powernv when smt-enabled is used to limit the number of threads.
> 
> This patch simply removes the smt-enabled kernel parameter for all platforms.
> >From now on, SMT mode should be set by userspace.
> 
> I see there also is a ibm,smt-enabled property but I could not find any
> piece of information about it. Since it does the very same thing as the
> kernel parameter, it is tempting to drop it alike... This would possibly
> allow more simplification like killing the cpu_bootable hook.
> 
> Please give advice anyone.

Hi Greg,

Thanks for doing this.

I discussed this on irc and Benh & Anton both agree we should drop it.

Please send a v2 which also drops the support for ibm,smt-enabled.

Our reasoning is 1) it doesn't work correctly in the same way as the command
line option, 2) no one is aware of anything that still uses it, 3) there are
better ways for firmware to disable SMT.

Can you then send a 2nd patch which removes the cpu_bootable hook.

cheers
