Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 48C19DE09D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:12:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Thu, 17 Jul 2008 10:12:50 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B34B71@ismail.innsys.innovsys.com>
In-Reply-To: <200807170032.36564.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807162345.26395.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B3499C@ismail.innsys.innovsys.com>
	<200807170032.36564.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Milton Miller" <miltonm@bga.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> If you can't get it to work, readprofile(1) is a much simpler
> tool, both in what it can do and what it requires you to do.

One thing that pops out is that handle_mm_fault uses twice as many ticks
in arch/powerpc.

Top 20 calls from readprofile
2.6.25 arch/ppc
305993 total                                      0.1295
 53301 __flush_dcache_icache                    832.8281
 25746 clear_pages                              919.5000
 19086 __copy_tofrom_user                        33.3671
 17198 get_page_from_freelist                    13.3525
 12741 _tlbia                                   353.9167
 12317 handle_mm_fault                            8.9774
  9669 handle_page_fault                         75.5391
  8037 do_page_fault                              9.5225
  6450 cpu_idle                                  25.1953
  5430 update_mmu_cache                          21.8952
  4663 copy_page                                 32.3819
  3712 __link_path_walk                           0.8452
  3302 find_vma                                  19.6548
  3241 __do_fault                                 2.6741
  3235 unmap_vmas                                 2.1741
  3184 lru_cache_add_active                      16.5833
  3076 __alloc_pages                              3.8450
  3062 find_lock_page                             9.8141
  2826 zone_watermark_ok                         16.0568
  2593 put_page                                   6.8237


2.6.25 arch/powerpc
 60982 cpu_idle                                 262.8534
 54601 __flush_dcache_icache_phys               650.0119
 25676 clear_pages                              917.0000
 24892 handle_mm_fault                            8.7772
 19478 __copy_tofrom_user                        34.0524
 18112 get_page_from_freelist                    12.3716
 13245 _tlbia                                   367.9167
 11976 do_page_fault                             10.3241
 10028 handle_page_fault                         78.3438
  6025 update_mmu_cache                          23.5352
  4650 page_address                              15.7095
  4097 copy_page                                 28.4514
  4031 __do_fault                                 1.9838
  3952 find_vma                                  27.4444
  3861 __link_path_walk                           0.9237
  3533 unmap_vmas                                 2.2590
  3400 lru_cache_add_active                      19.3182
  3317 find_lock_page                            11.0567
  3238 __alloc_pages                              4.5223
  2825 zone_watermark_ok                         16.8155
  2740 __d_lookup                                 5.8547
