Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id DF273DE0D7
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 15:50:24 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1442088yxb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 22:50:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243226023.24376.23.camel@pasglop>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop> <200905250243.15436.arnd@arndb.de>
	<1243226023.24376.23.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 24 May 2009 23:50:02 -0600
Message-ID: <fa686aa40905242250g2a627c32s2b4c2ed06abd5dc4@mail.gmail.com>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Albert Herranz <albert_herranz@yahoo.es>, Ilya Yanok <yanok@emcraft.com>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 10:33 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This is going to .30 if nobody hollers. I've done some testing here
> and it seems to be fine, but more eyes at this stage are much welcome.

Looks okay to me; but I'm not an expert in this area.  Boots fine on
Xilinx Virtex 440 and MPC5200.  One minor nit below.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +#ifdef CONFIG_PPC32
> + =A0 =A0 =A0 printk(KERN_INFO "Kernel virtual memory layout:\n");
> + =A0 =A0 =A0 printk(KERN_INFO " =A0* 0x%08lx..0x%08lx =A0: fixmap\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0FIXADDR_START, FIXADDR_TOP);
> +#ifdef CONFIG_HIGHMEM
> + =A0 =A0 =A0 printk(KERN_INFO " =A0* 0x%08lx..0x%08lx =A0: highmem PTEs\=
n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
> +#endif /* CONFIG_HIGHMEM */
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> + =A0 =A0 =A0 printk(KERN_INFO " =A0* 0x%08lx..0x%08lx =A0: consistent me=
m\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT=
_SIZE);
> +#endif /* CONFIG_NOT_COHERENT_CACHE */
> + =A0 =A0 =A0 printk(KERN_INFO " =A0* 0x%08lx..0x%08lx =A0: early ioremap=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0ioremap_bot, IOREMAP_TOP);
> + =A0 =A0 =A0 printk(KERN_INFO " =A0* 0x%08lx..0x%08lx =A0: vmalloc & ior=
emap\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0VMALLOC_START, VMALLOC_END);
> +#endif /* CONFIG_PPC32 */

NIT: pr_info().  Same goes for other printk's in this patch.

It would also be nice for comprehension if the file move and the
modification were separate commits.  As it is I had to generate the
diff manually, but I'm not concerned.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
