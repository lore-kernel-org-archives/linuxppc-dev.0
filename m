Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nY146l0SzF28C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 02:05:28 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4IG4uWX088584
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 12:05:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j20pg4be2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 12:05:25 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 18 May 2018 17:05:20 +0100
Date: Fri, 18 May 2018 21:35:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf v2 2/6] bpf: powerpc64: add JIT support for
 multi-function programs
To: ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, Sandipan Das
 <sandipan@linux.vnet.ibm.com>
Cc: jakub.kicinski@netronome.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, netdev@vger.kernel.org
References: <20180518125039.6500-1-sandipan@linux.vnet.ibm.com>
 <20180518125039.6500-3-sandipan@linux.vnet.ibm.com>
 <c3b23da2-0781-a1ee-0d49-71e9efb52e66@iogearbox.net>
In-Reply-To: <c3b23da2-0781-a1ee-0d49-71e9efb52e66@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1526658936.9wk22hv49g.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Borkmann wrote:
> On 05/18/2018 02:50 PM, Sandipan Das wrote:
>> This adds support for bpf-to-bpf function calls in the powerpc64
>> JIT compiler. The JIT compiler converts the bpf call instructions
>> to native branch instructions. After a round of the usual passes,
>> the start addresses of the JITed images for the callee functions
>> are known. Finally, to fixup the branch target addresses, we need
>> to perform an extra pass.
>>=20
>> Because of the address range in which JITed images are allocated
>> on powerpc64, the offsets of the start addresses of these images
>> from __bpf_call_base are as large as 64 bits. So, for a function
>> call, we cannot use the imm field of the instruction to determine
>> the callee's address. Instead, we use the alternative method of
>> getting it from the list of function addresses in the auxillary
>> data of the caller by using the off field as an index.
>>=20
>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/net/bpf_jit_comp64.c | 79 ++++++++++++++++++++++++++++++++=
++-----
>>  1 file changed, 69 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_ji=
t_comp64.c
>> index 1bdb1aff0619..25939892d8f7 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>> @@ -256,7 +256,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struc=
t codegen_context *ctx, u32
>>  /* Assemble the body code between the prologue & epilogue */
>>  static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>>  			      struct codegen_context *ctx,
>> -			      u32 *addrs)
>> +			      u32 *addrs, bool extra_pass)
>>  {
>>  	const struct bpf_insn *insn =3D fp->insnsi;
>>  	int flen =3D fp->len;
>> @@ -712,11 +712,23 @@ static int bpf_jit_build_body(struct bpf_prog *fp,=
 u32 *image,
>>  			break;
>> =20
>>  		/*
>> -		 * Call kernel helper
>> +		 * Call kernel helper or bpf function
>>  		 */
>>  		case BPF_JMP | BPF_CALL:
>>  			ctx->seen |=3D SEEN_FUNC;
>> -			func =3D (u8 *) __bpf_call_base + imm;
>> +
>> +			/* bpf function call */
>> +			if (insn[i].src_reg =3D=3D BPF_PSEUDO_CALL && extra_pass)
>=20
> Perhaps it might make sense here for !extra_pass to set func to some dumm=
y
> address as otherwise the 'kernel helper call' branch used for this is a b=
it
> misleading in that sense. The PPC_LI64() used in bpf_jit_emit_func_call()
> optimizes the immediate addr, I presume the JIT can handle situations whe=
re
> in the final extra_pass the image needs to grow/shrink again (due to diff=
erent
> final address for the call)?

That's a good catch. We don't handle that -- we expect to get the size=20
right on first pass. We could probably have PPC_FUNC_ADDR() pad the=20
result with nops to make it a constant 5-instruction sequence.

>=20
>> +				if (fp->aux->func && off < fp->aux->func_cnt)
>> +					/* use the subprog id from the off
>> +					 * field to lookup the callee address
>> +					 */
>> +					func =3D (u8 *) fp->aux->func[off]->bpf_func;
>> +				else
>> +					return -EINVAL;
>> +			/* kernel helper call */
>> +			else
>> +				func =3D (u8 *) __bpf_call_base + imm;
>> =20
>>  			bpf_jit_emit_func_call(image, ctx, (u64)func);
>> =20
>> @@ -864,6 +876,14 @@ static int bpf_jit_build_body(struct bpf_prog *fp, =
u32 *image,
>>  	return 0;
>>  }
>> =20
>> +struct powerpc64_jit_data {
>> +	struct bpf_binary_header *header;
>> +	u32 *addrs;
>> +	u8 *image;
>> +	u32 proglen;
>> +	struct codegen_context ctx;
>> +};
>> +
>>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>>  {
>>  	u32 proglen;
>> @@ -871,6 +891,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog=
 *fp)
>>  	u8 *image =3D NULL;
>>  	u32 *code_base;
>>  	u32 *addrs;
>> +	struct powerpc64_jit_data *jit_data;
>>  	struct codegen_context cgctx;
>>  	int pass;
>>  	int flen;
>> @@ -878,6 +899,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog=
 *fp)
>>  	struct bpf_prog *org_fp =3D fp;
>>  	struct bpf_prog *tmp_fp;
>>  	bool bpf_blinded =3D false;
>> +	bool extra_pass =3D false;
>> =20
>>  	if (!fp->jit_requested)
>>  		return org_fp;
>> @@ -891,7 +913,28 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *fp)
>>  		fp =3D tmp_fp;
>>  	}
>> =20
>> +	jit_data =3D fp->aux->jit_data;
>> +	if (!jit_data) {
>> +		jit_data =3D kzalloc(sizeof(*jit_data), GFP_KERNEL);
>> +		if (!jit_data) {
>> +			fp =3D org_fp;
>> +			goto out;
>> +		}
>> +		fp->aux->jit_data =3D jit_data;
>> +	}
>> +
>>  	flen =3D fp->len;
>> +	addrs =3D jit_data->addrs;
>> +	if (addrs) {
>> +		cgctx =3D jit_data->ctx;
>> +		image =3D jit_data->image;
>> +		bpf_hdr =3D jit_data->header;
>> +		proglen =3D jit_data->proglen;
>> +		alloclen =3D proglen + FUNCTION_DESCR_SIZE;
>> +		extra_pass =3D true;
>> +		goto skip_init_ctx;
>> +	}
>> +
>>  	addrs =3D kzalloc((flen+1) * sizeof(*addrs), GFP_KERNEL);
>>  	if (addrs =3D=3D NULL) {
>>  		fp =3D org_fp;
>=20
> In this case of !addrs, we leak the just allocated jit_data here!
>=20
>> @@ -904,10 +947,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *fp)
>>  	cgctx.stack_size =3D round_up(fp->aux->stack_depth, 16);
>> =20
>>  	/* Scouting faux-generate pass 0 */
>> -	if (bpf_jit_build_body(fp, 0, &cgctx, addrs)) {
>> +	if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
>>  		/* We hit something illegal or unsupported. */
>>  		fp =3D org_fp;
>> -		goto out;
>> +		goto out_addrs;
>>  	}
>> =20
>>  	/*
>> @@ -925,9 +968,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *fp)
>>  			bpf_jit_fill_ill_insns);
>>  	if (!bpf_hdr) {
>>  		fp =3D org_fp;
>> -		goto out;
>> +		goto out_addrs;
>>  	}
>> =20
>> +skip_init_ctx:
>>  	code_base =3D (u32 *)(image + FUNCTION_DESCR_SIZE);
>> =20
>>  	/* Code generation passes 1-2 */
>> @@ -935,7 +979,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog=
 *fp)
