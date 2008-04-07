Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id E09FDDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Apr 2008 16:42:19 +1000 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id B2C36CFB3A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Apr 2008 12:11:27 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 91510CFB2Bfor
	<linuxppc-embedded@ozlabs.org>; Mon,  7 Apr 2008 12:11:27 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id m376nQ9Q007189for
	<linuxppc-embedded@ozlabs.org>; Mon, 7 Apr 2008 12:19:27 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-embedded@ozlabs.org
Subject: MVL Linux on MPC8560 Booting goes into infinite loop in early_init
	memset_io ( )
Date: Mon, 7 Apr 2008 13:19:26 +0630
Message-Id: <20080407064547.M56295@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

While booting MVL linux on MPC8560 based board the kernel goes into a infinite loop in
setup.c. The uncompressed image is located at 0x00000000 and is booted from 0x00000000

arch/ppc/kernel/head_fsl_booke.S
------------------------------------
bl early_init

arch/ppc/kernel/setup.c
----------------------------------------
unsigned long
early_init(int r3, int r4, int r5)
{
        unsigned long phys;
        unsigned long offset = reloc_offset();

        /* Default */
        phys = offset + KERNELBASE;

        /* First zero the BSS -- use memset, some arches don't have
         * caches on yet */
       
        memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);

        __bss_start is 0xc039b00 and __bss_stop = _end =c03c7d90  _end


        Please anyone give me some pointers to understand this i.e use of PTRRELOC and
REASON BEHIND clearing area from __bss_start to _end - __bss_start even though lot of
symbols and functions are defined here(as per System.map)

System.map
---------------------
c039b000 A __bss_start
c039b000 A __chrp_begin
c039b000 A __chrp_end
c039b000 A __init_end
c039b000 A __openfirmware_begin
c039b000 A __openfirmware_end
c039b000 A __pmac_begin
c039b000 A __pmac_end
c039b000 A __prep_begin
c039b000 A __prep_end
c039b000 B system_state
c039b004 B late_time_init
c039b008 b execute_command
c039b00c b panic_later
c039b010 b panic_param
c039b014 B Version_132618
.....
.....

c03c4458 B ic_nameservers
c03c4464 B unix_socket_table
c03c4464 B unix_table_lock
c03c4868 b auth_domain_table
c03c4868 b authtab_lock
c03c4868 b packet_sklist_lock
c03c4868 b rpc_credcache_lock
c03c4868 b rpc_queue_lock
c03c4868 b rpc_sched_lock
c03c4968 b ip_table
c03c4d68 b pmap_lock
c03c4d68 b pmap_stats
c03c4d90 b cache_defer_hash
c03c4d90 b cache_defer_lock
c03c4d90 b cache_list_lock
c03c4d90 b queue_lock
c03c5d90 b write_buf
c03c7d90 A __bss_stop
c03c7d90 A _end

Thanks,

Deepak Gaur
