Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 82FD92C008F
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2012 19:32:49 +1000 (EST)
Date: Tue, 4 Sep 2012 02:32:36 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: 3.5+: yaboot, Invalid memory access
In-Reply-To: <1346741491.7619.12.camel@concordia>
Message-ID: <alpine.DEB.2.01.1209040223380.25392@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Sep 2012 at 16:51, Michael Ellerman wrote:
> My guess would be we're calling that quite early and the __put_user()
> check is getting confused and failing. That means we'll have left some
> code unpatched, which then fails.
> 
> Can you try with the patch applied, but instead of returning if the
> __put_user() fails, just continue on anyway.

You mean, like this?

------
diff --git a/arch/powerpc/lib/code-patching.c 
b/arch/powerpc/lib/code-patching.c
index dd223b3..755b623 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -21,8 +21,8 @@ int patch_instruction(unsigned int *addr, unsigned int 
instr)
        int err;
 
        err = __put_user(instr, addr);
-       if (err)
-               return err;
+//     if (err)
+//             return err;
        asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
        return 0;
 }
------


Thanks,
Christian.

> 
> That will isolate if it's something in the __put_user() (I doubt it), or
> just that the __put_user() is failing and leaving the code unpatched.
> 
> cheers
-- 
BOFH excuse #361:

Communist revolutionaries taking over the server room and demanding all the computers in the building or they shoot the sysadmin. Poor misguided fools.
