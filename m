Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rRWn6lclzF0xF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 19:08:37 +1000 (AEST)
Subject: Re: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
To: Jakub Kicinski <jakub.kicinski@netronome.com>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: ast@kernel.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 Quentin Monnet <quentin.monnet@netronome.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
 <20180522125544.541c68c8@cakuba>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2dabfa7f-15b8-236c-7724-33bc3da7e549@iogearbox.net>
Date: Wed, 23 May 2018 11:08:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180522125544.541c68c8@cakuba>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2018 09:55 PM, Jakub Kicinski wrote:
> On Tue, 22 May 2018 22:46:13 +0530, Sandipan Das wrote:
>> +		if (info.nr_jited_func_lens && info.jited_func_lens) {
>> +			struct kernel_sym *sym = NULL;
>> +			unsigned char *img = buf;
>> +			__u64 *ksyms = NULL;
>> +			__u32 *lens;
>> +			__u32 i;
>> +
>> +			if (info.nr_jited_ksyms) {
>> +				kernel_syms_load(&dd);
>> +				ksyms = (__u64 *) info.jited_ksyms;
>> +			}
>> +
>> +			lens = (__u32 *) info.jited_func_lens;
>> +			for (i = 0; i < info.nr_jited_func_lens; i++) {
>> +				if (ksyms) {
>> +					sym = kernel_syms_search(&dd, ksyms[i]);
>> +					if (sym)
>> +						printf("%s:\n", sym->name);
>> +					else
>> +						printf("%016llx:\n", ksyms[i]);
>> +				}
>> +
>> +				disasm_print_insn(img, lens[i], opcodes, name);
>> +				img += lens[i];
>> +				printf("\n");
>> +			}
>> +		} else {
> 
> The output doesn't seem to be JSON-compatible :(  We try to make sure
> all bpftool command can produce valid JSON when run with -j (or -p)
> switch.
> 
> Would it be possible to make each function a separate JSON object with
> "name" and "insn" array?  Would that work?

Sandipan, could you take a look at this? Given there's json output today we
should definitely try not to break it; presumably this would be one final
respin of your series with this fixed.

Thanks,
Daniel
