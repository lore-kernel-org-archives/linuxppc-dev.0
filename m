Return-Path: <prvs=3899432171=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qc8G651vxzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 04:56:45 +1100 (AEDT)
Subject: Re: [PATCH 2/4] samples/bpf: Use llc in PATH, rather than a hardcoded
 value
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Borkmann
 <daniel@iogearbox.net>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <ba23d688b3550c3f22dd0dd6d5cb1233c2f34816.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD627D.5080405@fb.com> <56FD6A2C.2010506@iogearbox.net>
 <20160401143751.GF17907@naverao1-tp.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FEB64B.1060500@fb.com>
Date: Fri, 1 Apr 2016 10:56:27 -0700
MIME-Version: 1.0
In-Reply-To: <20160401143751.GF17907@naverao1-tp.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/1/16 7:37 AM, Naveen N. Rao wrote:
> On 2016/03/31 08:19PM, Daniel Borkmann wrote:
>> On 03/31/2016 07:46 PM, Alexei Starovoitov wrote:
>>> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
>>>>       clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
>>>>           -D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
>>>> -        -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
>>>> +        -O2 -emit-llvm -c $< -o -| llc -march=bpf -filetype=obj -o $@
>>>>       clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
>>>>           -D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
>>>> -        -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=asm -o $@.s
>>>> +        -O2 -emit-llvm -c $< -o -| llc -march=bpf -filetype=asm -o $@.s
>>>
>>> that was a workaround when clang/llvm didn't have bpf support.
>>> Now clang 3.7 and 3.8 have bpf built-in, so make sense to remove
>>> manual calls to llc completely.
>>> Just use 'clang -target bpf -O2 -D... -c $< -o $@'
>>
>> +1, the clang part in that Makefile should also more correctly be called
>> with '-target bpf' as it turns out (despite llc with '-march=bpf' ...).
>> Better to use clang directly as suggested by Alexei.
>
> I'm likely missing something obvious, but I cannot get this to work.
> With this diff:
>
> 	 $(obj)/%.o: $(src)/%.c
> 		clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
> 			-D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
> 	-               -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
> 	-       clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
> 	-               -D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
> 	-               -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=asm -o $@.s
> 	+               -O2 -target bpf -c $< -o $@
>
> I see far too many errors thrown starting with:
> 	./arch/x86/include/asm/arch_hweight.h:31:10: error: invalid output constraint '=a' in asm
> 			     : "="REG_OUT (res)

ahh. yes. when processing kernel headers clang has to assume x86 style
inline asm, though all of these functions will be ignored.
I don't have a quick fix for this yet.
Let's go back to your original change $(LLC)->llc
