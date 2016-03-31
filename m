Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbYFQ2prZzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 05:39:06 +1100 (AEDT)
Message-ID: <56FD6A2C.2010506@iogearbox.net>
Date: Thu, 31 Mar 2016 20:19:24 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Alexei Starovoitov <ast@fb.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] samples/bpf: Use llc in PATH, rather than a hardcoded
 value
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <ba23d688b3550c3f22dd0dd6d5cb1233c2f34816.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD627D.5080405@fb.com>
In-Reply-To: <56FD627D.5080405@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/31/2016 07:46 PM, Alexei Starovoitov wrote:
> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
>> While at it, fix some typos in the comment.
>>
>> Cc: Alexei Starovoitov <ast@fb.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   samples/bpf/Makefile | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 502c9fc..88bc5a0 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -76,16 +76,13 @@ HOSTLOADLIBES_offwaketime += -lelf
>>   HOSTLOADLIBES_spintest += -lelf
>>   HOSTLOADLIBES_map_perf_test += -lelf -lrt
>>
>> -# point this to your LLVM backend with bpf support
>> -LLC=$(srctree)/tools/bpf/llvm/bld/Debug+Asserts/bin/llc
>> -
>> -# asm/sysreg.h inline assmbly used by it is incompatible with llvm.
>> -# But, ehere is not easy way to fix it, so just exclude it since it is
>> +# asm/sysreg.h - inline assembly used by it is incompatible with llvm.
>> +# But, there is no easy way to fix it, so just exclude it since it is
>>   # useless for BPF samples.
>>   $(obj)/%.o: $(src)/%.c
>>       clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
>>           -D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
>> -        -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
>> +        -O2 -emit-llvm -c $< -o -| llc -march=bpf -filetype=obj -o $@
>>       clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
>>           -D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
>> -        -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=asm -o $@.s
>> +        -O2 -emit-llvm -c $< -o -| llc -march=bpf -filetype=asm -o $@.s
>
> that was a workaround when clang/llvm didn't have bpf support.
> Now clang 3.7 and 3.8 have bpf built-in, so make sense to remove
> manual calls to llc completely.
> Just use 'clang -target bpf -O2 -D... -c $< -o $@'

+1, the clang part in that Makefile should also more correctly be called
with '-target bpf' as it turns out (despite llc with '-march=bpf' ...).
Better to use clang directly as suggested by Alexei.
