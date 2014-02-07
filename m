Return-Path: <James.Yang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E8022C0091
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Feb 2014 13:01:05 +1100 (EST)
Date: Thu, 6 Feb 2014 20:00:59 -0600
From: James Yang <James.Yang@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
In-Reply-To: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
Message-ID: <alpine.LRH.2.00.1402061853550.10318@ra8135-ec1.am.freescale.net>
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 1 Feb 2014, Michael Ellerman wrote:

> This patch adds some documentation on the different cpu families
> supported by arch/powerpc.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v2: Reworked formatting to avoid wrapping.
>     Fixed up Freescale details.
> 
> 
>  Documentation/powerpc/cpu_families.txt | 227 +++++++++++++++++++++++++++++++++
>  1 file changed, 227 insertions(+)
>  create mode 100644 Documentation/powerpc/cpu_families.txt
> 
> diff --git a/Documentation/powerpc/cpu_families.txt b/Documentation/powerpc/cpu_families.txt
> new file mode 100644
> index 0000000..fa4f159
> --- /dev/null
> +++ b/Documentation/powerpc/cpu_families.txt
> @@ -0,0 +1,227 @@
> +CPU Families
> +============
> +
> +This document tries to summarise some of the different cpu families that exist
> +and are supported by arch/powerpc.

I think there are more CPUs that exist(ed), but aren't supported by 
arch/powerpc.  602, Exponential, and there were a few others.  Did you 
want to include those?

Do the arrows' endpoints have a particular meaning?  

Does the direction of the arrows (left vs. down) have a meaning?

What's the meaning of the box?

Do you want to have all of the minor derivatives or just major 
implementations?  Some derivatives were just faster versions, others 
have microarchitectural changes, and some have additional registers or 
removed interfaces.  

There are a lot of ways to delineate this. 



> +
> +
> +Book3S (aka sPAPR)
> +------------------
> +
> + - Hash MMU
> + - Mix of 32 & 64 bit
> +
> +   +--------------+                              +----------------+
> +   |  Old POWER   | ---------------------------> | RS64 (threads) |
> +   +--------------+                              +----------------+
> +          |
> +          |
> +          v
> +   +--------------+                              +----------------+    +-------+
> +   |     601      | ---------------------------> |      603       | -> |  740  |
> +   +--------------+                              +----------------+    +-------+

	There was also at least 603e, 603ev, EC603e, and then offshoot 
G2 core, then the offshoot of that e300c1/e300c2/e300c3/e300c4.  I 
might be missing one here.

	740 is a 750 but without the L2, so it would probably fit 
better off pointing out of the 750 box. Then there is the 755/745 
which have more BATs, L2 features, etc.  Missing from the IBM side is 
750CXe, 750GX, 750GL, but I don't know the lineage of those.  Do you 
want the Nintendo stuff too?  RAD750?


> +          |                                              |
> +          |                                              |
> +          v                                              v
> +   +--------------+                              +----------------+    +-------+
> +   |     604      |                              |    750 (G3)    | -> | 750CX |
> +   +--------------+                              +----------------+    +-------+

Also 604e, and I guess 604ev?



> +          |                                              |                 |
> +          |                                              |                 |
> +          v                                              v                 v
> +   +--------------+                              +----------------+    +-------+
> +   | 620 (64 bit) |                              |      7400      |    | 750CL |
> +   +--------------+                              +----------------+    +-------+
> +          |                                              |                 |
> +          |                                              |                 |
> +          v                                              v                 v
> +   +--------------+                              +----------------+    +-------+
> +   |  POWER3/630  |                              |      7410      |    | 750FX |
> +   +--------------+                              +----------------+    +-------+


7400/7410 mostly the same thing


