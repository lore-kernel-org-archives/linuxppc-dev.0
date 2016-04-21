Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKbh3pzjzDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:39:12 +1000 (AEST)
In-Reply-To: <1455944568-7231-4-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, acme@redhat.com,
 hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, dsahern@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [V11,3/4] tools/perf: Map the ID values with register names
Message-Id: <3qrKbh2Ft4z9t3q@ozlabs.org>
Date: Thu, 21 Apr 2016 23:39:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-20-02 at 05:02:47 UTC, Anju T wrote:
> Map ID values with corresponding register names. These names are then
> displayed when user issues perf record with the -I option
> followed by perf report/script with -D option.
> 
> To test this patchset,
> Eg:
> $ perf record -I ls   # record machine state at interrupt
> $ perf script -D      # read the perf.data file
> 
> Sample output obtained for this patch / output looks like as follows:
> 
> 496768515470 0x1988 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 4522/4522: 0xc0000000001e538c period: 1 addr: 0
> ... intr regs: mask 0x7ffffffffff ABI 64-bit
> .... r0    0xc0000000001e5e34
> .... r1    0xc000000fe733f9a0
> .... r2    0xc000000001523100
> .... r3    0xc000000ffaadeb60
> .... r4    0xc000000003456800
> .... r5    0x73a9b5e000
> .... r6    0x1e000000
> .... r7    0x0
> .... r8    0x0
> .... r9    0x0
> .... r10   0x1
> .... r11   0x0
> .... r12   0x24022822
> .... r13   0xc00000000feec180
> .... r14   0x0
> .... r15   0xc000001e4be18800
> .... r16   0x0
> .... r17   0xc000000ffaac5000
> .... r18   0xc000000fe733f8a0
> .... r19   0xc000000001523100
> .... r20   0xc00000000009fd1c
> .... r21   0xc000000fcaa69000
> .... r22   0xc0000000001e4968
> .... r23   0xc000000001523100
> .... r24   0xc000000fe733f850
> .... r25   0xc000000fcaa69000
> .... r26   0xc000000003b8fcf0
> .... r27   0xfffffffffffffead
> .... r28   0x0
> .... r29   0xc000000fcaa69000
> .... r30   0x1
> .... r31   0x0
> .... nip   0xc0000000001dd320
> .... msr   0x9000000000009032
> .... orig_r3 0xc0000000001e538c
> .... ctr   0xc00000000009d550
> .... link  0xc0000000001e5e34
> .... xer   0x0
> .... ccr   0x84022882
> .... softe 0x0
> .... trap  0xf01
> .... dar   0x0
> .... dsisr 0xf00040060000004
>  ... thread: :4522:4522
>  ...... dso: /root/.debug/.build-id/b0/ef11b1a1629e62ac9de75199117ee5ef9469e9
>            :4522  4522   496.768515:          1 cycles:  c0000000001e538c .perf_event_context_sched_in (/boot/vmlinux)
> 
> Signed-off-by: Anju T <anju@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dc642e8388b63a9a221903584b

cheers
