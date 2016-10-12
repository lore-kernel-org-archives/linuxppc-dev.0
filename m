Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sv8V82ZLxzDsrf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 20:59:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
 linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luto@amacapital.net, rostedt@goodmis.org,
 Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
 Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 08/11] powerpc/tracing: fix compat syscall handling
In-Reply-To: <1476182576-15247-9-git-send-email-marcin.nowakowski@imgtec.com>
References: <1476182576-15247-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1476182576-15247-9-git-send-email-marcin.nowakowski@imgtec.com>
Date: Wed, 12 Oct 2016 20:59:42 +1100
Message-ID: <87zim951m9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marcin Nowakowski <marcin.nowakowski@imgtec.com> writes:

> Adapt the code to make use of new syscall handling interface
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/include/asm/ftrace.h | 11 +++++++++++
>  arch/powerpc/kernel/ftrace.c      |  4 ++++

I went to test this and noticed the exit and enter events appear to be
reversed in time? (your series on top of 24532f768121)

  ls-4221  [003] ....    83.766113: compat_sys_rt_sigprocmask -> 0x2
  ls-4221  [003] ....    83.766137: compat_sys_rt_sigprocmask(how: 2, nset: 1010db30, oset: 0, sigsetsize: 8)
  ls-4221  [003] ....    83.766175: compat_sys_rt_sigaction -> 0x14
  ls-4221  [003] ....    83.766175: compat_sys_rt_sigaction(sig: 14, act: ffbd33c4, oact: ffbd3338, sigsetsize: 8)
  ls-4221  [003] ....    83.766177: compat_sys_rt_sigaction -> 0x15
  ls-4221  [003] ....    83.766177: compat_sys_rt_sigaction(sig: 15, act: ffbd33c4, oact: ffbd3338, sigsetsize: 8)
  ls-4221  [003] ....    83.766178: compat_sys_rt_sigaction -> 0x16
  ls-4221  [003] ....    83.766178: compat_sys_rt_sigaction(sig: 16, act: ffbd33d4, oact: ffbd3348, sigsetsize: 8)
  ls-4221  [003] ....    83.766179: sys_setpgid -> 0x107d
  ls-4221  [003] ....    83.766179: sys_setpgid(pid: 107d, pgid: 107d)
  ls-4221  [003] ....    83.766180: compat_sys_rt_sigprocmask -> 0x0
  ls-4221  [003] ....    83.766181: compat_sys_rt_sigprocmask(how: 0, nset: ffbd34b0, oset: ffbd3530, sigsetsize: 8)
  ls-4221  [003] ....    83.766186: compat_sys_ioctl -> 0xff
  ls-4221  [003] ....    83.766187: compat_sys_ioctl(fd: ff, cmd: 80047476, arg32: ffbd3488)
  ls-4221  [003] ....    83.766188: compat_sys_rt_sigprocmask -> 0x2
  ls-4221  [003] ....    83.766189: compat_sys_rt_sigprocmask(how: 2, nset: ffbd3530, oset: 0, sigsetsize: 8)
  ls-4221  [003] ....    83.766189: sys_close -> 0x4
  ls-4221  [003] ....    83.766190: sys_close(fd: 4)
  ls-4221  [003] ....    83.766191: sys_read -> 0x3
  ls-4221  [003] ....    83.766191: sys_read(fd: 3, buf: ffbd35dc, count: 1)
  ls-4221  [003] ....    83.766235: sys_close -> 0x3
  ls-4221  [003] ....    83.766235: sys_close(fd: 3)

cheers
