Return-Path: <gaur.deepak@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id 186A4DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Apr 2008 16:37:16 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so1274963wri.3
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 06 Apr 2008 23:37:14 -0700 (PDT)
Message-ID: <c1b44c9e0804062337q2144d651ic90d02fd84766366@mail.gmail.com>
Date: Mon, 7 Apr 2008 12:07:14 +0530
From: "Deepak Gaur" <gaur.deepak@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re:Boot freezes at memset_io in early_init
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11718_4592577.1207550234373"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11718_4592577.1207550234373
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

While booting MVL linux on MPC8560 based board the kernel goes into a
infinite loop in setup.c

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


        Please anyone give me some pointers to understand this i.e use of
PTRRELOC and REASON BEHIND clearing area from __bss_start to _end -
__bss_start even though lot of symbols and functions are defined here(as per
System.map)

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

------=_Part_11718_4592577.1207550234373
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>While booting MVL linux on MPC8560 based board the kernel goes into a infinite loop in setup.c<br><br>arch/ppc/kernel/head_fsl_booke.S<br>------------------------------------<br>bl early_init<br><br>arch/ppc/kernel/setup.c<br>
----------------------------------------<br>unsigned long<br>early_init(int r3, int r4, int r5)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long phys;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long offset = reloc_offset();<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Default */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys = offset + KERNELBASE;<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First zero the BSS -- use memset, some arches don&#39;t have<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * caches on yet */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset_io(PTRRELOC(&amp;__bss_start), 0, _end - __bss_start);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __bss_start is 0xc039b00 and __bss_stop = _end =c03c7d90&nbsp; _end<br>
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please anyone give me some pointers to understand this i.e use of PTRRELOC and REASON BEHIND clearing area from __bss_start to _end - __bss_start even though lot of symbols and functions are defined here(as per System.map)<br>
<br>System.map<br>---------------------<br>c039b000 A __bss_start<br>c039b000 A __chrp_begin<br>c039b000 A __chrp_end<br>c039b000 A __init_end<br>c039b000 A __openfirmware_begin<br>c039b000 A __openfirmware_end<br>c039b000 A __pmac_begin<br>
c039b000 A __pmac_end<br>c039b000 A __prep_begin<br>c039b000 A __prep_end<br>c039b000 B system_state<br>c039b004 B late_time_init<br>c039b008 b execute_command<br>c039b00c b panic_later<br>c039b010 b panic_param<br>c039b014 B Version_132618<br>
.....<br>.....<br><br>c03c4458 B ic_nameservers<br>c03c4464 B unix_socket_table<br>c03c4464 B unix_table_lock<br>c03c4868 b auth_domain_table<br>c03c4868 b authtab_lock<br>c03c4868 b packet_sklist_lock<br>c03c4868 b rpc_credcache_lock<br>
c03c4868 b rpc_queue_lock<br>c03c4868 b rpc_sched_lock<br>c03c4968 b ip_table<br>c03c4d68 b pmap_lock<br>c03c4d68 b pmap_stats<br>c03c4d90 b cache_defer_hash<br>c03c4d90 b cache_defer_lock<br>c03c4d90 b cache_list_lock<br>
c03c4d90 b queue_lock<br>c03c5d90 b write_buf<br>c03c7d90 A __bss_stop<br>c03c7d90 A _end<br><br>Thanks,<br><br>Deepak Gaur

------=_Part_11718_4592577.1207550234373--
