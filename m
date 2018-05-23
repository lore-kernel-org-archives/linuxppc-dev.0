Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rTVl6nlkzF0tr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 20:37:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NAYNwT165323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 06:37:48 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j557nmasm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 06:37:47 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Wed, 23 May 2018 11:37:45 +0100
Subject: Re: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
To: Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: ast@kernel.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 Quentin Monnet <quentin.monnet@netronome.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
 <20180522125544.541c68c8@cakuba>
 <2dabfa7f-15b8-236c-7724-33bc3da7e549@iogearbox.net>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Wed, 23 May 2018 16:07:40 +0530
MIME-Version: 1.0
In-Reply-To: <2dabfa7f-15b8-236c-7724-33bc3da7e549@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <7142939b-515e-50ac-bc0b-50444bf9cc97@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/23/2018 02:38 PM, Daniel Borkmann wrote:
> On 05/22/2018 09:55 PM, Jakub Kicinski wrote:
>> On Tue, 22 May 2018 22:46:13 +0530, Sandipan Das wrote:
>>> +		if (info.nr_jited_func_lens && info.jited_func_lens) {
>>> +			struct kernel_sym *sym = NULL;
>>> +			unsigned char *img = buf;
>>> +			__u64 *ksyms = NULL;
>>> +			__u32 *lens;
>>> +			__u32 i;
>>> +
>>> +			if (info.nr_jited_ksyms) {
>>> +				kernel_syms_load(&dd);
>>> +				ksyms = (__u64 *) info.jited_ksyms;
>>> +			}
>>> +
>>> +			lens = (__u32 *) info.jited_func_lens;
>>> +			for (i = 0; i < info.nr_jited_func_lens; i++) {
>>> +				if (ksyms) {
>>> +					sym = kernel_syms_search(&dd, ksyms[i]);
>>> +					if (sym)
>>> +						printf("%s:\n", sym->name);
>>> +					else
>>> +						printf("%016llx:\n", ksyms[i]);
>>> +				}
>>> +
>>> +				disasm_print_insn(img, lens[i], opcodes, name);
>>> +				img += lens[i];
>>> +				printf("\n");
>>> +			}
>>> +		} else {
>>
>> The output doesn't seem to be JSON-compatible :(  We try to make sure
>> all bpftool command can produce valid JSON when run with -j (or -p)
>> switch.
>>
>> Would it be possible to make each function a separate JSON object with
>> "name" and "insn" array?  Would that work?
> 
> Sandipan, could you take a look at this? Given there's json output today we
> should definitely try not to break it; presumably this would be one final
> respin of your series with this fixed.
> 
> 

Sure. With a few changes, I am able get JSON output like the following:

# echo 0 > /proc/sys/net/core/bpf_jit_kallsyms
# bpftool prog -p dump jited id 1

[{
        "name": "0xd00000000aa80000",
        "insns": [{
                "pc": "0x0",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x4",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x8",
                "operation": "mflr",
                "operands": ["r0"
                ]
            },{
                "pc": "0xc",
                "operation": "std",
                "operands": ["r0","16","(","r1",")"
                ]
            },{
                "pc": "0x10",
                "operation": "stdu",
                "operands": ["r1","-112","(","r1",")"
                ]
            },{
                ...
            }
        ]
    },{
        "name": "0xd00000000aae0000",
        "insns": [{
                "pc": "0x0",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x4",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x8",
                "operation": "mflr",
                "operands": ["r0"
                ]
            },{
                ...
            }
        ]
    }
]

# echo 1 > /proc/sys/net/core/bpf_jit_kallsyms
# bpftool prog -p dump jited id 1

[{
        "name": "bpf_prog_b811aab41a39ad3d_foo",
        "insns": [{
                "pc": "0x0",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x4",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x8",
                "operation": "mflr",
                "operands": ["r0"
                ]
            },{
                "pc": "0xc",
                "operation": "std",
                "operands": ["r0","16","(","r1",")"
                ]
            },{
                "pc": "0x10",
                "operation": "stdu",
                "operands": ["r1","-112","(","r1",")"
                ]
            },{
                ...
            }
        ]
    },{
        "name": "bpf_prog_196af774a3477707_F",
        "insns": [{
                "pc": "0x0",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x4",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x8",
                "operation": "mflr",
                "operands": ["r0"
                ]
            },{
                ...
            }
        ]
    }
]

If this is okay, I can send out the next revision with these changes.



Other than that, for powerpc64, there is a problem with the way the
binutils disassembler code (in "opcodes/ppc-dis.c") passes arguments
to the callback fprintf_json().

In fprintf_json(), we always expect the va_list elements to resolve
to strings (char *). But for powerpc64, the register or immediate
operands are always passed as integers. So, when the code attempts
to resolve these operands using va_arg(ap, char *), bpftool crashes.
For now, I am using a workaround based on vsnprintf() but this does
not get the semantics correct for memory operands. You can probably
see that for the store instructions in the JSON dump above this.

Daniel,

Would it be okay if I send out a fix for this in a different series?

- Sandipan
