Return-Path: <rientjes@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BED6D1A05C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 08:06:13 +1100 (AEDT)
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 404CE140217
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 08:06:13 +1100 (AEDT)
Received: by mail-ie0-f169.google.com with SMTP id y20so10307943ier.14
 for <linuxppc-dev@ozlabs.org>; Mon, 01 Dec 2014 13:06:11 -0800 (PST)
Date: Mon, 1 Dec 2014 13:06:09 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] slab: Fix nodeid bounds check for non-contiguous node
 IDs
In-Reply-To: <20141201042844.GB11234@drongo>
Message-ID: <alpine.DEB.2.10.1412011305560.16984@chino.kir.corp.google.com>
References: <20141201042844.GB11234@drongo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 1 Dec 2014, Paul Mackerras wrote:

> The bounds check for nodeid in ____cache_alloc_node gives false
> positives on machines where the node IDs are not contiguous, leading
> to a panic at boot time.  For example, on a POWER8 machine the node
> IDs are typically 0, 1, 16 and 17.  This means that num_online_nodes()
> returns 4, so when ____cache_alloc_node is called with nodeid = 16 the
> VM_BUG_ON triggers, like this:
> 
> kernel BUG at /home/paulus/kernel/kvm/mm/slab.c:3079!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=1024 NUMA PowerNV
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc5-kvm+ #17
> task: c0000000013ba230 ti: c000000001494000 task.ti: c000000001494000
> NIP: c000000000264f6c LR: c000000000264f5c CTR: 0000000000000000
> REGS: c0000000014979a0 TRAP: 0700   Not tainted  (3.18.0-rc5-kvm+)
> MSR: 9000000002021032 <SF,HV,VEC,ME,IR,DR,RI>  CR: 28000448  XER: 20000000
> CFAR: c00000000047e978 SOFTE: 0
> GPR00: c000000000264f5c c000000001497c20 c000000001499d48 0000000000000004
> GPR04: 0000000000000100 0000000000000010 0000000000000068 ffffffffffffffff
> GPR08: 0000000000000000 0000000000000001 00000000082d0000 c000000000cca5a8
> GPR12: 0000000048000448 c00000000fda0000 000001003bd44ff0 0000000010020578
> GPR16: 000001003bd44ff8 000001003bd45000 0000000000000001 0000000000000000
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000010
> GPR24: c000000ffe000080 c000000000c824ec 0000000000000068 c000000ffe000080
> GPR28: 0000000000000010 c000000ffe000080 0000000000000010 0000000000000000
> NIP [c000000000264f6c] .____cache_alloc_node+0x6c/0x270
> LR [c000000000264f5c] .____cache_alloc_node+0x5c/0x270
> Call Trace:
> [c000000001497c20] [c000000000264f5c] .____cache_alloc_node+0x5c/0x270 (unreliable)
> [c000000001497cf0] [c00000000026552c] .kmem_cache_alloc_node_trace+0xdc/0x360
> [c000000001497dc0] [c000000000c824ec] .init_list+0x3c/0x128
> [c000000001497e50] [c000000000c827b4] .kmem_cache_init+0x1dc/0x258
> [c000000001497ef0] [c000000000c54090] .start_kernel+0x2a0/0x568
> [c000000001497f90] [c000000000008c6c] start_here_common+0x20/0xa8
> Instruction dump:
> 7c7d1b78 7c962378 4bda4e91 60000000 3c620004 38800100 386370d8 48219959
> 60000000 7f83e000 7d301026 5529effe <0b090000> 393c0010 79291f24 7d3d4a14
> 
> To fix this, we instead compare the nodeid with MAX_NUMNODES, and
> additionally make sure it isn't negative (since nodeid is an int).
> The check is there mainly to protect the array dereference in the
> get_node() call in the next line, and the array being dereferenced is
> of size MAX_NUMNODES.  If the nodeid is in range but invalid (for
> example if the node is off-line), the BUG_ON in the next line will
> catch that.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: David Rientjes <rientjes@google.com>
