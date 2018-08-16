Return-Path: <mroos@ut.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500::47])
 by lists.ozlabs.org (Postfix) with ESMTP id 41rg1C2vDbzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 18:46:38 +1000 (AEST)
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
 by smtp2.it.da.ut.ee (Postfix) with ESMTP id D3F0C902C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 11:15:39 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
 by math.ut.ee (Postfix) with ESMTP id CA5A5220492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 11:15:37 +0300 (EEST)
Date: Thu, 16 Aug 2018 10:44:56 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: linux-powerpc@vger.kernel.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ptrace compile failure with gcc-8.2 on 32-bit powerpc
Message-ID: <alpine.LRH.2.21.1808161041350.16413@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
ReSent-Message-ID: <alpine.LRH.2.21.1808161115340.16413@math.ut.ee>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After upgrading my distro compiler to gcc-8.2, Linux fails to compile on=20
32-bit powerpc (tested with 4.17, 4.18 and v4.18-7873-gf91e654474d4).


  CC      arch/powerpc/kernel/ptrace.o
In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/rcupdate.h:44,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from arch/powerpc/kernel/ptrace.c:19:
In function =A1memcpy=A2,
    inlined from =A1user_regset_copyin=A2 at ./include/linux/regset.h:295=
:4,
    inlined from =A1vr_set=A2 at arch/powerpc/kernel/ptrace.c:619:9:
./include/linux/string.h:345:9: error: =A1__builtin_memcpy=A2 offset [-52=
7, -529] is out of the bounds [0, 16] of object =A1vrsave=A2 with type =A1=
union <anonymous>=A2 [-Werror=3Darray-bounds]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/ptrace.c: In function =A1vr_set=A2:
arch/powerpc/kernel/ptrace.c:614:5: note: =A1vrsave=A2 declared here
   } vrsave;
     ^~~~~~
In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/rcupdate.h:44,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from arch/powerpc/kernel/ptrace.c:19:
In function =A1memcpy=A2,
    inlined from =A1user_regset_copyout=A2 at ./include/linux/regset.h:27=
0:4,
    inlined from =A1vr_get=A2 at arch/powerpc/kernel/ptrace.c:572:9:
./include/linux/string.h:345:9: error: =A1__builtin_memcpy=A2 offset [-52=
7, -529] is out of the bounds [0, 16] of object =A1vrsave=A2 with type =A1=
union <anonymous>=A2 [-Werror=3Darray-bounds]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/ptrace.c: In function =A1vr_get=A2:
arch/powerpc/kernel/ptrace.c:567:5: note: =A1vrsave=A2 declared here
   } vrsave;
     ^~~~~~
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:311: arch/powerpc/kernel/ptrace.o] E=
rror 1


--=20
Meelis Roos (mroos@linux.ee)