> +          |                                              |
> +          |                                              |
> +          v                                              v
> +   +--------------+                              +----------------+
> +   |   POWER3+    |                              |      7450      |
> +   +--------------+                              +----------------+
> +          |                                              |
> +          |                                              |
> +          v                                              v
> +   +--------------+                              +----------------+
> +   |    POWER4    |                              |      7455      |
> +   +--------------+                              +----------------+
> +          |                                              |
> +          |                                              |
> +          v                                              v
> +   +--------------+                  +-------+   +----------------+
> +   |   POWER4+    | ---------------> |  970  |   |      7447      |
> +   +--------------+                  +-------+   +----------------+
> +          |                              |               |
> +          |                              |               |
> +          v                              v               v
> +   +--------------+     +-------+    +-------+   +----------------+
> +   |    POWER5    | --> | Cell  |    | 970FX |   |      7448      |
> +   +--------------+     +-------+    +-------+   +----------------+

What about Xenon, how would it fit?


For 745x: I'd organize it:

column = major derivatives
row = minor derivatives

7450/7451/7455/7457        <-- L3
     7441/7445/7447 /7448  <-- no L3
               7447A/e600  



> +          |                              |
> +          |                              |
> +          v                              v
> +   +--------------+                  +-------+
> +   |   POWER5+    |                  | 970MP |
> +   +--------------+                  +-------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |   POWER5++   |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |    POWER6    |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |    POWER7    |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |   POWER7+    |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |    POWER8    |
> +   +--------------+
> +
> +
> +   +---------------+
> +   | PA6T (64 bit) |
> +   +---------------+
> +
> +
> +IBM BookE
> +---------
> +
> + - Software loaded TLB.
> + - All 32 bit
> +
> +   +--------------+
> +   |     401      |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |     403      |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |     405      |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |     440      |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+     +----------------+
> +   |     450      | --> |      BG/P      |
> +   +--------------+     +----------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |     460      |
> +   +--------------+

would you want to fit 464/464FP here?

> +          |
> +          |
> +          v
> +   +--------------+
> +   |     476      |
> +   +--------------+
> +


Did Titan ever get arch/powerpc support?


> +
> +Motorola/Freescale 8xx
> +----------------------
> +
> + - Software loaded with hardware assist.
> + - All 32 bit
> +
> +   +--------------+
> +   |     8xx      |
> +   +--------------+
> +          |
> +          |
> +          v
> +   +--------------+
> +   |     850      |
> +   +--------------+

I don't know enough about the core in there to say that there is a 
distinction for 850.  My impression is that it's not a 603-derivative 
so I agree this lineage of the 8xx/850 is separate from the others.



> +
> +
> +Freescale BookE
> +---------------
> +
> + - Software loaded TLB.
> + - e6500 adds HW loaded indirect TLB entries.
> + - Mix of 32 & 64 bit
> +
> +   +--------------+
> +   |     e200     |
> +   +--------------+
> +
> +
> +   +--------------------------------+
> +   |              e500              |
> +   +--------------------------------+
> +                   |
> +                   |
> +                   v
> +   +--------------------------------+
> +   |             e500v2             |
> +   +--------------------------------+
> +                   |
> +                   |
> +                   v
> +   +--------------------------------+
> +   |             e500mc             |
> +   +--------------------------------+
> +                   |
> +                   |
> +                   v
> +   +--------------------------------+
> +   |    e5500 (Book3e) (64 bit)     |
> +   +--------------------------------+
> +                   |
> +                   |
> +                   v
> +   +--------------------------------+
> +   | e6500 (HW TLB) (Multithreaded) |
> +   +--------------------------------+

64-bit for e6500 as well

> +
> +
> +IBM A2 core
> +-----------
> +
> + - Book3E, software loaded TLB + HW loaded indirect TLB entries.
> + - 64 bit
> +
> +   +--------------+     +----------------+
> +   |   A2 core    | --> |      WSP       |
> +   +--------------+     +----------------+
> +           |
> +           |
> +           v
> +   +--------------+
> +   |     BG/Q     |
> +   +--------------+
> -- 
> 1.8.3.2
> 
> 
> 
