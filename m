Return-Path: <fengguang.wu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 77E441A05C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 07:03:23 +1100 (AEDT)
Date: Wed, 24 Feb 2016 02:38:51 +0800
From: kbuild test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: kbuild-all@01.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7] powerpc32: provide VIRT_CPU_ACCOUNTING
Message-ID: <201602240229.rczorCJa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
In-Reply-To: <20160223165943.050941A2400@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.5-rc5 next-20160223]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc32-provide-VIRT_CPU_ACCOUNTING/20160224-010322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/time.c: In function 'accumulate_stolen_time':
>> arch/powerpc/kernel/time.c:274:6: error: 'struct cpu_accounting_data' has no member named 'stolen_time'
     acct->stolen_time += ust + sst;
         ^
   arch/powerpc/kernel/time.c: In function 'calculate_stolen_time':
   arch/powerpc/kernel/time.c:289:16: error: 'struct cpu_accounting_data' has no member named 'stolen_time'
     stolen += acct->stolen_time;
                   ^
   arch/powerpc/kernel/time.c:290:6: error: 'struct cpu_accounting_data' has no member named 'stolen_time'
     acct->stolen_time = 0;
         ^
--
   arch/powerpc/xmon/xmon.c: In function 'dump_one_paca':
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'user_time'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2200:2: note: in expansion of macro 'DUMP'
     DUMP(p, user_time, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'user_time'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2200:2: note: in expansion of macro 'DUMP'
     DUMP(p, user_time, "llx");
     ^
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'system_time'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2201:2: note: in expansion of macro 'DUMP'
     DUMP(p, system_time, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'system_time'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2201:2: note: in expansion of macro 'DUMP'
     DUMP(p, system_time, "llx");
     ^
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'user_time_scaled'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2202:2: note: in expansion of macro 'DUMP'
     DUMP(p, user_time_scaled, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'user_time_scaled'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2202:2: note: in expansion of macro 'DUMP'
     DUMP(p, user_time_scaled, "llx");
     ^
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'starttime'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2203:2: note: in expansion of macro 'DUMP'
     DUMP(p, starttime, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'starttime'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2203:2: note: in expansion of macro 'DUMP'
     DUMP(p, starttime, "llx");
     ^
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'starttime_user'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2204:2: note: in expansion of macro 'DUMP'
     DUMP(p, starttime_user, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'starttime_user'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2204:2: note: in expansion of macro 'DUMP'
     DUMP(p, starttime_user, "llx");
     ^
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'startspurr'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2205:2: note: in expansion of macro 'DUMP'
     DUMP(p, startspurr, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'startspurr'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2205:2: note: in expansion of macro 'DUMP'
     DUMP(p, startspurr, "llx");
     ^
>> arch/powerpc/xmon/xmon.c:2130:63: error: 'struct paca_struct' has no member named 'utime_sspurr'
     printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                                  ^
   arch/powerpc/xmon/xmon.c:2206:2: note: in expansion of macro 'DUMP'
     DUMP(p, utime_sspurr, "llx");
     ^
   In file included from include/linux/compiler.h:56:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/capability.h:16,
                    from include/linux/capability.h:15,
                    from include/linux/sched.h:15,
                    from arch/powerpc/xmon/xmon.c:14:
   include/linux/compiler-gcc.h:158:2: error: 'struct paca_struct' has no member named 'utime_sspurr'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/xmon/xmon.c:2131:3: note: in expansion of macro 'offsetof'
      offsetof(struct paca_struct, name));
      ^
   arch/powerpc/xmon/xmon.c:2206:2: note: in expansion of macro 'DUMP'
     DUMP(p, utime_sspurr, "llx");
     ^

vim +274 arch/powerpc/kernel/time.c

   268		local_paca->soft_enabled = 0;
   269	
   270		sst = scan_dispatch_log(acct->starttime_user);
   271		ust = scan_dispatch_log(acct->starttime);
   272		acct->system_time -= sst;
   273		acct->user_time -= ust;
 > 274		acct->stolen_time += ust + sst;
   275	
   276		local_paca->soft_enabled = save_soft_enabled;
   277	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--9amGYk9869ThD9tj
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9amGYk9869ThD9tj--
