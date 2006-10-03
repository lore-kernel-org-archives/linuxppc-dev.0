Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-127.roch.qwest.net [67.41.71.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4279E67BD4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 20:46:54 +1000 (EST)
Subject: Re: [PATCH] powerpc: Generic DCR access
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1159855478.5482.46.camel@localhost.localdomain>
References: <1159855478.5482.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 05:45:58 -0500
Message-Id: <1159872359.29427.2.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-03 at 16:04 +1000, Benjamin Herrenschmidt wrote:
> This defines new "generic" access functions for DCRs that can be used
> both on platforms with hardware DCR support (4xx processors) and
> platforms where the DCRs are memory mapped. The 4xx versions are
> implemented inline. The memory mapped versions will be implemented
> separately as platforms support for them gets added.
> 
> From: Shaun Wetzstein <shaun@us.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-cell/include/asm-powerpc/dcr.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-cell/include/asm-powerpc/dcr.h	2006-09-22 13:25:58.000000000 +1000
> @@ -0,0 +1,56 @@
> +/*
> + *   Copyright (c) International Business Machines Corp., 2006
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
> +#include <asm/of_device.h>
> +
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)

I think this should be #if defined(CONFIG_40x) ||  defined(CONFIG_44x).
Or even just #ifdef CONFIG_4xx.  CONFIG_BOOKE also gets set for things
like e500, but those don't have DCRs.

josh
