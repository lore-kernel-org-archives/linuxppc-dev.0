Return-Path: <peri@aqua.aspd.pwr.wroc.pl>
Received: from aqua.aspd.pwr.wroc.pl (aqua.aspd.pwr.wroc.pl [156.17.17.24])
	by ozlabs.org (Postfix) with ESMTP id B33462BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 21:20:20 +1000 (EST)
Date: Wed, 29 Sep 2004 13:20:17 +0200 (CEST)
From: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20040928094327.B1532@home.com>
Message-ID: <Pine.LNX.4.21.0409291256250.3154-100000@aqua.aspd.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x on 405CR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



On Tue, 28 Sep 2004, Matt Porter wrote:

> > > then you're an interesting spot.  Can you trace it down to the exact
> > > failure in __alloc_bootmem_core?
> > I already did it. Can you please read
> > http://ozlabs.org/pipermail/linuxppc-dev/2004-September/000104.html? I
> > described there what weird things are happening in __alloc_bootmem_core.
> 
> I see. Can you move the reset instruction to isolate the offending
> instruction? 
>  
> BTW, it's not clear how you are guaranteeing that the processor has
> bit 2 or 3 asserted before the dbcr0 load. If you preloaded r12 out of
> the scope of the code fragments shown, it's clear that r12 is getting
> clobbered in the subf instruction of the 2.6.8.1 fragment.

My mistake. I thought I was putting immediate value 12 in DBCR0 using
asm("mtspr 0x3f2, 12") in C code, but it's putting the value hold in the
r12 register. I shoul read the manual correctly. So untill now we just had
luck if our processor reset!?

Look what I trie now.

static void * __init
    147 __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long
size,
    148                 unsigned long align, unsigned long goal)
    149 {
    150         unsigned long offset, remaining_size, areasize, preferred;
    151         unsigned long i, start = 0, incr;
    152         unsigned long eidx = bdata->node_low_pfn -
(bdata->node_boot_start >> PAGE_SHIFT);
    153         void *ret;
    154
    155         if(!size) {
    156                 printk("__alloc_bootmem_core(): zero-sized
request\n");
    157                 BUG();
    158         }
    159         BUG_ON(align & (align-1));
    160
    161         asm ("li 17, 12");		// <-- immediate value of 12 to r17 -
bit 2:3 set
    162         asm ("mtspr 0x3f2, 17");	// < write to DBCR0 what is in
DOESN'T reset!!!
r17
    163         asm ("mtspr 0x3f2, 12");	// resets, but I don't know what
is value of r12
 
asm code is:
23c:   3a 20 00 0c     li      r17,12
240:   7e 32 fb a6     mtdbcr0 r17
244:   7d 92 fb a6     mtdbcr0 r12

It is said in manual, that setting bits 2:3 in DBCR0 resets the
processor. In my code it doesn't. :)

> Is this a hobby project or a "for profit" project? If it's for profit,
> then consider investing in a JTAG emulator (like BDI2000)...it'll pay
> for itself many times over.

I'm a trainee in some firm. They use 2.4.23 now in their boxes. Porting
2.6.8.1 to their board is my project. I was told that they have some
hardware debbuger, but it doesn't work with virtual memory.

Piotr Perak
