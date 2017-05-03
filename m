Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHR2NZhzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:59 +1000 (AEST)
In-Reply-To: <1493030819-3534-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/sysfs: Move #ifdef CONFIG_HOTPLUG_CPU out of the function
 body
Message-Id: <3wJCHR0pQxz9rxm@ozlabs.org>
Date: Thu,  4 May 2017 08:18:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-24 at 10:46:59 UTC, Michael Ellerman wrote:
> The entire body of unregister_cpu_online() is inside an #ifdef
> CONFIG_HOTPLUG_CPU block. This is ugly and means we create an empty function
> when hotplug is disabled for no reason.
> 
> Instead move the #ifdef out of the function body and define the function to be
> NULL in the else case. This means we'll pass NULL to cpuhp_setup_state(), but
> that's fine because it accepts NULL to mean there is no teardown callback, which
> is exactly what we want.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/3f2290e1b5192fdfa74f012220a8d9

cheers
