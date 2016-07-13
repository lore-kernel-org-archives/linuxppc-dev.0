Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqLJ83gNTzDqFP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 00:07:35 +1000 (AEST)
Date: Wed, 13 Jul 2016 17:07:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: markos.chandras@imgtec.com, Matt Evans <matt@ozlabs.org>
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: [bug report] MIPS: net: Add BPF JIT
Message-ID: <20160713140711.GA8984@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Markos Chandras,

The patch c6610de353da: "MIPS: net: Add BPF JIT" from Apr 8, 2014,
leads to the following static checker warning:

	arch/mips/net/bpf_jit.c:1185 build_body()
	warn: potential off by one 'ctx->offsets[]' limit 'prog->len'

arch/mips/net/bpf_jit.c
   652  static int build_body(struct jit_ctx *ctx)
   653  {
   654          const struct bpf_prog *prog = ctx->skf;
   655          const struct sock_filter *inst;
   656          unsigned int i, off, condt;
   657          u32 k, b_off __maybe_unused;
   658          u8 (*sk_load_func)(unsigned long *skb, int offset);
   659  
   660          for (i = 0; i < prog->len; i++) {
   661                  u16 code;
   662  
   663                  inst = &(prog->insns[i]);
   664                  pr_debug("%s: code->0x%02x, jt->0x%x, jf->0x%x, k->0x%x\n",
   665                           __func__, inst->code, inst->jt, inst->jf, inst->k);
   666                  k = inst->k;
   667                  code = bpf_anc_helper(inst);
   668  
   669                  if (ctx->target == NULL)
   670                          ctx->offsets[i] = ctx->idx * 4;

We have this so we don't need the other assignment.

   671  
   672                  switch (code) {

[ snipped big switch statement ]

  1176                  default:
  1177                          pr_debug("%s: Unhandled opcode: 0x%02x\n", __FILE__,
  1178                                   inst->code);
  1179                          return -1;
  1180                  }
  1181          }
  1182  
  1183          /* compute offsets only during the first pass */
  1184          if (ctx->target == NULL)
  1185                  ctx->offsets[i] = ctx->idx * 4;

i is always one step beyond the end of the array here.

  1186  
  1187          return 0;
  1188  }

That arm and powerpc implementations have the same issue.

regards,
dan carpenter
