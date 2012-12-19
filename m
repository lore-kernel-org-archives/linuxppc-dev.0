Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F340D2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2012 08:53:49 +1100 (EST)
Message-ID: <1355954017.5397.53.camel@pasglop>
Subject: Re: PS3 platform is broken on Linux 3.7.0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Thu, 20 Dec 2012 08:53:37 +1100
In-Reply-To: <1355488506.55692113@f147.mail.ru>
References: <1355488506.55692113@f147.mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-12-14 at 16:35 +0400, Phileas Fogg wrote:
> Hi,
> 
> I wanted to bring to your attention the fact that the PS3 platform is broken on Linux 3.7.0.
> 
> i'm not able to boot Linux 3.7.0 on my PS3 slim. Linux 3.6.10 boots just fine but not 3.7.0
> When i try to boot Linux 3.7.0 then my PS3  shuts down.
> 
> So i cloned the Linux powerpc GIT repository and tried to find out which commits broke the PS3 platform.
> After some time I tracked it down to 2 commits:

Aneesh, do you have any idea what might be going on there ? Can you look
at the PS3 hash code ? It's a bit different from the rest, you might
have missed an update or two...

Michael, same deal with PACA...

Cheers,
Ben.

> ---------------------------------------------------------------------------------------------
> 
> commit 407821a34fce89b4f0b031dbab5cec7d059f46bc
> Author: Michael Ellerman <michael@ellerman.id.au>
> Date:   Fri Sep 7 15:31:44 2012 +0000
> 
>     powerpc: Initialise paca.data_offset with poison
>     
>     It's possible for the cpu_possible_mask to change between the time we
>     initialise the pacas and the time we setup per_cpu areas.
>     
>     Obviously impossible cpus shouldn't ever be running, but stranger things
>     have happened. So be paranoid and initialise data_offset with a poison
>     value in case we don't set it up later.
>     
>     Based on a patch from Anton Blanchard.
>     
>     Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> 
> ------------------------------------------------------------------------------------------------
> 
> commit 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Mon Sep 10 02:52:55 2012 +0000
> 
>     powerpc/mm: Add 64TB support
>     
>     Increase max addressable range to 64TB. This is not tested on
>     real hardware yet.
>     
>     Reviewed-by: Paul Mackerras <paulus@samba.org>
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ----------------------------------------------------------------------------------------------------------
> 
> The first commit causes my PS3 to shut down. If i revert it then i'm able to boot Linux 3.7.0 and even see some boot messages
> on my screen. But then it hangs. The second commit is the reason for the hang as i figured it out.
> 
> I reverted both commits in current Linux 3.7.0 and was able to boot Linux 3.7.0 on my PS3 slim successfully.
> 
> Regards
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
