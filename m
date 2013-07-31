Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi [213.243.153.189])
 by ozlabs.org (Postfix) with ESMTP id 65D092C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 03:34:46 +1000 (EST)
Date: Wed, 31 Jul 2013 20:34:34 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
Message-ID: <20130731173434.GA27470@blackmetal.musicnaut.iki.fi>
References: <51F8F827.6020108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F8F827.6020108@gmail.com>
Cc: dedekind1@gmail.com, dwmw2@infradead.org, penberg@kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Jul 31, 2013 at 01:42:31PM +0200, Wladislav Wiebe wrote:
> DEBUG: xxx kmalloc_slab, requested 'size' = 8388608, KMALLOC_MAX_SIZE = 4194304
[...]
> [ccd3be60] [c0099fd4] kmalloc_slab+0x48/0xe8 (unreliable)
> [ccd3be70] [c00ae650] __kmalloc+0x20/0x1b4
> [ccd3be90] [c00d46f4] seq_read+0x2a4/0x540
> [ccd3bee0] [c00fe09c] proc_reg_read+0x5c/0x90
> [ccd3bef0] [c00b4e1c] vfs_read+0xa4/0x150
> [ccd3bf10] [c00b500c] SyS_read+0x4c/0x84
> [ccd3bf40] [c000be80] ret_from_syscall+0x0/0x3c

It seems some procfs file is trying to dump 8 MB at a single go. You
need to fix that to return data in smaller chunks. What file is it?

A.
