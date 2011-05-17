Return-Path: <richardcochran@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4524BB6EE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 02:28:38 +1000 (EST)
Received: by ewy6 with SMTP id 6so208406ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 09:28:34 -0700 (PDT)
Date: Tue, 17 May 2011 18:28:27 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: benh@kernel.crashing.org
Subject: powerpc: mpc85xx regression since 2.6.39-rc2, one cpu core lame
Message-ID: <20110517162827.GA16918@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Recent 2.6.39-rc kernels behave strangely on the Freescale dual core
mpc8572 and p2020. There is a long pause (like 2 seconds) in the boot
sequence after "mpic: requesting IPIs..."

When the system comes up, only one core shows in /proc/cpuinfo. Later
on, lots of messages appear like the following:

   INFO: task ksoftirqd/1:9 blocked for more than 120 seconds.

I bisected [1] the problem to:

   commit c56e58537d504706954a06570b4034c04e5b7500
   Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Date:   Tue Mar 8 14:40:04 2011 +1100

       powerpc/smp: Create idle threads on demand and properly reset them

I don't see from that commit what had gone wrong. Perhaps you can
help resolve this?

Thanks,
Richard


1. I had to patch commit e5462d16 by hand when bisecting, which is a
   fixup for commit fa3f82c8 and not yet merged in c56e5853.
