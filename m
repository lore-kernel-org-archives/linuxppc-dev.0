Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com
 [IPv6:2a00:1450:4010:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 694B02C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:44:20 +1000 (EST)
Received: by mail-lb0-f179.google.com with SMTP id w20so1072809lbh.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 11:44:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372036573.3944.115.camel@pasglop>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <F3E9F49F-9C68-4BCB-B2A0-507AB1B2F10F@gmail.com>
 <1372036573.3944.115.camel@pasglop>
Date: Tue, 25 Jun 2013 11:44:14 -0700
Message-ID: <CAN8Q1EdfM3KXks8WKkW1axiDsee5kftS-MeaM2BJUC3=GdShQg@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Peter LaDow <pladow@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: petela@gocougs.wsu.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 22, 2013 at 5:00 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Afaik e300 is slightly out of order, maybe it's missing a memory barrier
> somewhere.... One thing to try is to add some to the dma_map/unmap ops.

I went through the driver and added memory barriers to the
dma_map_page/dma_unmap_page and dma_alloc_coherent/dma_free_coherent
calls (wmb() calls after each, which resolves to a sync instruction).
I still get a kernel panic.

I did turn on DEBUG_PAGE_ALLOC to try and get more information, but
I'm not finding anything new.  However, with the SLAB debugging I do
find SLAB corruption, e.g.:

Slab corruption: fib6_nodes start=e900c7f8, len=32
Redzone: 0x9f911029d74e35b/0x30a706a6050806.
Last user: [<06040001>](0x6040001)
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff ff ff
Prev obj: start=e900c7c0, len=32
Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
Last user: [<  (null)>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
Next obj: start=e900c830, len=32
Redzone: 0x30a706a6050aca/0xc8be11029d74e35b.
Last user: [<  (null)>](0x0)
000: 0d aa 00 00 00 00 00 00 0a ca 0d 49 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 75 8b

Which is clearly corrupted with ethernet frames.  The only interface
connected is the e1000.  Eventually this corruption leads to a kernel
panic.

I'm completely confused on how this could happen. Given the M bit is
set for all pages (see below), and with memory barriers on the DMA
map/unmap and register operations, the only thing I can think of is
something in the IO sequencer (which was suggested in the link I gave
earlier).  Yet the patch mentioned is in place.

> Also audit the driver to ensure that it properly uses barriers when
> populating descriptors (and maybe compare to a more recent version of
> the driver upstream).

I've gone through the driver and didn't see anything missing.  And the
upstream (v3.10-rc5) driver is the same version (7.3.21-k8-NAPI).  And
I've used the latest from the e1000 release (8.0.35-NAPI), and I get
the same problem.

On Sun, Jun 23, 2013 at 6:16 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Also dbl check that the MMU is indeed mapping all these pages with the
> "M" bit.

The DBAT's have the M bit set (both have 0x12 in the DBATxL
registers)...sometimes.  Usually when I halt the CPU and dumps the
BAT's, all the IBAT's and DBAT's have zeros.  But occasionally I see
DBAT2 and DBAT3 with values and the M bit set.

I also dumped all the TLB entries, and every one of them has the M bit
set (see below).

TLB dump:

BDI>dtlb 0 63
IDX  V RC VSID   VPI        RPN      WIMG PP
  0: V 0C 000eee_e9a0000 -> 2e9a0000 --M- 00
  1: V 0C 000eee_f401000 -> 2f401000 --M- 00
  2: V 1C 000ccc_0502000 -> 00502000 --M- 00
  3: V 0C 000eee_f403000 -> 2f403000 --M- 00
  4: V 0C 000eee_c124000 -> 2c124000 --M- 00
  5: V 0C 000eee_f405000 -> 2f405000 --M- 00
  6: V 0C 000eee_e9e6000 -> 2e9e6000 --M- 00
  7: V 0C 33afd1_0427000 -> 005f8000 --M- 10
  8: V 0C 33afd1_0428000 -> 2ff63000 --M- 10
  9: V 0C 000ccc_0349000 -> 00349000 --M- 00
 10: V 1C 000ccc_03ca000 -> 003ca000 --M- 00
 11: V 1C 000ccc_03cb000 -> 003cb000 --M- 00
 12: V 0C 33afd1_040c000 -> 003b4000 --M- 11
 13: V 0C 000eee_f40d000 -> 2f40d000 --M- 00
 14: V 1C 000eee_fa8e000 -> 2fa8e000 --M- 00
 15: V 0- 33afd1_034f000 -> 2e6b1000 --M- 11
 16: V 0C 000eee_f470000 -> 2f470000 --M- 00
 17: V 0C 33afd1_0411000 -> 2fe54000 --M- 10
 18: V 0C 000eee_f4b2000 -> 2f4b2000 --M- 00
 19: V 1C 33eb14_8073000 -> 00462000 --M- 10
 20: V 0C 000ccc_02f4000 -> 002f4000 --M- 00
 21: V 0C 000eee_f415000 -> 2f415000 --M- 00
 22: V 1C 000ccc_03f6000 -> 003f6000 --M- 00
 23: V 0C 000ccc_02f7000 -> 002f7000 --M- 00
 24: V 1C 000ccc_03f8000 -> 003f8000 --M- 00
 25: V 0C 000ccc_03d9000 -> 003d9000 --M- 00
 26: V 1C 33b304_a31a000 -> 007f4000 --M- 10
 27: V 1C 000ccc_03fb000 -> 003fb000 --M- 00
 28: V 1C 000ccc_03fc000 -> 003fc000 --M- 00
 29: V 0C 000eee_f41d000 -> 2f41d000 --M- 00
 30: V 1C 000eee_e87e000 -> 2e87e000 --M- 00
 31: V 1C 33afd1_045f000 -> 2fe52000 --M- 10
 32: V 0C 000ccc_0000000 -> 00000000 --M- 00
 33: V 0C 000eee_e9a1000 -> 2e9a1000 --M- 00
 34: V 1C 33b304_8022000 -> 00f44000 --M- 10
 35: V 0C 000ccc_0503000 -> 00503000 --M- 00
 36: V 0C 33afd1_0744000 -> 2fe17000 --M- 10
 37: V 0C 000eee_c125000 -> 2c125000 --M- 00
 38: V 0C 33e7e1_0406000 -> 0078e000 --M- 11
 39: V 0C 000eee_e987000 -> 2e987000 --M- 00
 40: V 0C 000ccc_0008000 -> 00008000 --M- 00
 41: V 0C 000ccc_03c9000 -> 003c9000 --M- 00
 42: V 1C 33ba7b_f8ea000 -> 005f9000 --M- 10
 43: V 1C 33afd1_040b000 -> 2ffe0000 --M- 11
 44: V 0C 000ccc_03cc000 -> 003cc000 --M- 00
 45: V 0C 000eee_b68d000 -> 2b68d000 --M- 00
 46: V 1C 000eee_f40e000 -> 2f40e000 --M- 00
 47: V 0C 000eee_fa8f000 -> 2fa8f000 --M- 00
 48: V 0C 33afd1_0410000 -> 2fe4a000 --M- 10
 49: V 0C 000eee_f471000 -> 2f471000 --M- 00
 50: V 0C 000ccc_03f2000 -> 003f2000 --M- 00
 51: V 1C 000eee_f473000 -> 2f473000 --M- 00
 52: V 0C 000ccc_03f4000 -> 003f4000 --M- 00
 53: V 0C 000ccc_03f5000 -> 003f5000 --M- 00
 54: V 1C 000eee_f456000 -> 2f456000 --M- 00
 55: V 0C 000eee_d2f7000 -> 2d2f7000 --M- 00
 56: V 1C 000ccc_03d8000 -> 003d8000 --M- 00
 57: V 0C 000eee_e879000 -> 2e879000 --M- 00
 58: V 1C 000eee_f41a000 -> 2f41a000 --M- 00
 59: V 1C 000ccc_03db000 -> 003db000 --M- 00
 60: V 1C 000eee_f43c000 -> 2f43c000 --M- 00
 61: V 0C 000ccc_04fd000 -> 004fd000 --M- 00
 62: V 1C 000eee_f43e000 -> 2f43e000 --M- 00
 63: V 1C 000eee_e93f000 -> 2e93f000 --M- 00
