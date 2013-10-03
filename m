Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 977B62C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 00:21:20 +1000 (EST)
Received: by mail-ie0-f175.google.com with SMTP id e14so5695372iej.34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Oct 2013 07:21:12 -0700 (PDT)
MIME-Version: 1.0
Sender: mohicks@gmail.com
Date: Thu, 3 Oct 2013 10:21:11 -0400
Message-ID: <CAJUS3Xn4tHKvDK8tzLw09+zsEAJHEScV2DbZhH9KkYL-5iCmUA@mail.gmail.com>
Subject: Perf not resolving all symbols, showing 0x7ffffxxx
From: Martin Hicks <mort@bork.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've been trying to track down a performance regression that started
leading up to the v3.6 kernel, and while doing this I've been
gathering perf data on v3.6-rc and comparing it to v3.11 perf reports
of the same workload.

With v3.6-rc kernels I get all symbols resolved like this:

# Events: 39K cpu-clock-msecs
#
# Overhead      Command           Shared Object
            Symbol
# ........  ...........  ......................
........................................
#
     9.69%         nfsd  [kernel.kallsyms]       [k] csum_partial
     5.64%         nfsd  [kernel.kallsyms]       [k] __do_softirq
     3.12%         nfsd  [sunrpc]                [k] svc_create
     2.38%         nfsd  [kernel.kallsyms]       [k] __queue_work
     1.91%         nfsd  [gianfar_driver]        [k] gfar_poll
     1.73%         nfsd  [kernel.kallsyms]       [k] memset
     1.54%         nfsd  [nfsd]                  [k] nfsd_vfs_read.isra.16
     1.40%  ksoftirqd/0  [kernel.kallsyms]       [k] finish_task_switch.isra.54
     1.30%         nfsd  [kernel.kallsyms]       [k] get_page_from_freelist
     1.21%         nfsd  [gianfar_driver]        [k] gfar_start_xmit
     1.20%         nfsd  [sunrpc]                [k] svc_xprt_received


But when I perf on v3.11 kernels I see a lot of unresolved symbols:

# Events: 69K cpu-clock-msecs
#
# Overhead       Command          Shared Object
       Symbol
# ........  ............  .....................
...................................
#
    73.80%          nfsd  [unknown]              [k] 0x7ffff7fa
     7.57%          nfsd  [kernel.kallsyms]      [k] csum_partial
     4.59%   kworker/0:1  [unknown]              [k] 0x7ffff832
     3.76%   ksoftirqd/0  [unknown]              [k] 0x7ffff96e
     0.94%       kswapd0  [unknown]              [k] 0x7ffffcc2
     0.92%       swapper  [unknown]              [k] 0x7ffffa54
     0.62%          nfsd  [kernel.kallsyms]      [k] __udp4_lib_lookup
     0.49%          nfsd  [kernel.kallsyms]      [k] ip_append_page
     0.48%          nfsd  [kernel.kallsyms]      [k] __do_softirq
     0.36%      eventmon  [unknown]              [k] 0x7ffff9c4
     0.32%          nfsd  [kernel.kallsyms]      [k] __getnstimeofday


Any ideas?  Have I overlooked some necessary kernel config change?
Does perf need some binary that I may not have installed on this
embedded platform?

Freescale mpc8379 (e300c4)
Gcc-4.7.2 uClibC built with ct-ng 1.18.0
binutils 2.22

Thanks,
mh

-- 
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
