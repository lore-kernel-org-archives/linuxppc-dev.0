Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F0BA22C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 11:38:10 +1000 (EST)
Message-ID: <1346981712.2385.30.camel@pasglop>
Subject: Re: [PATCH v2 1/2] [powerpc] Change memory_limit from phys_addr_t
 to unsigned long long
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Fri, 07 Sep 2012 11:35:12 +1000
In-Reply-To: <20120821114225.29282.87841.stgit@suzukikp.in.ibm.com>
References: <20120821113815.29282.4000.stgit@suzukikp.in.ibm.com>
 <20120821114225.29282.87841.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-08-21 at 17:12 +0530, Suzuki K. Poulose wrote:
> There are some device-tree nodes, whose values are of type phys_addr_t.
> The phys_addr_t is variable sized based on the CONFIG_PHSY_T_64BIT.
> 
> Change these to a fixed unsigned long long for consistency.
> 
> This patch does the change only for memory_limit.
> 
> The following is a list of such variables which need the change:
> 
>  1) kernel_end, crashk_size - in arch/powerpc/kernel/machine_kexec.c
> 
>  2) (struct resource *)crashk_res.start - We could export a local static
>     variable from machine_kexec.c.
> 
> Changing the above values might break the kexec-tools. So, I will
> fix kexec-tools first to handle the different sized values and then change
>  the above.
> 
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> ---

Breaks the build on some configs (with 32-bit phys_addr_t):

/home/benh/linux-powerpc-test/arch/powerpc/kernel/prom.c: In function
'early_init_devtree':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/prom.c:664:25: error:
comparison of distinct pointer types lacks a cast

I'm fixing that myself this time but please be more careful.

Cheers,
Ben.
