Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj6zZ5TqxzF1FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 07:18:33 +1100 (AEDT)
Subject: Re: [RFC][PATCH bpf v2 1/2] bpf: allow 64-bit offsets for bpf
 function calls
From: Daniel Borkmann <daniel@iogearbox.net>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@fb.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com
References: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
 <d39a3902-39bc-df56-71bf-0e6f9869ce14@iogearbox.net>
Message-ID: <ad895533-2f15-bfe4-671c-6d1a8c672bbd@iogearbox.net>
Date: Thu, 15 Feb 2018 21:18:18 +0100
MIME-Version: 1.0
In-Reply-To: <d39a3902-39bc-df56-71bf-0e6f9869ce14@iogearbox.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2018 05:25 PM, Daniel Borkmann wrote:
> On 02/13/2018 05:05 AM, Sandipan Das wrote:
>> The imm field of a bpf_insn is a signed 32-bit integer. For
>> JIT-ed bpf-to-bpf function calls, it stores the offset from
>> __bpf_call_base to the start of the callee function.
>>
>> For some architectures, such as powerpc64, it was found that
>> this offset may be as large as 64 bits because of which this
>> cannot be accomodated in the imm field without truncation.
>>
>> To resolve this, we additionally make aux->func within each
>> bpf_prog associated with the functions to point to the list
>> of all function addresses determined by the verifier.
>>
>> We keep the value assigned to the off field of the bpf_insn
>> as a way to index into aux->func and also set aux->func_cnt
>> so that this can be used for performing basic upper bound
>> checks for the off field.
>>
>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>> ---
>> v2: Make aux->func point to the list of functions determined
>>     by the verifier rather than allocating a separate callee
>>     list for each function.
> 
> Approach looks good to me; do you know whether s390x JIT would
> have similar requirement? I think one limitation that would still
> need to be addressed later with such approach would be regarding the
> xlated prog dump in bpftool, see 'BPF calls via JIT' in 7105e828c087
> ("bpf: allow for correlation of maps and helpers in dump"). Any
> ideas for this (potentially if we could use off + imm for calls,
> we'd get to 48 bits, but that seems still not be enough as you say)?

One other random thought, although I'm not sure how feasible this
is for ppc64 JIT to realize ... but idea would be to have something
like the below:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 29ca920..daa7258 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -512,6 +512,11 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	return ret;
 }

+void * __weak bpf_jit_image_alloc(unsigned long size)
+{
+	return module_alloc(size);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -525,7 +530,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	 * random section of illegal instructions.
 	 */
 	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
-	hdr = module_alloc(size);
+	hdr = bpf_jit_image_alloc(size);
 	if (hdr == NULL)
 		return NULL;

And ppc64 JIT could override bpf_jit_image_alloc() in a similar way
like some archs would override the module_alloc() helper through a
custom implementation, usually via __vmalloc_node_range(), so we
could perhaps fit the range for BPF JITed images in a way that they
could use the 32bit imm in the end? There are not that many progs
loaded typically, so the range could be a bit narrower in such case
anyway. (Not sure if this would work out though, but I thought to
bring it up.)

Thanks,
Daniel
