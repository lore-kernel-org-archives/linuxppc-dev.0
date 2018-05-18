Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nFXZ3PqpzF292
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 14:28:13 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4I4ObJr009086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 00:28:11 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j1pywsmpp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 00:28:11 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Fri, 18 May 2018 05:28:08 +0100
Subject: Re: [PATCH bpf 5/6] tools: bpftool: resolve calls without using imm
 field
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: netdev@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, ast@kernel.org, daniel@iogearbox.net
References: <20180517063548.6373-1-sandipan@linux.vnet.ibm.com>
 <20180517063548.6373-6-sandipan@linux.vnet.ibm.com>
 <20180517115104.7666ff60@cakuba>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 09:58:02 +0530
MIME-Version: 1.0
In-Reply-To: <20180517115104.7666ff60@cakuba>
Content-Type: text/plain; charset=utf-8
Message-Id: <586171cd-f920-7051-fcf1-b01f9be40675@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jakub,

On 05/18/2018 12:21 AM, Jakub Kicinski wrote:
> On Thu, 17 May 2018 12:05:47 +0530, Sandipan Das wrote:
>> Currently, we resolve the callee's address for a JITed function
>> call by using the imm field of the call instruction as an offset
>> from __bpf_call_base. If bpf_jit_kallsyms is enabled, we further
>> use this address to get the callee's kernel symbol's name.
>>
>> For some architectures, such as powerpc64, the imm field is not
>> large enough to hold this offset. So, instead of assigning this
>> offset to the imm field, the verifier now assigns the subprog
>> id. Also, a list of kernel symbol addresses for all the JITed
>> functions is provided in the program info. We now use the imm
>> field as an index for this list to lookup a callee's symbol's
>> address and resolve its name.
>>
>> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> 
> A few nit-picks below, thank you for the patch!
> 
>>  tools/bpf/bpftool/prog.c          | 31 +++++++++++++++++++++++++++++++
>>  tools/bpf/bpftool/xlated_dumper.c | 24 +++++++++++++++++-------
>>  tools/bpf/bpftool/xlated_dumper.h |  2 ++
>>  3 files changed, 50 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index 9bdfdf2d3fbe..ac2f62a97e84 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -430,6 +430,10 @@ static int do_dump(int argc, char **argv)
>>  	unsigned char *buf;
>>  	__u32 *member_len;
>>  	__u64 *member_ptr;
>> +	unsigned int nr_addrs;
>> +	unsigned long *addrs = NULL;
>> +	__u32 *ksyms_len;
>> +	__u64 *ksyms_ptr;
> 
> nit: please try to keep the variables ordered longest to shortest like
> we do in networking code (please do it in all functions).
> 
>>  	ssize_t n;
>>  	int err;
>>  	int fd;
>> @@ -437,6 +441,8 @@ static int do_dump(int argc, char **argv)
>>  	if (is_prefix(*argv, "jited")) {
>>  		member_len = &info.jited_prog_len;
>>  		member_ptr = &info.jited_prog_insns;
>> +		ksyms_len = &info.nr_jited_ksyms;
>> +		ksyms_ptr = &info.jited_ksyms;
>>  	} else if (is_prefix(*argv, "xlated")) {
>>  		member_len = &info.xlated_prog_len;
>>  		member_ptr = &info.xlated_prog_insns;
>> @@ -496,10 +502,23 @@ static int do_dump(int argc, char **argv)
>>  		return -1;
>>  	}
>>  
>> +	nr_addrs = *ksyms_len;
> 
> Here and ...
> 
>> +	if (nr_addrs) {
>> +		addrs = malloc(nr_addrs * sizeof(__u64));
>> +		if (!addrs) {
>> +			p_err("mem alloc failed");
>> +			free(buf);
>> +			close(fd);
>> +			return -1;
> 
> You can just jump to err_free here.
> 
>> +		}
>> +	}
>> +
>>  	memset(&info, 0, sizeof(info));
>>  
>>  	*member_ptr = ptr_to_u64(buf);
>>  	*member_len = buf_size;
>> +	*ksyms_ptr = ptr_to_u64(addrs);
>> +	*ksyms_len = nr_addrs;
> 
> ... here - this function is getting long, so maybe I'm not seeing
> something, but are ksyms_ptr and ksyms_len guaranteed to be initialized?
> 
>>  	err = bpf_obj_get_info_by_fd(fd, &info, &len);
>>  	close(fd);
>> @@ -513,6 +532,11 @@ static int do_dump(int argc, char **argv)
>>  		goto err_free;
>>  	}
>>  
>> +	if (*ksyms_len > nr_addrs) {
>> +		p_err("too many addresses returned");
>> +		goto err_free;
>> +	}
>> +
>>  	if ((member_len == &info.jited_prog_len &&
>>  	     info.jited_prog_insns == 0) ||
>>  	    (member_len == &info.xlated_prog_len &&
>> @@ -558,6 +582,9 @@ static int do_dump(int argc, char **argv)
>>  			dump_xlated_cfg(buf, *member_len);
>>  	} else {
>>  		kernel_syms_load(&dd);
>> +		dd.jited_ksyms = ksyms_ptr;
>> +		dd.nr_jited_ksyms = *ksyms_len;
>> +
>>  		if (json_output)
>>  			dump_xlated_json(&dd, buf, *member_len, opcodes);
>>  		else
>> @@ -566,10 +593,14 @@ static int do_dump(int argc, char **argv)
>>  	}
>>  
>>  	free(buf);
>> +	if (addrs)
>> +		free(addrs);
> 
> Free can deal with NULL pointers, no need for an if.
> 
>>  	return 0;
>>  
>>  err_free:
>>  	free(buf);
>> +	if (addrs)
>> +		free(addrs);
>>  	return -1;
>>  }
>>  
>> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
>> index 7a3173b76c16..dc8e4eca0387 100644
>> --- a/tools/bpf/bpftool/xlated_dumper.c
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -178,8 +178,12 @@ static const char *print_call_pcrel(struct dump_data *dd,
>>  		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>>  			 "%+d#%s", insn->off, sym->name);
>>  	else
> 
> else if (address)
> 
> saves us the indentation.
> 
>> -		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> -			 "%+d#0x%lx", insn->off, address);
>> +		if (address)
>> +			snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> +				 "%+d#0x%lx", insn->off, address);
>> +		else
>> +			snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> +				 "%+d", insn->off);
>>  	return dd->scratch_buff;
>>  }
>>  
>> @@ -200,14 +204,20 @@ static const char *print_call(void *private_data,
>>  			      const struct bpf_insn *insn)
>>  {
>>  	struct dump_data *dd = private_data;
>> -	unsigned long address = dd->address_call_base + insn->imm;
>> -	struct kernel_sym *sym;
>> +	unsigned long address = 0;
>> +	struct kernel_sym *sym = NULL;
>>  
> 
> Hm.  Quite a bit of churn.  Why not just add these three lines here:
> 
> if (insn->src_reg == BPF_PSEUDO_CALL && 
>     insn->imm < dd->nr_jited_ksyms)
> 	address = dd->jited_ksyms[insn->imm];
> 
>> -	sym = kernel_syms_search(dd, address);
>> -	if (insn->src_reg == BPF_PSEUDO_CALL)
>> +	if (insn->src_reg == BPF_PSEUDO_CALL) {
>> +		if (dd->nr_jited_ksyms) {
>> +			address = dd->jited_ksyms[insn->imm];
> 
> Perhaps it's paranoid, but it'd please do to bound check insn->imm
> against dd->nr_jited_ksyms.
> 
>> +			sym = kernel_syms_search(dd, address);
>> +		}
>>  		return print_call_pcrel(dd, sym, address, insn);
>> -	else
>> +	} else {
>> +		address = dd->address_call_base + insn->imm;
>> +		sym = kernel_syms_search(dd, address);
>>  		return print_call_helper(dd, sym, address);
>> +	}
>>  }
>>  
>>  static const char *print_imm(void *private_data,
> 
> 

Thank you for the suggestions. Will post out v2 with these changes.

- Sandipan
