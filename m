Return-Path: <hch@lst.de>
Date: Mon, 16 Oct 2006 10:17:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: New DCR access methods
Message-ID: <20061016081748.GA11677@lst.de>
References: <1160984698.22522.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160984698.22522.60.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2006 at 05:44:58PM +1000, Benjamin Herrenschmidt wrote:
> This patch adds new dcr_map/dcr_read/dcr_write accessors for DCRs that
> can be used by drivers to transparently address either native DCRs or
> memory mapped DCRs. The implementation for memory mapped DCRs is done
> after the binding being currently worked on for SLOF and the Axon
> chipset. This patch enables it for the cell native platform
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-cell/include/asm-powerpc/dcr.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-cell/include/asm-powerpc/dcr.h	2006-10-16 16:42:32.000000000 +1000
> @@ -0,0 +1,42 @@
> +/*
> + * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
> + *                    <benh@kernel.crashing.org>
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#ifndef _ASM_POWERPC_DCR_H
> +#define _ASM_POWERPC_DCR_H
> +#ifdef __KERNEL__
> +
> +#ifdef CONFIG_PPC_DCR_NATIVE
> +#include <asm/dcr-native.h>
> +#else
> +#include <asm/dcr-mmio.h>
> +#endif

Having this as a compile-time switch seems broken.  I thought the plan was
to support all different 64bit kernels with a single kernel binary?
