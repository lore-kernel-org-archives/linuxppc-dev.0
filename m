Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 7367B2C008C
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2012 16:18:52 +1000 (EST)
Date: Mon, 3 Sep 2012 23:18:45 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Steven Rostedt <rostedt@goodmis.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.5+: yaboot, Invalid memory access
In-Reply-To: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
Message-ID: <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 30 Jul 2012 at 22:46, Christian Kujau wrote:
> when trying to upgrade from 3.5 (final) to today's git checkout from 
> Linus' tree, yaboot cannot boot and the following is printed:
> 
>   [...]
>   returning from prom_init
>   Invalid memory access at %SRR0: 00c62fd4  %SRR1: 00003030

Finally got around to do a bisection:

-----------------------------
b6e3796834faefe4b6e9a2aedfe12665cd51fbc5 is the first bad commit
commit b6e3796834faefe4b6e9a2aedfe12665cd51fbc5
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Thu Apr 26 08:31:18 2012 +0000

    powerpc: Have patch_instruction detect faults
    
    For ftrace to use the patch_instruction code, it needs to check for
    faults on write. Ftrace updates code all over the kernel, and we need 
    to know if code is updated or not due to protections that are placed 
    on some portions of the kernel. If ftrace does not detect a fault, it 
    will error later on, and it will be much more difficult to find the 
    problem.
    
    By changing patch_instruction() to detect faults, then ftrace will be
    able to make use of it too.
    
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

:040000 040000 83fb0e420524db452c07425e4dc402041428e696 0d1a01acd863237cf388045946ad4446a28df50c M      arch
-----------------------------

The changeset looked pretty harmless to me but I tested with a current 
3.6+ git checkout and the kernel would only boot when this changeset was
reverted.

Thoughts?

Thanks,
Christian.

> The whole message: http://nerdbynature.de/bits/3.5.0/yaboot/
> 
> The Yaboot version is 1.3.16 (from Debian/testing), I haven't tried 1.3.17 
> yet, its changelog does not say anything about "newer kernel support" so 
> I'm not sure if this would help here.
> 
> Any other ideas?
> 
> Thanks,
> Christian.

-- 
BOFH excuse #154:

You can tune a file system, but you can't tune a fish (from most tunefs man pages)
