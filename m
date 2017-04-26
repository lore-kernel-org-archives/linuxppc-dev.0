Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCRGk6jzhzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 14:01:50 +1000 (AEST)
Date: Wed, 26 Apr 2017 14:01:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>
Subject: linux-next: manual merge of the tip tree with the powerpc tree
Message-ID: <20170426140150.324ed6df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  kernel/kprobes.c

between commits:

  49e0b4658fe6 ("kprobes: Convert kprobe_lookup_name() to a function")
  290e3070762a ("powerpc/kprobes: Fix handling of function offsets on ABIv2")

from the powerpc tree and commit:

  1d585e70905e ("trace/kprobes: Fix check for kretprobe offset within function entry")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc kernel/kprobes.c
index 406889889ce5,c7ea9960433a..000000000000
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@@ -1395,16 -1394,14 +1398,14 @@@ bool within_kprobe_blacklist(unsigned l
   * This returns encoded errors if it fails to look up symbol or invalid
   * combination of parameters.
   */
- static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
+ static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
+ 			const char *symbol_name, unsigned int offset)
  {
- 	kprobe_opcode_t *addr = p->addr;
- 
- 	if ((p->symbol_name && p->addr) ||
- 	    (!p->symbol_name && !p->addr))
+ 	if ((symbol_name && addr) || (!symbol_name && !addr))
  		goto invalid;
  
- 	if (p->symbol_name) {
- 		addr = kprobe_lookup_name(p->symbol_name, p->offset);
+ 	if (symbol_name) {
 -		kprobe_lookup_name(symbol_name, addr);
++		addr = kprobe_lookup_name(symbol_name, offset);
  		if (!addr)
  			return ERR_PTR(-ENOENT);
  	}
