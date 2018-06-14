Return-Path: <lkp@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415t6c4x2pzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 15:51:52 +1000 (AEST)
Date: Thu, 14 Jun 2018 13:51:40 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush
 miss problem with THP
Message-ID: <201806141310.bQbDyW9s%fengguang.wu@intel.com>
References: <20180614032256.5440-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <20180614032256.5440-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20180613]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64s-radix-Fix-MADV_-FREE-DONTNEED-TLB-flush-miss-problem-with-THP/20180614-114728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: microblaze-nommu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=microblaze 

All errors (new ones prefixed by >>):

   In file included from include/linux/mm.h:478,
                    from arch/microblaze/include/asm/io.h:17,
                    from include/linux/clocksource.h:21,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from include/linux/sched/isolation.h:6,
                    from kernel/sched/sched.h:17,
                    from kernel/sched/loadavg.c:9:
   include/linux/migrate.h: In function 'new_page_nodemask':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'NMI_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^~~~~~~~~
   include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
   include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^~~~~~~~~
   include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
   include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
--
   In file included from include/linux/mm.h:478,
                    from arch/microblaze/include/asm/io.h:17,
                    from include/linux/clocksource.h:21,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from include/linux/sched/isolation.h:6,
                    from kernel/sched/sched.h:17,
                    from kernel/sched/core.c:8:
   include/linux/migrate.h: In function 'new_page_nodemask':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'NMI_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^~~~~~~~~
   include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
   include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^~~~~~~~~
   include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
   include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:63,
                    from kernel/sched/core.c:8:
   kernel/sched/core.c: At top level:
   include/linux/syscalls.h:233:18: warning: 'sys_sched_rr_get_interval' alias between functions of incompatible types 'long int(pid_t,  struct timespec *)' {aka 'long int(int,  struct timespec *)'} and 'long int(long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:212:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/sched/core.c:5274:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:238:18: note: aliased declaration here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~~~~~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:212:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/sched/core.c:5274:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:18: warning: 'sys_sched_getaffinity' alias between functions of incompatible types 'long int(pid_t,  unsigned int,  long unsigned int *)' {aka 'long int(int,  unsigned int,  long unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/sched/core.c:4909:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:238:18: note: aliased declaration here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~~~~~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/sched/core.c:4909:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:18: warning: 'sys_sched_setaffinity' alias between functions of incompatible types 'long int(pid_t,  unsigned int,  long unsigned int *)' {aka 'long int(int,  unsigned int,  long unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/sched/core.c:4857:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:238:18: note: aliased declaration here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~~~~~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/sched/core.c:4857:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:18: warning: 'sys_sched_getattr' alias between functions of incompatible types 'long int(pid_t,  struct sched_attr *, unsigned int,  unsigned int)' {aka 'long int(int,  struct sched_attr *, unsigned int,  unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:214:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
--
   In file included from include/linux/mm.h:478,
                    from arch/microblaze/include/asm/io.h:17,
                    from include/linux/clocksource.h:21,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from include/linux/sched/isolation.h:6,
                    from kernel//sched/sched.h:17,
                    from kernel//sched/core.c:8:
   include/linux/migrate.h: In function 'new_page_nodemask':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'NMI_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^~~~~~~~~
   include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
   include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^~~~~~~~~
   include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
   include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   In file included from kernel//sched/sched.h:63,
                    from kernel//sched/core.c:8:
   kernel//sched/core.c: At top level:
   include/linux/syscalls.h:233:18: warning: 'sys_sched_rr_get_interval' alias between functions of incompatible types 'long int(pid_t,  struct timespec *)' {aka 'long int(int,  struct timespec *)'} and 'long int(long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:212:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel//sched/core.c:5274:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:238:18: note: aliased declaration here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~~~~~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:212:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel//sched/core.c:5274:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:18: warning: 'sys_sched_getaffinity' alias between functions of incompatible types 'long int(pid_t,  unsigned int,  long unsigned int *)' {aka 'long int(int,  unsigned int,  long unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel//sched/core.c:4909:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:238:18: note: aliased declaration here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~~~~~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel//sched/core.c:4909:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:18: warning: 'sys_sched_setaffinity' alias between functions of incompatible types 'long int(pid_t,  unsigned int,  long unsigned int *)' {aka 'long int(int,  unsigned int,  long unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel//sched/core.c:4857:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:238:18: note: aliased declaration here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~~~~~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel//sched/core.c:4857:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:18: warning: 'sys_sched_getattr' alias between functions of incompatible types 'long int(pid_t,  struct sched_attr *, unsigned int,  unsigned int)' {aka 'long int(int,  struct sched_attr *, unsigned int,  unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:214:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)

vim +82 include/linux/huge_mm.h

d8c37c48 Naoya Horiguchi  2012-03-21  81  
fde52796 Aneesh Kumar K.V 2013-06-05 @82  #define HPAGE_PMD_SHIFT PMD_SHIFT
fde52796 Aneesh Kumar K.V 2013-06-05  83  #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
fde52796 Aneesh Kumar K.V 2013-06-05  84  #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
71e3aac0 Andrea Arcangeli 2011-01-13  85  

:::::: The code at line 82 was first introduced by commit
:::::: fde52796d487b675cde55427e3347ff3e59f9a7f mm/THP: don't use HPAGE_SHIFT in transparent hugepage code

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGX/IVsAAy5jb25maWcAjDxtbyI5k9/3V6BZ6fQ80u0uL8mE6DQfjNsNXvotthtIvrSY
hNlFmyE5IHs79+uvyt2A3ZThRjNKcJXLdrneXczPP/3cYR/7t+/L/fp5+fr6o/PHarPaLver
l8639evqvzpR3sly0xGRNL8CcrLefPzz2/f18/bt6+vyf1edm197d792f9k+DzrT1Xazeu3w
t8239R8fQGT9tvnp5594nsVyXKWSq3yUsCfx5QcQakZ5UVYj+CmySLKss951Nm/7zm61/8lB
SKQxiWhwYHYDUnMt0mosMqEkr3QhsyTn0xP8Kc9EFaXsNHLAncyFHE/MOYCzRI4UMzBPJOyR
QNBlehrVhvGpUYyLSpdFkSuHJO4lEsU5QKqHap4rZ6OjUiaRkSkccWHYCI6q6xnAvZ87Y3sj
r8iUj/cTP0cqn4qsyrNKp4VDPZMGODWrmII9yFSaL4P+kZkq17rieVrIRHz59Mm5h3qsMkIb
4hbgMCyZCaVlnuE8YrhipclP+4hEzMrEVJNcm4ylsNq/Nm+b1b+Pc/WjnsmCO8ysB/AnN8lp
vMi1XFTpQylKQY+ephzPU2oBN0mchJUgyQfWwlV0dh9fdz92+9X3E2sPl403VYDQinM5QJCe
5HP/WqM8ZTIjpAaFQcxEZvRhabP+vtruqNUnT1UBs/JIcvdEWY4QGSXCPZUPJiETEPVKCV2h
hCnt4tidgIb9Zpa7vzp72FJnuXnp7PbL/a6zfH5++9js15s/Tnszkk+tSjLO8zIzMhs7Yqwj
ZBcXIGMAN2FINRu4RzNMT0GVzPneFC87+pxFsO5jBTCXCHwE9QHOUfKra2R3uj9kVRAsUdZ3
JFJO61/OR+xpXF1HCjFIhIzNl97dUUiVzMy00iwWbZxBW0Y0n4iolhTPQI5VXhaavnPQK12A
9aHBNUVUS0uDYsujjjWoaqEEB6MXecroQapZ32M2Wkdy0VEyhWkza4dURBl0XuUFiKJ8ElWc
K5R1+JGyjPuOoYWm4Rf6BJ6xYBlYIpnlkdDO5Rbx6UMtI6fPKVgpCeZCOYcfC5OCTFrqLEna
bDkNn3ht93GAEBuNJywD3W0bsFonnVErMa5cOtInkhgMtfL4NGIaGFTSa5ZGLE7T7ceqkA7B
IvdOJ8cZS+LI1RTYnjtgjZg7wKRj9Fk0k1ocuOAcKxXpiCklLZdPdzwRfFrkcGK0TwZORhxi
ipQeU4fYYaTyruY4ajmCAmrkzGdVEV+4INihiCKrA8cZBe91b86MUhPnFKvtt7ft9+XmedUR
f682YDIZGE+ORhNM+8lazdKabZU1md51o9tlBny5c+U6YSNPtJJyROt3klMeDucDw9VYHJyw
Tw2gsRLgHjWwHYQyT0nqacoK5HA+r8oMtVlCbPQkIhIZzGEsE/AGxH4mbCZAly0G5UlBKyqU
w0oLUzqRjJ3Hk2lrBAK6ihUSzubpBlN8Us0ZcBljiIIpEIJDwHISwzwqE/CEoO5WmVBKHN0b
18FXArcFwtv3lrX0J0xPnMtLMMAcQQg4ZyrSg9ZmwCPzfCIU3jxuGhnqTAYnChgijiWXiBLH
2rewsRWXM92uY0Kez375utxBmP5XLY3v2zcI2D1nfdhyhdjNFQlfaZQB+wdWwbOWqD86Rbxe
i3HuBushtM0cnRujbH2DU2YID06uwbQQ5lFzibSLa+iALz9GoT63zjDl+BIY9RFMEb2YUTKF
zYLwRNUUTQ1x4pGfgiSjiMWeDWrc40jT+3DgrfiV8LBGjJU0l/0wJkE0bxGDpxForaj1RQXR
5iMThCE38oKdy2ix3O7XmAN2zI/3lWMPYTED5gQvK5qh3/dEg4GHy0445LoMPOdljFzH12ik
csyu4Rim5BWclHEa4wDXUa5PGJ4wQFgcST0FkywCUguGdwEp5OjyHnSewEZ1tRh+vrJbMOUL
sFbiyrpJlF4hpMfXGAOOR129J11eu+spg+DwCo6Ir20Gk8vPwytIjjYErxNFPoW0kMtjEpl3
9POfq5ePV8/ry7yOv7M8d9PzZjQSzK51DuHxgysjhzz6MIHY0gElMBM3cGFWs+6XT8/f/vuY
nMMJwzt1gNPHkR/SHQCj+IFYEwMJy2Es1li7b41lbS5el3uMpzpv72g0HE5CHlCBMQRPmPFG
heyMaPVtvbEWZteBmZ1Thal7mjwVKhNJ7dRYFKkv3X/uu/WfA8oCI5eFU6DqVjFYh+Txy6e/
19v96p/bTxdQMZZItQJzrI06ecwAZsHT4v+JigGzSK6iRXJ2FWcyxzTnFNEE0OKivIgDZMDN
fvl092uv++vLp+betm/Pq90O+L8HM2/rB99Wy/3H1jP5EHCmBcpi5oXkh/FZnkCswxTtyxos
KrZ8qnrdrksRRvq3XboQ8lQNukEQ0OmSK3wBiBsWl2eebvQGn87E9mBNRnnuRFzNKKgbIL+9
rr7s9z/KpPufvd5tv9v91J5sIyQnNxAcQ5SDBjSZyDm/M4UBpgbBOPmyxtfatLoVTx3Uafnx
agew6FPr1PLlb0xwXjrPblX3cNjOcrvqfEAUeloZ8gVI9my6Dqo2aKkapPklSzDbE3DpgkPO
B1jdlrJqkARDKKqxOXlNediCxZDvwcJOtgsDFRYCMPmsvNjbBvSYkvrBmjfcTHWnQbgOd+mv
ootEmqowdopl+b39c8z9JITYBiaW2iUEUlQ1OVUdVooFFsdOipwJuKlC2GuspqmXNScCLpKB
mSVF+akAeaMhozKQvQmFy5yV4I4I47KoRiLjk5Sp6ZngiH9Wzx/75dfXlX0z6NiseO9I40hm
cWoqzZUsvGS0AeBV0fFlDU+l5lQlKVciKk/aMPrYdfK2FtaO+vShqdFqcvCQlPrAsyoQDtbm
0S8WSIGVfrhqmsswK9WSOAhCHkqpprpFr05yg9S0CVQGECjzWRBWKBmGMS1pMZnkpkhKi3Ve
RF6+rLAQArAV2or99u31tS5wv7+/bfc10olRFWcRCJSw7wOEKdqt/9jM0brgYvwNftFHQrXb
gfE/33Z7Z7HOy3b9dx2D+WvVd3WeoAAJsXl5f1tv2vvDtyZbmCIn7f5nvX/+8/rKlZ7DX2n4
xAhKgDNxfInIVvv/edv+BXb33JEUjE+Fpzf1CLh+RhVcMMb33kIwh2jjnrLahMpjF7HyjA5+
xhiBzhEtFLIUrONITjtxiwM5F76uXSACNkhqI3mg4g2nnopHYsMy81kki7qyy5mmbQsgHF2i
yksTOBqgFVkR3Iws5CXgGDMtkZYLEkc/ZmDE8qkMFPBrGjNDKytC47ykd41ANgnDhKa3Les1
McgIMLm5SPSORrFMtx43WxhlBg49CB4J0Z6LctoaMrw4DPv7LKMiLNcWQ7H5FQyEwhVBQJ7T
courw6+nAIrgyxGHlyPXexxyrAMcor6Pr+vnTz71NLoNlaXg9j+HLh/fkDEgbPvkM5xi8mgL
+aBbadGq0brIsUwuaEHEeUBkCvDshoapKFBKAxELVFzoanTSD6wwUjIaU1mxjebsDWvmvaPW
QySxWcKyatjt9x5IcCQ4zKb3l/B+qISU0Nez6N/SpFgR8OqTPLS8FELgvm9vgqbC5uX0sTi9
XgQBEUTqOb7w07yH22K2ikfX4AqRzWr/R3Nb46t4IOSELYPTnoa1Ny2SsNXMNL3kRNMnsQyy
O40EfRjESAaQEGjQkeoSVsbJIM+aowUmAo+V/+w2ekhaYUBnv9o1D+8e6WJqIEKlT8ZSxSKZ
04UtRk8KlHVZDDtVIQ2NqylPiQPOpRIJJjFurhKPUSx75/HiAbBZrV52nf1b5+uqs9pgEvFS
F3MYtwhOA1EzgjGCfYmBkUWTDp5WnEsYpW1RPJWBxwHk7T1tXziTMQ0QxaQK1eizmGZeocEE
hzo40PPGNCyZ156UYPtY5bCX+rXVN3JihhpElaTZY106qjFO9bS/1xDCR8dY9tR+tH5uhs8T
rLJ+25yIpHDf0L1hCFjNxOs3gqVNWsRU6AnXm0Usyd2SY6FqcrFUqS1f234NJ9mf2ycodwNi
AeHJcYK3+BHbRrSHPcaQ4+FjHrGl+hkUn1OcnNM5CyRpVaRkyE42CGKmAoFejYC9Vw0ZsLtp
PqNlwaIxiB35Adn2KFGicWg/guQeVpdcaDdXfrH37SUt8COzVRlKaoz/hGciu5XAwxxAgVNY
L7HldOqiEcctubv9AgDK4+OoR5apu3OSrRen9+V258hwCR866RuW6OtHerNdbnavdS0rWf7w
Cve4xiiZAsNaGxq1e3NiEzAnIYAMQlQcBclpHUe0OdFpcJLlYB5oHELg8ZED8p/aq53xU7H0
N5Wnv8Wvyx2ku3+u351E173EWLYv6XcBwVJILhEBZPPYW+fNBGIYUVBlSgcLmxNGDOKDuYzM
pOr5N9WC9i9Cb3wori97xFifGMsMuLyFOYewNNLn+oIQMG8spAwALo1MfHJwC206KtSzgeox
0oKoW6TL93esLjQXaH2svdHlM5bvXSNgt5Kjn1ogrzBluCBGk0cNSNfgoM2BQ5ccDEC5aB/R
sraaqSrLaaNqiScMjHx6dli9ev32C5ZnlusNxBOA2hg7qlBjCaX89rYXXCeCKD5OWCCotDLF
J0V/MO3f0ukaomht+rdhZdVJ6yQtNl6Cwr9LYGu4+siFs0LbevfXL/nmF46ScOb/fR7kfDwI
m5pMZOC2g/A20FJPiihSnf+of/Y7BYSV31ff37Y/QtdUTwhysJAXpQVyc0IGI+Mk7LnXrAEe
qMykCfREAxQL10YJ4RKoBFPJIw2a5qPfvQF8kaxD5tOYVA/e58ytkcDnNLItd+4uIVRQrYbM
Q+SCPUApNrvXCXHdG9XUbJx6oh0i5jdtJFQLS1YmCX6gM4sGCeuvWqOEymLQX9CR+QE5Yvz+
M/1Ad0ApU0HL+QEhab12ny+iRuF+GHuuK3C9GIYZ1Vjr88G6+e9L7zMFs0nMsHffdyKxCIw8
Jnw8mtH7AZtkL74ShrZLzQuuftSM06HkcQ9Xjqz04rx8ns1S4VTlz/mIcDI8AkDlJ0i1i1rv
nqmglEW3/dtFFRU5na5CPJ4+otoEqiYsMwF/iU0sMud00cTIOLXxPh3KcX0/6OubLu01RMaT
XJeQqUCGYSNvOmsvKpnQOTsrIn0PCS8LlDmkTvr33S5tkmtgn9YliA90rnRlAOk28FZ+wBlN
end3l1HsRu+7tGpPUv55cEuXxiLd+zykQaUeNfWYKtbs/mZIbwFtLPC2glBzUNVj9FZD3tF9
6jn77stJF/tt61i/e4oCAzHihauGgIb2adE6wekSYANPxJgFXlMajJQtPg/vLhK5H/AFHZQc
ERaLm4sYECZXw/tJITR9yXx01+ueqUr9NZfVP8tdR252++3Hd9sjvftzuYWYbI8ZGPKt8wox
WucFdH/9jr+6fDQYLtPagaVqhsF0cd55KDf71Su2A0FssV292m+z7fznwxMKZsJ1yHOAaS5j
YngGjuV89ERogq+RISBfbl+oZYL4b+/Hvhq9hxNAAL9Z/rFCHnb+xXOd/rtdqMH9HcmdrpBP
aPuCj+oVZNEL8j1XYxGziZlPrDuoEwDxAcfrV2YScg8IeULfRdH0KxZ4MXp7tEeKS93qy6sZ
J4To9Ab3N51/xevtag7//k0pZiyVwDolTbsBQhCpqVgKArFTFeU0dv6VjDyLQs8s1lfRuvZQ
2gb7cIHaiFCMzzi+XJCw2SIEgVla0HUFWA1+03mgUmlKmiKMVzPLEfs9w8DsWSheyZI01Ier
2g8v9aVibfZkSF58fYDcZr9df/1A7df1iz3bQsq7Xz1jt9R5KQP2hf1Hxr/dGfiHXFUDyIjd
S56BRxC0OTSPxSQnm0cdeixihRHeN/yaIdv+FEvyyzAugbHwxU6Y3qC3uDIpYVxJWGTifydE
gkWhSi3eVCP89mWIKjMZeCSozbPR1w6Rsif3CxoeyG8LT6Nhr9cLBrsFSsigf2U50LHMSEYv
qDg9jmKRe2VIZpLQa19Cx4MIoNUBISEm0vLl7q1UuaLKSVYL6xYbr7LCOPWVIYfiSOUsasn6
6IYOY0Y8xRJzoHcrW9A84iGhMXKcZ3Q8i8RCPRTaiLQdn7kTqbTWPzAyyjtvFmJpM4ezmXS/
B+6CJiLRfoLeDFWGFo0jmD76EUzfwQk8oyps7s7A4Xv7amsvMQXYKjPv+Xws8DsJR1tJO7kW
4Jxw5Fs+693KRFI9J+6s5rXqtFDSp8sPuswibNa4TE+kZSK8yuNI9K/uXTzxifQegOqRKis0
NriCYU7xraqtGQSlBfOa53U/8H47W5AtDg6pibehSdEjm5ndCSWbC0mKsC29eufrBdqmRbtp
2ocEMucx/WYK4zP6qVUuQlMAEFjkpnuFY3LYv114l/97emVKytRM+N/7TWdp6NFdT8f03vT0
8YqfSmEVluV+UTxZ3FSBx3+A3YZLFQDV84vgeH5lP5IrXySmejgMFMxrEJCla91T/TQc3pxl
HfSi+ZmqZbw//D1QJATgon8D0FC1ILu7GVyJkNJH5T9mwedeN3CTsWBJdoVgxiAKSj2azRDt
3PVwMOxfUV74VeVZngpSfzNarYeD+65vdPvT67eQzWQkPQ9gv5IQteKw84n51Dsz4Ochb9O0
s4psLP2vh0wgPgQJIBn1KPBRPpZX4uyHJB/7/5HGQ8IGi0Al+iEJRicPSUAIYLGFyKrgPLJj
0N0h5H0QcHkR1wNnd2BA8UmDJgoTwH0xekmVXnU9SmCI7jnTIeTPgRY/BJmcNnNq2Pt8f22x
TGimSalUkXc56nP35orwK+waUyQxzVLw/F6jqEYX0c4aiJlCPNAkZcK8rEfz+3530LtCTnr5
Any8DxglAPXur5zYfr0zhn+ecuhAjxGMYy8Lv5aB6lR7rBeF5CFHj7j3vV4gBEfgzTWbpXOO
zQYLOr3Wxpp773wmxe/WXr+6MvNtRlE8poIFeilAPAIvSJxpDaEtreOyvLwJIyal8QxePXJl
lj9DVrwAT81CZZeE/B+yHHoz31LDx0pNWl8a9aAQzsC1mEC160B2Lp9a3fX1SDW/DQnMEWFw
LRA9fpGmATWvVmjcEmk8iW9AbCHPbJ+PkSTAfsCgRe0xywtIG71EYs6rRTIOGdQ4imi5gOik
oO4Yg8Km5cpp5sDB+otgTpkTxzj+vwIytHqNI82IBYqKB8JVWi6qcRGIRz2sNJUQD14gN5Fa
QnxDs7mYPCZydDqZnsPIobUslbIDHy90XLDU9oXQRY+mRBNGMMPuYBEEAy/vwLtfgg/vLsGb
+kcQgUvOovD2mpQ5CI8YCMUF8lGB8V//Mvz/GLuy5sZtZf1XVHlKqu4klmRtD3mAuEgcczNB
bfPC0sjK2JWx5ZLtOpl/f7sBkOLSDbnqTHzE7yMIgkCjAfRyO7Xj40kbLztysPVU2zd8KZw0
hG7BlagtcbYbsWMpocQdgf5Nv+/wnG3OYmZhdRUHRZznqDWKFVarCTsD9XKWAXo7TGGCf8i9
9Xajc1lwpSbxOCg+1jfAiZgHc1iTb2n9DjdrQUIGDv/wNchiiQ7sDG4k7wJG/yDD/9o+EiwR
Z7NRRJ/8pCldSdnaH1ISBQ/dvrw9PRx7KzkvT3wU63h8MKbkiJSG9eJh//p+PHfPtDYtNa+0
Zi82LrUxjvTLVn6kVWkKyxs77fDT4tMJ6IhbkjULjepOVXWotn1LoOUWIAGVmz4MlMmgsf5H
t03G6i/NAhk1HVGIQi97KRTowZqTbdNMmH1ACqvWNRQoAxqQOX09Z/jfdm59OVOH1PTlxWrT
VFsJKKeG3uYJ/RJ+7/p5/oHOD2/HY+/9sWQRU+aGO96LtnjuQQtu6dI3xeuuyWTw8vrx3j3x
rc0C6ap7Arfcnx/+h266wV9JD29pVFpiGEuyBgsReaRNhfO4P+8POEIvhkClkMobs9aaWuGi
q+sMJsd8V/s82oyCvWgsswajcbPmIOfjJNbeCBl9Gh0n3xJuH6dYSHqdYeLF0q4ZoDPq+AKX
Cd1b37WM3oyN6/lp/7N7immqrqwQnfrZmgGmg9ENebEe7dEYXzeWYzWmjyKBqn6d5OgTZPpZ
Dbf8OmD2xAkkzoqV8ge4pdAMo5FGXkUh6w2rTxiljBtcnShkigEY1ljaVbK7uUrJ8sF0yqye
a7Qo2dJzoiGhS0QocoyX2ekP8enlCxYCV1THUBMhMZBNUSBnhuxqv06htjcNAVvHrNFogO0D
FaH6qP0WwxhVdC/WymxX+Csz4gwsHSdmFKCK0R8HcsJsDhqSOdv+movFte5hqNdogb8db5k9
bUMx6lUqrxYmMmZbSMNZSp/KGtiXYRGm157h4EYOxlp0gwWsZkLG6NqwVTw7JigGCHUT85Se
wlLQp3XkVPoRyw0Rw7Kpki43sGJrHCJkw9mYPk0VaYq2EN3RlTqRE4jegZieLsWisznvBZY7
8C+lKgoN1LbIhrqHu1aj6Xl64HSV16ARtXjgFPMEpqwg9pPmZR1utLH2w6tLIDMOrYi3whfU
EOM5ZyJ/V/WrtAI0l3trx+3oyQivfyJ4Bz4CdL3+aEhbOFb4mFGASnxrwSN3wjhtGBjNTlg8
mDIGwAqUjOczgmkQbOlOiGisTlnooYq4DORoNOObBfDxkJYoBp6NaSmH8DqgpyGDpVlC90sV
prv3HX0LjZvR78/wmX/+6h2fvx8fcEH2l2F9gekK/Y/+aH9wB7eo2E0sZLgeBipWbqDUbMhy
HVpTQ5oXeWu+sa21SXBSYky08TM74nots7sh/zFkENHhYxCsdk9NJCYQTS8w+QP0lx5me7Pg
ZYaX8fwoQnQRYauQi0QWHrFqSGDRcq49rfbp209igxUpMBSMt6v+iOgey5viVxQRLmzdBikt
mVrOVGljJ16mROilGqb9JctWx0O6aP+Grexc5BnhRoW3apWAni4R3gbqrz4LZR5v9oLbNTb2
XmzZl7HAUtiejiDqBtyBJOKJoyLrs3i6FZwHEMLl9hZLAO1sCmLthlFggLHFc1Sm0boBu/Dq
t118H6XF4r71YtWHTc+n99Ph9NN84c73hH/c3IkwuiOhUznvXICsPPTGgy2jAOJD2OEhU2b9
uWTsrdOU8JvO097h5+nwLxmtK0+L/mg61akJOvea7Q19IqCiP7JhZ2r7HPuHB+WoDaJKPfjt
z8Yjg9jJMzLYAfTPxskDrIjwWnPBjOO83ZNrBego/tVxhfY4fN6/vsL0pG4jJJi6b3K71Scn
9J4GUizDW+HuhovuomBc/fKon+Ofmz7dURSldPm3TjmambGDXeHLcEOvkxUazadjWChZCNBZ
yJwTCm1OW6g7qMoc/3uFHkQ1vXDTEXRCS8O7TJQuXRuxnXCxPy8ExsRUEWAen42YWdoQ/OnI
1iJ5GjiDafPj6R7ou93Xr4LNXWmYeT5lZKqpVVAEeJ7Xp3XckuRpFuOvpFiZ6wwH/a4fIErJ
K5WEgdNnVlxl6w/7M8a8oPYBaVVbE5zhcMq4iemXDGTCRP/RXTIT/VvGnW5DPzhNNrj6WTPx
HhWqQp1acEwPFdJz5nLD+UOg8W0kKAG5ERjDKKmFUCuvdNxUKiBONmKXrKj91Iqj1+Aq/ino
JpgmwSXLUqK100U2+/fD48Pph8XFXCZ+XhXDfyWK0Vzu11qguvVbEGTo/Wwtv4xIaSW5GzuO
DnnD7dZOgjVpNOnf9IuNy+jcsHa78eScJUReXIhBp4BSaJjUEFWzo/dZOzhl6ljrCCVTfmFV
ken5iPmiTh/vvcUJPubLqX1gYXpEmnmoBUD/KhbNkKTll5cYN1LKYN7a1JOUq8LcwWjwBB2B
rmj9+Pn+9M/Hy0FFerHEgPDdQjj5dHY7YtzRkCCHE2YroIQHtG4KSpqjpzDGJVfdL/LBdNL1
o2yS8Oiv8ENv63AxQCrWMnSYuDHIgfYazW6YuUMR3Nlo0o82tHKrHrNNBzdbXFzxb+2K2Q0z
bWIRCI8G7LKiRuGeUlHozZASHtNfpoKZ0BYa7jNe0ghHTh/NSa2vUHJs77AMxrcworHR6Nkg
d1RsXoeuKcJQfBrSSluYAszsRiHG7VRhzb6K+FvhRAln6I6cOy/iHo3wdJpGU0b/uuD8F1T4
mPExVy0stv3b0WRiI0wmY8vw04QpE7+lIsz4jqII01srYTq7sdZxOmNcwit8duX+Ga0kKzwf
D223e7E/6M8juv9539Bmn4v0A7c7VhRmATpULYKgO49gCPItR+ieTTwf3dhud0b5aGrB76Y3
fLNl8Sgf93lceo5daMvgdjLeXuFEI0a9Vejdbgr9m5dhaPpD6xrz7ejmyqQi8yi1oDvpcLlv
AM4x2NVwONoWuQQVihdwYTqcWQZHmE4nzALPPCaMLD1IhJFgjphSOe7fjBhfXQBH3Ipag8ya
TlVKESwyQxNmvNRRhEGfH5T43tAylinUMEZjXnCYp1haFwlT5kSgIsyYdqoR7PN0RbJNlkCC
qWJID4Z8E8IizdKfgYAuBPYOvwn7g8nQzgmj4cgiUnJnOJrO+AZbb6cWjURkwbckFtbGKjm2
ttpE01vLtArwsG9XOwzlykOGo5trpcxm9AI/8xarUORcXC609CpzJHfU98V5//r4dHjrnniu
FwIaqLYRaC6omLALlfqkZs7jEvYSwkl7v4uPh6dTzzlVSWz+6KSv1uTI7YVP38/786/eGdY8
Ty/HapPGP++fj73vH//8g7v+baslv5HLsYpfCq9NuQX58ypBzK/atTjJA3/XuOTAPz8Iw8yr
J9o1gJOkO3iK6ABBJBbePAwaZ8BYEoyEYBETabjrLBWzXZ/50qIWOHkQqgfkrQgY3aZ6LE+J
ifUYVjfIMsZoANA0oudCvBFzUg04x1QggBIdwlvSK2vVSDJnQQxqzZ/4AUH23T7rX4bfUjnU
cWgWrFksmNyy7xSJPEvYZ2bC9ZgpHNsj3/UH9NygUfZVafGIiFgLzmdyjqfPbOt4CXRRZgkE
+N0uoxchgA1dn22BdZK4SULPKQjn0/GAfZs8C1yP7y9c/H3VTdlCHZFFnGsOfux5VCy2+e2I
9J8BQvc8C98jyPIV4/qEvaT0G2UJc2gHvu8q62K59JgdTWyLVVLc9bloYOrbswGwEZUweJgV
EsLRpE+PezxjU2fYRei41HxyWe0mzBmxTFYxJZMxFlmydEDLAqkWekZGXkSrilWmH9i8WOVf
XTqNzdIVubGFd9SyCiKJimqD19PHX29Ph/1PHbqYkp9xkqoCt44X0Ps3iKod1TVnmqUYwl0w
HzvfpUz0ILxxFeI5NVfyhj4Ci5ilZ+RFmBKGy3KxKUKPyTMhHEyrFcxhrDBiLID/xsGci12a
5bC2CwWTEdaNhIkI1ZnqAJqv/Foyn0s/w8jdmIqXrvFq6wYy5dKrq3xi2siMsmNAGA9DvHjV
dARUlzkLmPKu1smmCcp4OJ/eTv+895a/Xo/nL+vej4/j2ztpWZqD5CZTQDsqnDYeht9RGZ5x
jzgVdXtPPMdPYpP9WT/j9Px8euk56pha6RFoR9+IXQ4FLaVL95JLgSCBRkMmdEGT1WcirjRI
TGicJomJoFgjOa7jTW7ohWSLxu0Q1WkS9Z+C8eauEdHcBP5ySSVqzLVDP3W5wVyepGmA/lby
9HE+ENG2VGp5HXC3caUTFBzmSQPJdHpDN3ckgnCedM8ms+Pz6f2IofQoKYlB9nMMcdiNRZq9
Pr/9IO9JI1mOGH4aaceY0wel8JzfpbaRS6Aro/Vb7+31eHj6p8qvUMl58fzz9AMuy5PTngLm
59P+4XB6prCnP6Mtdf3+Y/8TbmnfU6s1Gu90qrzFlOL/cTeZE7e1Q+/LpBFatvqZRwdm9bYY
ZI4T+AmTCzRgmj3O6TkFY82yGfk2hB9Mdq/joneNbLN7E42k1jFBVVVLzribzzWI84Z/fYBh
Lti66JSY8AM0tJCzdvajbk9Fhzz58V1bVTZO3ktTEN4TtrjDDQaYr3l/U7TiSbeiGEzjCI2K
mKOeOgvLY1kYUB7zGBWRG425SC3qaJzdTWbSFWWiOwuLl4fz6emh4Xwcu1nCZDh0mdQxGLG4
21WWGww+eEBfLnI2ZOw9lTstE8XOTxfM8o8x55IBs+qTYRBR9uM+ZujUnaUe+nCbDwq/4e9j
LhVbDOrJDeBh4dPdGbBbDsu8QHoZFM3gX3loy0MLXw44bJ5bHhcHoeVWf9C5s/okeA4dbEHJ
rLkxeltcCLSbUl/TgfiLVlaOsjjQCAvEg7hmvRGh91kOwrCN13oGxj3KdimTsNyX1e7RpZ/r
SwQ70IhKjNN4iujeUoH3q4SJ4oqeAb5ke4Kvsk7TmIlpXxDmJM7+8Nh0vfBlJyGuht0vmMAE
Q6hjx7/0+8twlMkM5BBXi5XrUzVwE/mXL/K/4pwrN5LA4Updw71sd8w7HU7L+bfjx8NJZdjt
DF9UYfTwrV/Ag5u84bWrLsMkFrqZR/UVzL9cL6Y0lKwphPiHGxEqpDD2Ux2UsXFnkol44fGj
ULgWzOcxT3V9Dl3yNwKkwh5wIsNS17mlOjax1hUzZbNmIqq3u/6txUUr+4KBWsk8LmL/fiXk
kut2FvGJUR237FiMLO2Y8th9vL21omOuK2XmkZc20Vdwn8dzi/mum42pTeCaqFNQQkYY0jRY
/XQelMqcOziCjr9mRQn3rqXBdHPklGCrGfD3etD6PWz/NnPSRajgVSY3JEByw+haAFJbYgvl
wpyie3ctCZvqra2f8NRm3aBi3d0yBPRasyZ7VnGWNhRofcUSP0Gl5GNa3wk4IHEFL3i4TxbW
P0koy0yvf//29HaaTkezL/1avjkkwGO8VCy84nZIb282SJNPkZjA/w3SlDFdapFohb1F+tTj
PlHxKePr2iLRezQt0mcqzhh3tUjM8GiSPtMEYyZlb5M0u06aDT9R0uwzH3g2/EQ7zW4/Uafp
hG8n0KWw7xf0WVKjmP7gM9UGFt8JhHSYKDP1uvD3lwy+ZUoG331KxvU24TtOyeC/dcngh1bJ
4D9g1R7XX4bZ92xQ+Ne5S4JpwSQxKGF6vwhhjPgHMy9zBl0yHA8zu1+hwDp7xRwWVqQsETl3
4F2RdlkQhlcetxDeVUrmecwRhmEE8F7cQUTFiVcBfSDTaL5rL5WvsruAyWeHnFXuN0axWoLc
Hc8vx5+9x/3hX52c2NygI5oE2b0fioWsTe/qrtfz08v7v8o17OH5+PaDOhPRIQDUNi+lHuuI
D3h0F3prL6xm20m18vCkRIHRYdzWtHaVi1Q/yPVaByzlGcMrLK++oGF7D5aYh3/fVLUP+vqZ
qrn2NkNXe6Li2lOi2IgsrkVXqW0WaDxayRwDuTu1uEU+6Pn6zr/7N4Paa8g8C1IQfhEomxG3
wSJcVbBgAmKsYlh4o2VfNE+Y9FJK/iab2JrSltSNlh6m1pXVC7XukZ6DOxW4WIxEKzV4+Yot
im7AJA533eKUn3yx8cQd6qOY6pZe3qBRAarnzSxhjaJw9etVqbiNX6B7/P7x40crF7dqHBVM
pp2NplU7JGLyYGbXFItJExCqMZsvRhWTzL9Ck1CNbdo0FHOipeFqEULLUB8Jj97Ma0dehKxu
ASViqZnMcVN7JTlrD81a091QgzEo/is0E2une23x9KEADDVG/pkKLVuJ4PR+DX7FXng6/Pvx
qsf0cv/yo+OAFCqnRSgp55Iga6hYrmIQe0LWBqyROBeoMG4vf/cHN00plApM+nchpoLOxMBy
i7UIV8205/d2lyN9G4ypdk5gCq+Kb4Dl61SXJYxwVzd7Y5mGl6FfMJmh9V2633ixq8WE5YPi
Y+88L6XsyfCDXkZo7/e316cX5U78f73nj/fjf0f4P8f3w59//vnHZbZSe7CqbDytrs1W9W2y
dbXXSlZNlYHvaKl4loNgz72tZxm35ui0O/SIO1uMzUaTYJgnG8yvbuGq6vJyyARPyBN02JEh
NPaVsrDdBPqle6HP5wBXT4VhlGMaRNb//fIepjC612B/UXoGXQhOEPCCMLNJz3M9l4gK1BZu
Wqja3jRgKmNke3CNIW0yXe2nB5wlpQl5kXloeBa0ckDqE2pnRU9OAOBU6PNNjoyr30WR2AZH
1LuXls0Y00vvzQyd8XOzCcyhugtMqnhozGi4pskKL8tUXMqvWlEgyVoa2zkhqGOxs8sTylFd
TZH+Kta6iGqKWmS6JrrIRLqkOe4uFjiufIW2C9Cqc6RCEMIc6CRZTT1EsCmiyncry7q8bbOe
5NvCxAiTnG+jaOFsISw30GY2glFpy9lQMxnHDIUVMhapXCaU+/EcRjGofyCP1elXnDTTQ5TX
RQw9Q8Ut1DcwcrOiY95iG1FPTpaXLFPcolc/O0QUojOLzqGXLaOWnWjrI8OyJc5lN5pFJJSo
5cLRlHEPcRxjMW3TL7yu5BQoOIxFpKKw6LwUvEpAW+TFHNNd87iKIguKRWGngeQCOcHjepYa
39qnC/VKS2/rriIu4jG+Myyl4oXVol3x7oCYM+fsiqBWlXTuIoXPgzxidtgVvloxBgkKzZZC
LnMcVpZ35ZLT6+9/x4QiVQ+XuG5KUvpsV9c/pV/OD0CBg5ejO3izjNL1wfI51HmlpaKdVXv7
c4ocBO2dt7N9yyhh3FS9iO1Oag0GS3hMuQ0iOlt1DtsvskOgfTO5LkaBr2yC7xZuY7mGv+l1
+lwy+zg6ybwlciKswjP8Lk0V1USOPXycn95/1bYzyop4zbQIOCxAdGA2M4BwsFAvZswPPLdz
P/wu3CX6TGQqdDojbj1nlQU5UCNPKksoGJeMZlZyrSC9LYHNryIdxlBT7PTY57VWjBYWjejW
bRo3TWB/Qw56xmgxQur6ei68vGc9M0Ub/fu33y7HwNCsVWRF5/zr9f3UO5zOx97p3Hs8/nxV
qX4bZAyBJtJabN3G5UH3uifcv5+Ji10qTHpOkC7rCk4b6d6Ecom82KVmdbuXyzWSWO3vdarO
1uQuTYnXx4iYg+b5un6GpA1aDOzSwtagnuNS21oG1SkCu61orlO1wS52tcDCDaTSvdSKjChl
4fcH02hFhY0xjHgVhp0mxYvdlsMT6/uVt/KIB6k/tJQtq3ydIlb5EiSLjdKW19rk7+P98fjy
/nRQab+9lwMOG4z+8b+n98eeeHs7HZ4U5O7f9w37cVN5h0kPZBrRDjtLAf8b3KRJuOsPmYgG
hiu9+4AKiFL1oqUI4mANH0Sb/Spz6ufTQ929sHzs3KG+g09PKyXM2PVVMG2qYio3Jx4YZnQo
bAOnUE0bvmU2EsoR7O02WVONMkHo3x6rdum8BZ3BppREOklQpyJXKrpuFar3GJ9+HN/eqSpk
zpDxna0zrhDy/o0b0GpY2TVZJbBsf6JTtsale9uVS+6IaCJQwpfCCwsuXEkpRyOX8y2sMRh7
gAtjwITovTCGTGiPcqwtBZWy7YLCE4i3BGDEeJxdGEzeXoMzHoClCFtk/Zn1AZu0VQPdw55e
HxvuFNXUTUl+uNqy7u8w4tU8sIx30FtviYLnKgWjvdc5AtOZMi6vFUfmVlmJhDFfPZd8bV/9
tYqUpfgmrNOQFKEU9r5Vyny7rGeyDlR4lnIuplVPYlyNDJxy++jVbGn9BPkmaX/J6lD0fHx7
097wHUXI83ETzVZw+I0+hDfw9Nba/cNv1rcGeEl47+xfHk7Pvfjj+fvx3FscX46VO3+340tM
u5fRfmvmJbO52Vhp60YKYSYRjbVEcpfSKfNrkOde5qEjSLoDlFIG1ZbQNXFfEaVRij9Fzpgj
jzYPFwmWiXVDtYi3LpaBHxeTGROOpUZ0nMxjXCT/v6+r6UEQhqH/SS9egaFZsmncRhQuxIMx
XjwA/n/bDbCDjus++BhleXvta22tUckczvpeiLq22mc3oKwKkF7vi0D179fnMXy70bG/4MxD
2CVsZ15GbOfj7uq6TBKIiSOQzpQoyyQcrxkLhv1bJlEO1iOsnKRhhLNeB1N2XnRcsgAAAKyI
TOQlgN5Efk+ct4kcila6quXIVw9KFs+w37G8WzxAyaLM6wMzNfSkfmg/JDO39H6CI/KE+xd6
kxfmA6eUzDehWXFg3jGrhHTTt4rCj73DaXuBGrglxorglknn3hsweQ6mZhbLpoIVeerIZCQH
CArLwUxKvWzy+dyD+ZB2oUk2EHtSgfggNMSVWOlZoehnbZoT+RpLAoxIYEAhko4IxKLcQRQW
6CiIp8MG6jTyLwfWllvmH5RPhujPwAAA

--sm4nu43k4a2Rpi4c--
