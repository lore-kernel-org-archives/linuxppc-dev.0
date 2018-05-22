Return-Path: <jakub.kicinski@netronome.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r5x26FLMzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 05:55:50 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id h19-v6so15612748qkj.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:55:50 -0700 (PDT)
Date: Tue, 22 May 2018 12:55:44 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, Quentin Monnet
 <quentin.monnet@netronome.com>
Subject: Re: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
Message-ID: <20180522125544.541c68c8@cakuba>
In-Reply-To: <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
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

On Tue, 22 May 2018 22:46:13 +0530, Sandipan Das wrote:
> +		if (info.nr_jited_func_lens && info.jited_func_lens) {
> +			struct kernel_sym *sym = NULL;
> +			unsigned char *img = buf;
> +			__u64 *ksyms = NULL;
> +			__u32 *lens;
> +			__u32 i;
> +
> +			if (info.nr_jited_ksyms) {
> +				kernel_syms_load(&dd);
> +				ksyms = (__u64 *) info.jited_ksyms;
> +			}
> +
> +			lens = (__u32 *) info.jited_func_lens;
> +			for (i = 0; i < info.nr_jited_func_lens; i++) {
> +				if (ksyms) {
> +					sym = kernel_syms_search(&dd, ksyms[i]);
> +					if (sym)
> +						printf("%s:\n", sym->name);
> +					else
> +						printf("%016llx:\n", ksyms[i]);
> +				}
> +
> +				disasm_print_insn(img, lens[i], opcodes, name);
> +				img += lens[i];
> +				printf("\n");
> +			}
> +		} else {

The output doesn't seem to be JSON-compatible :(  We try to make sure
all bpftool command can produce valid JSON when run with -j (or -p)
switch.

Would it be possible to make each function a separate JSON object with
"name" and "insn" array?  Would that work?
