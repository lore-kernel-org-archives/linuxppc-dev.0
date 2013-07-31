Return-Path: <000001403506934c-ce0f08c9-240a-4464-84aa-f31664b86a74-000000@amazonses.com>
Received: from a9-74.smtp-out.amazonses.com (a9-74.smtp-out.amazonses.com
 [54.240.9.74]) by ozlabs.org (Postfix) with ESMTP id 1F91F2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 00:12:17 +1000 (EST)
Date: Wed, 31 Jul 2013 13:59:18 +0000
From: Christoph Lameter <cl@gentwo.org>
To: Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
In-Reply-To: <51F8F827.6020108@gmail.com>
Message-ID: <000001403506934c-ce0f08c9-240a-4464-84aa-f31664b86a74-000000@email.amazonses.com>
References: <51F8F827.6020108@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dedekind1@gmail.com, dwmw2@infradead.org, penberg@kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 31 Jul 2013, Wladislav Wiebe wrote:

> on a PPC 32-Bit board with a Linux Kernel v3.10.0 I see trouble with kmalloc_slab.
> Basically at system startup, something request a size of 8388608 b,
> but KMALLOC_MAX_SIZE has 4194304 b in our case. It points a WARNING at:

> ..
> NIP [c0099fec] kmalloc_slab+0x60/0xe8
> LR [c0099fd4] kmalloc_slab+0x48/0xe8
> Call Trace:
> [ccd3be60] [c0099fd4] kmalloc_slab+0x48/0xe8 (unreliable)
> [ccd3be70] [c00ae650] __kmalloc+0x20/0x1b4
> [ccd3be90] [c00d46f4] seq_read+0x2a4/0x540
> [ccd3bee0] [c00fe09c] proc_reg_read+0x5c/0x90
> [ccd3bef0] [c00b4e1c] vfs_read+0xa4/0x150
> [ccd3bf10] [c00b500c] SyS_read+0x4c/0x84
> [ccd3bf40] [c000be80] ret_from_syscall+0x0/0x3c
> ..
>
> Do you have any idea how I can analyze where these 8388608 b coming from?

It comes from the kmalloc in seq_read(). And 8M read from the proc
filesystem? Wow. Maybe switch the kmalloc to vmalloc()?
