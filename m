Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 108B91A081F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:04:28 +1000 (AEST)
Message-ID: <1437037461.15828.2.camel@ellerman.id.au>
Subject: Re: BUG: perf error on syscalls for powerpc64.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 romeo.cane.ext@coriant.com, imunsie@au1.ibm.com, paulus@samba.org,
 benh@kernel.crashing.org
Date: Thu, 16 Jul 2015 19:04:21 +1000
In-Reply-To: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-16 at 13:57 +0800, Zumeng Chen wrote:
> Hi All,
> 
> 1028ccf5 did a change for sys_call_table from a pointer to an array of
> unsigned long, I think it's not proper, here is my reason:
> 
> sys_call_table defined as a label in assembler should be pointer array
> rather than an array as described in 1028ccf5. If we defined it as an
> array, then arch_syscall_addr will return the address of sys_call_table[],
> actually the content of sys_call_table[] is demanded by arch_syscall_addr.
> so 'perf list' will ignore all syscalls since find_syscall_meta will
> return null
> in init_ftrace_syscalls because of the wrong arch_syscall_addr.
> 
> Did I miss something, or Gcc compiler has done something newer ?

Hi Zumeng,

It works for me with the code as it is in mainline.

I don't quite follow your explanation, so if you're seeing a bug please send
some information about what you're actually seeing. And include the disassembly
of arch_syscall_addr() and your compiler version etc.

cheers
