Return-Path: <kimmo.surakka@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id A6A24DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 18:12:13 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so429065nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 01:12:10 -0700 (PDT)
Message-ID: <a44e83440704120112p2e1c796bn3c8820a557fa19e1@mail.gmail.com>
Date: Thu, 12 Apr 2007 11:12:10 +0300
From: "Kimmo Surakka" <kusti@iki.fi>
Sender: kimmo.surakka@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: cpuid bug in linuxppc24-devel tree?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I've been playing around with a TQM5200 board, trying to get the
/proc/sys/kernel/powersave-nap feature to work. I got the kernel
sources first from ftp.denx.de, as a tar.gz snapshot, then from Denx
git tree. What I found out is that on an old snapshot kernel, "echo 1
> /proc/sys/kernel/powersave-nap" has a visible effect on the current
consumption of the CPU, but on the latest snapshots, enabling
powersave-nap does nothing at all.

I started seeking back and forth in the git three to locate the exact
commit that caused powersave-nap to stop working. Turns out it's the
commit id ad7d1f028ff752dd46ff3e09c1ca6e5fc588f55d, which modified
only the arch/ppc/kernel/cputable.c file. Before the modification, the
MPC5200 on my board was identified as an 8280 CPU and napping happily,
but after the patch, the CPU is identified as an 8220 without the
ability to nap.

The identification seems to be based on the PVR register. On the
MPC5200, the PVR register  value is 0x80822011 (according to
Freescale's document "MPC5200 Users Guide, Rev. 3.1"), and the SVR
register contains 0x80110010, 0x80110011, or 0x80110012, (matching
core revisions 1.0, 1.1, or 1.2).

What I can make out of the cpuid.c file is that the entry

    {   /* 8220 */
        0xffffffff, 0x80822011, "8220",
        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
        /* Deleted CPU_FTR_CAN_DOZE, because we know it doesn't work
           on this chip.  New revs might need adjusting, including
           shrinking mask above.  */
        COMMON_PPC,
       32, 32,
       __setup_cpu_603
   },

matches MPC5200 as an 8220. Can this entry be correct?

Thanks for your time,

Kimmo Surakka
-- 
Kimmo Surakka <kusti@iki.fi>
http://www.iki.fi/kusti
