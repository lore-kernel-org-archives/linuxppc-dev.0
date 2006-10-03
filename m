Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17697.47589.788457.877617@cargo.ozlabs.ibm.com>
Date: Tue, 3 Oct 2006 11:16:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Judith Lebzelter <judith@osdl.org>
Subject: Re: Undefined '.bus_to_virt',
	'.virt_to_bus' causes compile error on Powerpc 64-bit
In-Reply-To: <20061002214954.GD665@shell0.pdx.osdl.net>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Judith,

> For the automated cross-compile builds at OSDL, powerpc 64-bit 
> 'allmodconfig' is failing.  The warnings/errors below appear in 
> the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.

virt_to_bus and bus_to_virt are old interfaces that have been
deprecated for, oh, at least 5 years now, and can't be implemented
sanely on machines with an IOMMU - which includes all 64-bit powerpc
machines.

Unless someone pops up and volunteers to fix those old drivers, which
is unlikely, the only solution is to fix the Kconfig files to prevent
them from being selected on platforms that don't have virt_to_bus and
bus_to_virt.

Paul.