>>  		/* Now build the prologue, body code & epilogue for real. */
>>  		cgctx.idx =3D 0;
>>  		bpf_jit_build_prologue(code_base, &cgctx);
>> -		bpf_jit_build_body(fp, code_base, &cgctx, addrs);
>> +		bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
>>  		bpf_jit_build_epilogue(code_base, &cgctx);
>> =20
>>  		if (bpf_jit_enable > 1)
>> @@ -956,15 +1000,30 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *fp)
>>  	((u64 *)image)[1] =3D local_paca->kernel_toc;
>>  #endif
>> =20
>> +	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE)=
);
>> +
>> +	if (!fp->is_func || extra_pass) {
>> +		bpf_jit_binary_lock_ro(bpf_hdr);
>=20
> powerpc doesn't implement set_memory_ro(). Generally this is not a proble=
m since
> set_memory_ro() defaults to 'return 0' in this case, but since the bpf_ji=
t_free()
> destructor is overridden here, there's no bpf_jit_binary_unlock_ro() and =
in case
> powerpc would get set_memory_*() support one day this will then crash in =
random
> places once the mem gets back to the allocator, thus hard to debug. Two o=
ptions:
> either you remove the bpf_jit_free() override or you remove the bpf_jit_b=
inary_lock_ro().

Yeah, we shouldn't be using the lock here.

Thanks,
Naveen

=
