Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419431A0EC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 20:38:00 +1100 (AEDT)
Received: by mail-pa0-f42.google.com with SMTP id et14so3809195pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jan 2015 01:37:58 -0800 (PST)
Message-ID: <54ACFE6D.3070308@ozlabs.ru>
Date: Wed, 07 Jan 2015 20:37:49 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: offlining cpus breakage
Content-Type: text/plain; charset=koi8-r
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

"ppc64_cpu --smt=off" produces multiple error on the latest upstream kernel
(sha1 bdec419):

NMI watchdog: BUG: soft lockup - CPU#20 stuck for 23s! [swapper/20:0]

or

INFO: rcu_sched detected stalls on CPUs/tasks: { 2 7 8 9 10 11 12 13 14 15
16 17 18 19 20 21 22 23 2
4 25 26 27 28 29 30 31} (detected by 6, t=2102 jiffies, g=1617, c=1616,
q=1441)

and many others, all about lockups

I did bisecting and found out that reverting these helps:

77b54e9f213f76a23736940cf94bcd765fc00f40 powernv/powerpc: Add winkle
support for offline cpus
7cba160ad789a3ad7e68b92bf20eaad6ed171f80 powernv/cpuidle: Redesign idle
states management
8eb8ac89a364305d05ad16be983b7890eb462cc3 powerpc/powernv: Enable Offline
CPUs to enter deep idle states

btw reverting just two of them produces a compile error.

It is pseries_le_defconfig, POWER8 machine:
timebase        : 512000000
platform        : PowerNV
model           : palmetto
machine         : PowerNV palmetto
firmware        : OPAL v3


Please help to fix it. Thanks.


-- 
Alexey
