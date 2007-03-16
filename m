Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17915.7048.393811.714143@cargo.ozlabs.ibm.com>
Date: Sat, 17 Mar 2007 09:34:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
In-Reply-To: <200703161634.58444.yur@emcraft.com>
References: <200703161634.58444.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yuri Tikhonov writes:

>  The configuration option we had introduced changes the global PPC PAGE_SIZE 
> definition indeed. To let changing the PAGE_SIZE from the configuration menu 
> for the 44x processors only the following modification of the 
> arch/ppc/Kconfig file might make sense:
> 
>  - int "Page size (12=>4KB; 16=>64KB)"
> + int "Page size (12=>4KB; 16=>64KB)" if 44x
> 
>  For other than 44x processors the PPC_PAGE_SHIFT value will be unchangeable 
> from the configuration menu and set to default  value 12 ( PAGE_SIZE = 4 KB).

Your patch would still let users select a page shift of 13 or 15,
which won't work (and can't be made to work).

Paul.
