Return-Path: <kalle.pokki@iki.fi>
Received: from smtp1.song.fi (smtp1.song.fi [194.100.2.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CE7568A4E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 23:41:45 +1100 (EST)
Received: from [194.100.64.94] (host94.eke.fi [194.100.64.94])
	by smtp1.song.fi (Postfix) with ESMTP id 53CEB5F795
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 14:31:03 +0200 (EET)
Message-ID: <43C25787.4010204@iki.fi>
Date: Mon, 09 Jan 2006 14:31:03 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Badness in dma_alloc_init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm having some trouble with the DMA allocation using Linux 2.6.14-rc2 + 
some platform modifications. Namely, the dma_alloc_coherent() function 
returns bogus virtual addresses causing machine check exceptions. At 
boot, the kernel complains there is something wrong, but I cannot figure 
out how to fix it. CONFIG_CONSISTENT_START is at its default value, 
0xff100000. Any hints where to look further?

Oh, this is a custom 8xx board. Has the support for DMA in 8xx been 
unstable at the time of pre-2.6.14?

Linux version 2.6.14-rc2 (kp@host32.eke.fi) (gcc version 4.0.0 (DENX 
ELDK 4.0 4.
0.0)) #1 Mon Jan 9 12:53:41 EET 2006
Built 1 zonelists
Kernel command line: root=/dev/mtdblock1 ro console=ttyCPM0,115200
PID hash table entries: 256 (order: 8, 4096 bytes)
Decrementer Frequency = 247500000/60
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30268k available (1608k kernel code, 376k data, 100k init, 0k 
highmem)
Mount-cache hash table entries: 512
Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:348
Call trace: [c0003670]  [c0003f24]  [c0003320]  [c01e2ad0]  [c000228c]  
[c000551
c]

... followed by otherwise good startup.
