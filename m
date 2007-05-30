Return-Path: <scottwood@freescale.com>
Message-ID: <465D9397.7000008@freescale.com>
Date: Wed, 30 May 2007 10:09:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Consolidate cuboot initialization code
References: <20070530020110.GC21955@localhost.localdomain>
In-Reply-To: <20070530020110.GC21955@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> +void cuboot_init(unsigned long r4, unsigned long r5,
> +		 unsigned long r6, unsigned long r7,
> +		 unsigned long end_of_ram);
> +
> +#define CUBOOT_INIT() \
> +	do { \
> +		memcpy(&bd, (bd_t *)r3, sizeof(bd)); \
> +		cuboot_init(r4, r5, r6, r7, bd.bi_memstart + bd.bi_memsize); \
> +	} while (0)

Is there any particular reason to not just do a direct call to 
cuboot_init, and move the memcpy and end-of-ram calculation there?  I'd 
rather avoid macros if possible.

Also, the "extern char _dtb_start[], _dtb_end[];" line in cuboot.c 
doesn't appear to be needed.

Other than that, it looks good.

-Scott
