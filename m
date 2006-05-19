Return-Path: <hollis@penguinppc.org>
Received: from pop-siberian.atl.sa.earthlink.net
	(pop-siberian.atl.sa.earthlink.net [207.69.195.71])
	by ozlabs.org (Postfix) with ESMTP id BE95E67A73
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 12:25:50 +1000 (EST)
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
From: Hollis Blanchard <hollis@penguinppc.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17516.64514.854281.64425@cargo.ozlabs.ibm.com>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>
	<17516.64514.854281.64425@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 18 May 2006 21:25:36 -0500
Message-Id: <1148005536.26609.7.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-19 at 08:58 +1000, Paul Mackerras wrote:
> 
> It would look better as:
> 
> #ifdef CONFIG_PPC_MAPLE
> /* PIBS Version 1.05.0000 04/26/2005 has an incorrect /ht/isa/ranges property.
>  * The values are bad, and it doesn't even have the right number of cells. */
> static void __init fixup_device_tree_maple(void)
> {
> 	... etc ...
> }
> #else
> #define fixup_device_tree_maple()
> #endif
> 
> #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
> static void __init fixup_device_tree_pmac(void)
> {
> 	... etc ...
> }
> #else
> #define fixup_device_tree_pmac()
> #endif
> 
> static void __init fixup_device_tree(void)
> {
> 	fixup_device_tree_maple();
> 	fixup_device_tree_pmac();
> }
> 
> Care to redo the patch?

If you really think that looks better, sure. :)

-Hollis
