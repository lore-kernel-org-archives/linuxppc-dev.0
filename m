Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C04492C007E
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2012 15:08:34 +1000 (EST)
Received: by pbbrp12 with SMTP id rp12so4261395pbb.15
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Aug 2012 22:08:33 -0700 (PDT)
Message-ID: <501F514C.2090909@ozlabs.ru>
Date: Mon, 06 Aug 2012 15:08:28 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org
Subject: how to implement platform specific per process parameter?
Content-Type: text/plain; charset=KOI8-R; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

There is a per core register on modern POWER processors (POWER6+) called 
"DSCR": The DSCR (aka Data Stream Control Register) is supported on some
server PowerPC chips and allow some control over the prefetch of data
streams.

Its "per process" support has been added by
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=efcac6589a277c10060e4be44b9455cf43838dc1
"powerpc: Per process DSCR + some fixes (try#4)"

The patch adds the DSCR value into "struct thread_struct" and 
saves/restores it when the context is switched. Also, there is some policy 
to initialize the register when a thread starts. So far so good.

Here is the problem.

Some customer(s) of this feature want an ability to change the DSCR value 
of the already running process. I.e. we need some kernel interface which 
would accept pid and the register value and change it.

There are 4 options:
1. [not a kernel interface] use ptrace to execute the register changing 
command inside the specified pid. The next context switch saves the new 
value in the thread_struct. Dirty hack.

2. Add a new syscall which would receive pid + register value and do the 
job. A bit too much.

3. Add some hook in /proc filesystem but so far there were no platform 
specific bits, right?

4. Implement a static node "/sys/devices/system/cpu/dscr_control". write() 
would parse the input stream, call scanf("%d %x", &pid, &dscr) and do the job.

What is the correct approach? Thanks.


-- 
Alexey
