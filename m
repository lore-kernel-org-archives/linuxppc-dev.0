Return-Path: <peri@aqua.aspd.pwr.wroc.pl>
Received: from aqua.aspd.pwr.wroc.pl (aqua.aspd.pwr.wroc.pl [156.17.17.24])
	by ozlabs.org (Postfix) with ESMTP id 9076B2BDC5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Sep 2004 23:08:05 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aqua.aspd.pwr.wroc.pl (Postfix) with ESMTP id B9F9797DE2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Sep 2004 14:43:02 +0200 (CEST)
Date: Thu, 23 Sep 2004 14:43:02 +0200 (CEST)
From: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
To: linuxppc-embedded@ozlabs.org
Message-ID: <Pine.LNX.4.21.0409231441330.30818-100000@aqua.aspd.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: 2.6.8.1 not booting on 405CR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

We already have 2.4.23 kernel working on our board using IBM 405CR
processor. Now we're trying to start 2.6.8.1. But we have some strange
problems.

We use assembler intruction resetting the processor to see what is
executing (our breakpoint mechanism :) ). No metter what crosstool we use
the execuiton stops in same function. Here's the call stack.

setup_arch() - arch/ppc/kernel/setup.c
  -> ocp_early_init() - arch/ppc/syslib/ocp.c
    -> ocp_add_one_device() - arch/ppc/syslib/ocp.c
      ->  alloc_bootmem MACRO calling __alloc_bootmem_core() -
mm/bootmem.c

We added our "breakpoint" so __alloc_bootmem_core() looks like:

/* ... */
160     eidx = bdata->node_low_pfn - (bdata->node_boot_start >>
PAGE_SHIFT);
161     asm ("mtspr 0x3f2, 12"); /* <-- our "breakpoint" */
162     offset = 0;
/* ... */
What is happening is that in working 2.4.23 kernel this code resets
processor, but in 2.6.8.1 it doesn't. This is very strange because the
assembler code generated in both is the same.

[root at localhost kernel]# powerpc-405-linux-gnu-objdump -S mm/bootmem.o
>
asm

for kernel 2.4.23:
eidx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
338:   80 dd 00 00     lwz     r6,0(r29)
33c:   81 3d 00 04     lwz     r9,4(r29)
340:   54 c0 a3 3e     rlwinm  r0,r6,20,12,31
344:   7c e0 48 50     subf    r7,r0,r9
       asm ("mtspr 0x3f2, 12");
348:   7d 92 fb a6     mtdbcr0 r12
       offset = 0;

and for kernel 2.6.8.1:
eidx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
22c:   80 bf 00 00     lwz     r5,0(r31)
230:   81 3f 00 04     lwz     r9,4(r31)
234:   54 a0 a3 3e     rlwinm  r0,r5,20,12,31
238:   7d 80 48 50     subf    r12,r0,r9
       asm ("mtspr 0x3f2, 12");
23c:   7d 92 fb a6     mtdbcr0 r12
       offset = 0;

As you can see only used registers differ.

We moved eidx = bdata->node_low_pfn ... to the local variables definition
section so it looks like:
unsigned long eidx = bdata->node_low_pfn - (bdata->node_boot_start >>
PAGE_SHIFT);
and now the reset works in 2.6.8.1 too. Why? But then we move our
breakpoint to:

181     preferred = ((preferred + align - 1) & ~(align - 1)) >>
PAGE_SHIFT;
182     preferred += offset;
183     areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
184     asm ("mtspr 0x3f2, 12");
185     incr = align >> PAGE_SHIFT ? : 1;

and it doesn't reset the processor. In 2.4.23 it does. We splitted 183
line into two and it resets then! But after we place reset instruction
after 185 line (incr = ...) it doesn't reset again! 

Anyone has any ideas? Anyone seen 2.6.8.1 kernel working on 405CR?
