Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17516.64514.854281.64425@cargo.ozlabs.ibm.com>
Date: Fri, 19 May 2006 08:58:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
In-Reply-To: <1147988040.2692.40.camel@basalt.austin.ibm.com>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard writes:

> This patch adds ifdefs mid-file, but some were already present anyways,
> and I don't see a better way.

It would look better as:

#ifdef CONFIG_PPC_MAPLE
/* PIBS Version 1.05.0000 04/26/2005 has an incorrect /ht/isa/ranges property.
 * The values are bad, and it doesn't even have the right number of cells. */
static void __init fixup_device_tree_maple(void)
{
	... etc ...
}
#else
#define fixup_device_tree_maple()
#endif

#if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
static void __init fixup_device_tree_pmac(void)
{
	... etc ...
}
#else
#define fixup_device_tree_pmac()
#endif

static void __init fixup_device_tree(void)
{
	fixup_device_tree_maple();
	fixup_device_tree_pmac();
}

Care to redo the patch?

Thanks,
Paul.
