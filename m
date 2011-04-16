Return-Path: <richardcochran@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4AC1AB701B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 17:55:07 +1000 (EST)
Received: by fxm5 with SMTP id 5so2675895fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 00:55:03 -0700 (PDT)
Date: Sat, 16 Apr 2011 09:54:56 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: regression: 2.6.39-rc2,3 compile failure on p2020 (repost)
Message-ID: <20110416075456.GA11822@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When compiling mpc85xx_smp_defconfig, the kernel fails to link with:

   arch/powerpc/kernel/built-in.o: In function `cpu_die':
   arch/powerpc/kernel/smp.c:702: undefined reference to `start_secondary_resume'

I suspect:

  commit fa3f82c8bb7acbe049ea71f258b3ae0a33d9d40b
  powerpc/smp: soft-replugged CPUs must go back to start_secondary

The symbol start_secondary_resume is provided by head_32.S, but it is
not present in head_fsl_booke.S.

I don't now how to fix this and would appreciate any help.

Thanks,

Richard
