Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rYzD72tfzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 23:59:20 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NDoc51133066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 09:59:18 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j587fw13p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 09:59:17 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Wed, 23 May 2018 14:59:16 +0100
Subject: Re: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, ast@kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 Quentin Monnet <quentin.monnet@netronome.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
 <20180522125544.541c68c8@cakuba>
 <2dabfa7f-15b8-236c-7724-33bc3da7e549@iogearbox.net>
 <7142939b-515e-50ac-bc0b-50444bf9cc97@linux.vnet.ibm.com>
 <024d9f55-2382-8080-c0c2-e3acfbfb9590@iogearbox.net>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Wed, 23 May 2018 19:29:08 +0530
MIME-Version: 1.0
In-Reply-To: <024d9f55-2382-8080-c0c2-e3acfbfb9590@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <8dde9b25-fad5-7b94-7de6-a91b5db83415@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/23/2018 07:20 PM, Daniel Borkmann wrote:
> On 05/23/2018 12:37 PM, Sandipan Das wrote:
> [...]
>> Other than that, for powerpc64, there is a problem with the way the
>> binutils disassembler code (in "opcodes/ppc-dis.c") passes arguments
>> to the callback fprintf_json().
>>
>> In fprintf_json(), we always expect the va_list elements to resolve
>> to strings (char *). But for powerpc64, the register or immediate
>> operands are always passed as integers. So, when the code attempts
>> to resolve these operands using va_arg(ap, char *), bpftool crashes.
>> For now, I am using a workaround based on vsnprintf() but this does
>> not get the semantics correct for memory operands. You can probably
>> see that for the store instructions in the JSON dump above this.
>>
>> Daniel,
>>
>> Would it be okay if I send out a fix for this in a different series?
> 
> I'm fine either way with regards to the fix. Feels like a portability bug
> in the binutils disassembler?
> 
> We could probably have a feature test like in test-disassembler-four-args
> and select a workaround in bpftool based on that outcome.
> 
> Thanks Sandipan!
> 
>   [1] tools/build/feature/test-disassembler-four-args.c
> 

Cool. Thanks for the tip!

- Sandipan
