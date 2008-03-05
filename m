Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 35C5CDDEA3
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 06:14:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: pdflush weirdness
Date: Wed, 5 Mar 2008 13:13:59 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0414B825@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>,
	<linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

While trying to find what is causing some hickups on our Freescale 8280
based system=20
(ppc 603e core), i've found that pdflush is causing us some grief.

The system is runnign at 450MHz, have 1GB of memory, and we see the same

issue on 2.6.18 (arch/ppc) and 2.6.24.3 (arch/powerpc)
Filesystem is ext3, but we also see it using ext2. (have not tried any
other=20
fs, but suspect the same result)
Disk is a SATAII Hitachi drive connected to a SiliconImage 3124
controller.

Basically we have a testprogram that (re)writes a 80k file to a random
directory.
There are 50000 target directories.
Directory tree has 5000 top level directories, and 10 direcories under
each one.

Average opens take around 100ms
Average writes take 2ms
Average close/fflush takes mostly 2ms but also a significant number
around 100ms.

Once in a while (sometimes 30seconds sometimes longer) a open or a close
takes 2-3 seconds.

if I disable pdflush (echo 0 > /proc/sys/vm/dirty_writeback_centisecs) I
see no accesses=20
larger than 400 ms, and most writes/closes are 10ms.=20
Opens stay at 100ms (expected as seek time of hd comes into play)

When the pdflush delays occur, the whole system seems to be
unresponsive.

If we have the same number of direcories, but only access a subset of
2-300 of the directories,
we never see this happening. (Max time is then comparable to pdflush
off)

The system is basically a voicemail storage system, and this causes us
problems, as it causes=20
several second long timeouts in processing.

1) Is there any reason that we cannot run with pdflush permanetly
disabled (probably a bad idea...)
2) Are there any thing we can tune to make the system NOT have these
hickups?

I've also been trying to get PREEMPT_RT patches to work on our 2.6.24
kernel, but it blows up when doing the first diskaccess.
(getting a BUG_ON in rtmutex.c, line 691)
