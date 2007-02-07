Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C3FDDDE26
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:11:00 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17LAvZG031178
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 16:10:57 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l17LAvw1231872
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 16:10:57 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l17LAvwA011305
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 16:10:57 -0500
Subject: Program Check (700) in lpar.c:551     was: Re: patches in powerpc.git
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 15:10:51 -0600
Message-Id: <1170882651.6619.64.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-02 at 15:03 +1100, Paul Mackerras wrote:
>       [POWERPC] Make pSeries use the H_BULK_REMOVE hypervisor call


looks like this one ( f03e64f2ca6ee3d0b7824536b1940497701fe766 ) makes
my JS20 tip over.    I backed it just that patch and booted
successfully, but havnt done any more poking than that. 

console output follows:
-----------------------------------------------------
ppc64_pft_size                = 0x19
physicalMemorySize            = 0x7c000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
PPC64 nvram contains 16384 bytes
Zone PFN ranges:
  DMA             0 ->   507904
  Normal     507904 ->   507904
early_node_map[1] active PFN ranges
    0:        0 ->   507904
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 500960
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
freeing bootmem node 0
Memory: 1986112k/2031616k available (6436k kernel code, 45504k reserved,
1392k data, 535k bss, 256k init)
Mount-cache hash table entries: 256
Processor 1 found.
Brought up 2 CPUs    
------------[ cut here ]------------
kernel BUG
at /kernels/powerpc.git.test/arch/powerpc/platforms/pseries/lpar.c:551!
cpu 0x1: Vector: 700 (Program Check) at [c00000000264f280]
    pc: c000000000035744: .pSeries_lpar_flush_hash_range+0x12c/0x228
    lr: c000000000035738: .pSeries_lpar_flush_hash_range+0x120/0x228
    sp: c00000000264f500
   msr: 8000000000029032
  current = 0xc00000000ffdc810
  paca    = 0xc00000000066ce00
    pid   = 1, comm = swapper
kernel BUG
at /kernels/powerpc.git.test/arch/powerpc/platforms/pseries/lpar.c:551!
enter ? for help
[c00000000264f500] c0000000000357fc .pSeries_lpar_flush_hash_range
+0x1e4/0x228 (unreliable)
[c00000000264f620] c00000000002ce04 .flush_hash_range+0x50/0xb8
[c00000000264f6c0] c00000000002d948 .__flush_tlb_pending+0xec/0x114
[c00000000264f770] c0000000000a71ec .unmap_vm_area+0x1a8/0x270
[c00000000264f840] c0000000000a7314 .remove_vm_area+0x60/0xb8
[c00000000264f8d0] c0000000000a73bc .__vunmap+0x50/0x100
[c00000000264f960] c000000000048a0c .build_sched_domains+0xdd8/0x10a0
[c00000000264fd90] c000000000048d10 .arch_init_sched_domains+0x3c/0x54
[c00000000264fe30] c00000000061e938 .sched_init_smp+0x2c/0xe0
[c00000000264fec0] c000000000009310 .init+0x144/0x3b8
[c00000000264ff90] c0000000000253b8 .kernel_thread+0x4c/0x68
1:mon>                                                                       
1:mon> r
R00 = fffffffffffffffd   R16 = 4000000001c00000
R01 = c00000000264f500   R17 = c00000000056c708
R02 = c0000000007a5d50   R18 = 0000000000000000
R03 = 0000000000000001   R19 = c00000000264fe00
R04 = c000000002395018   R20 = 0000000000a00000
R05 = 000000000000002d   R21 = c0000000007d8000
R06 = 420000000004d7a0   R22 = 00000000000000c0
R07 = 000000000000002d   R23 = 0000000000000001
R08 = 420000000004d7b8   R24 = 0000000000000001
R09 = 0000f09b89af5000   R25 = 0000000000000000
R10 = 420000000004d7b0   R26 = 0000000000000000
R11 = 0000f09b89af5000   R27 = 0000000000000003
R12 = c00000000264f580   R28 = c00000000264f5b0
R13 = c00000000066ce00   R29 = 0000000000000030
R14 = fffffffffff81980   R30 = 4200000000000000
R15 = c00000000056dd20   R31 = c000000002393310
pc  = c000000000035744 .pSeries_lpar_flush_hash_range+0x12c/0x228
lr  = c000000000035738 .pSeries_lpar_flush_hash_range+0x120/0x228
msr = 8000000000029032   cr  = 24000022
ctr = 00000000000246fc   xer = 00000000200fffff   trap =  700
1:mon>                                                                            

-Will
