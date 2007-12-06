Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18263.27999.950921.122870@cargo.ozlabs.ibm.com>
Date: Thu, 6 Dec 2007 14:32:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Use SLB size from the device tree
In-Reply-To: <510.1194565218@neuling.org>
References: <510.1194565218@neuling.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling writes:

> Currently we hardwire the number of SLBs but the PAPR says we export an
> ibm,slb-size property to specify the number of SLB entries.  This patch
> uses this property instead of assuming 64 always.  If no property is
> found, we assume 64 entries as before.

On 32-bit platforms (e.g. powermac) I get:

/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c: In function 'check_cpu_slb_size':
/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c:592: error: 'mmu_slb_size' undeclared (first use in this function)
/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c:592: error: (Each undeclared identifier is reported only once
/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c:592: error: for each function it appears in.)
make[2]: *** [arch/powerpc/kernel/prom.o] Error 1

Paul.
