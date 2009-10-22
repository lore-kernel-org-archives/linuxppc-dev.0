Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C3D5B7BB2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 19:49:36 +1100 (EST)
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate6.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n9M8n977524862
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2009 08:49:14 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9M8mxuC3203212
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2009 09:48:59 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9M8mxFS026463
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2009 09:48:59 +0100
Message-ID: <4AE01C7A.7010908@de.ibm.com>
Date: Thu, 22 Oct 2009 10:48:58 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Move ehea hcall definitions into hvcall.h
References: <20091021060621.GV4808@kryten>
In-Reply-To: <20091021060621.GV4808@kryten>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Klein <tklein@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> Move ehea hcall definitions into hvcall.h.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Thomas Klein <tklein@de.ibm.com>

> ---
> 
> Index: linux.trees.git/arch/powerpc/include/asm/hvcall.h
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/include/asm/hvcall.h	2009-10-19 17:59:42.000000000 +1100
> +++ linux.trees.git/arch/powerpc/include/asm/hvcall.h	2009-10-19 18:03:18.000000000 +1100
> @@ -212,6 +212,19 @@
>  #define H_QUERY_INT_STATE       0x1E4
>  #define H_POLL_PENDING		0x1D8
>  #define H_ILLAN_ATTRIBUTES	0x244
> +#define H_MODIFY_HEA_QP		0x250
> +#define H_QUERY_HEA_QP		0x254
> +#define H_QUERY_HEA		0x258
> +#define H_QUERY_HEA_PORT	0x25C
> +#define H_MODIFY_HEA_PORT	0x260
> +#define H_REG_BCMC		0x264
> +#define H_DEREG_BCMC		0x268
> +#define H_REGISTER_HEA_RPAGES	0x26C
> +#define H_DISABLE_AND_GET_HEA	0x270
> +#define H_GET_HEA_INFO		0x274
> +#define H_ALLOC_HEA_RESOURCE	0x278
> +#define H_ADD_CONN		0x284
> +#define H_DEL_CONN		0x288
>  #define H_JOIN			0x298
>  #define H_VASI_STATE            0x2A4
>  #define H_ENABLE_CRQ		0x2B0
> Index: linux.trees.git/drivers/net/ehea/ehea_phyp.h
> ===================================================================
> --- linux.trees.git.orig/drivers/net/ehea/ehea_phyp.h	2009-10-19 18:03:48.000000000 +1100
> +++ linux.trees.git/drivers/net/ehea/ehea_phyp.h	2009-10-19 18:03:56.000000000 +1100
> @@ -33,7 +33,6 @@
>  #include <asm/hvcall.h>
>  #include "ehea.h"
>  #include "ehea_hw.h"
> -#include "ehea_hcall.h"
> 
>  /* Some abbreviations used here:
>   *
> Index: linux.trees.git/drivers/net/ehea/ehea_hcall.h
> ===================================================================
> --- linux.trees.git.orig/drivers/net/ehea/ehea_hcall.h	2009-10-19 17:59:31.000000000 +1100
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,51 +0,0 @@
> -/*
> - *  linux/drivers/net/ehea/ehea_hcall.h
> - *
> - *  eHEA ethernet device driver for IBM eServer System p
> - *
> - *  (C) Copyright IBM Corp. 2006
> - *
> - *  Authors:
> - *       Christoph Raisch <raisch@de.ibm.com>
> - *       Jan-Bernd Themann <themann@de.ibm.com>
> - *       Thomas Klein <tklein@de.ibm.com>
> - *
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2, or (at your option)
> - * any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#ifndef __EHEA_HCALL_H__
> -#define __EHEA_HCALL_H__
> -
> -/**
> - * This file contains HCALL defines that are to be included in the appropriate
> - * kernel files later
> - */
> -
> -#define H_ALLOC_HEA_RESOURCE   0x278
> -#define H_MODIFY_HEA_QP        0x250
> -#define H_QUERY_HEA_QP         0x254
> -#define H_QUERY_HEA            0x258
> -#define H_QUERY_HEA_PORT       0x25C
> -#define H_MODIFY_HEA_PORT      0x260
> -#define H_REG_BCMC             0x264
> -#define H_DEREG_BCMC           0x268
> -#define H_REGISTER_HEA_RPAGES  0x26C
> -#define H_DISABLE_AND_GET_HEA  0x270
> -#define H_GET_HEA_INFO         0x274
> -#define H_ADD_CONN             0x284
> -#define H_DEL_CONN             0x288
> -
> -#endif	/* __EHEA_HCALL_H__ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
