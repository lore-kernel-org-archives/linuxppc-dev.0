Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2620E2C0082
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 09:43:51 +1100 (EST)
Message-ID: <1391553822.6733.189.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 4 Feb 2014 16:43:42 -0600
In-Reply-To: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-02-01 at 15:35 +1100, Michael Ellerman wrote:
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
> +          |                                              |
> +          |                                              |
> +          v                                              v
> +   +--------------+                              +----------------+    +-------+
> +   |     604      |                              |    750 (G3)    | -> | 750CX |
> +   +--------------+                              +----------------+    +-------+
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

Missing e300 (603 derivative) and e600 (7448 derivative).

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

Are 40x considered booke?

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

Is the core of MPC850 different from other MPC8xx?

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

Why (Book3e) on e5500?  e500mc is also an ISA 2.06 book3e core.

-Scott
