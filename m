Return-Path: <wilbur512@gmail.com>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 3A3D3B7B83
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 02:09:38 +1000 (EST)
Received: by gxk7 with SMTP id 7so4488069gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 09:09:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090804194135.GA19171@www.tglx.de>
References: <e997b7420908011825n4ba2df16u71d53953d6774c21@mail.gmail.com>
	<20090804194135.GA19171@www.tglx.de>
Date: Wed, 26 Aug 2009 00:09:36 +0800
Message-ID: <e997b7420908250909k74208353v81240eebd3d0896a@mail.gmail.com>
Subject: Re:[PATCH 1/2] powerpc: add kexec support on FSL-Book-E
From: "wilbur.chan" <wilbur512@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/8/5, Sebastian Andrzej Siewior <bigeasy@linutronix.de>:

> There is no SMP support. The other CPUs are not halted/resumed. At the
> time of writing it I did not have a SMP machine so I did not implement
> it.
> Sebastian
>
Hi  Sebastian,

Recently I've implemented  non-SMP kexec on MPC8572 and P2020ds(2G ram).



I modified your

misc_32.S that , I setuped  two '1G' entries  after the "rfi"
instruction, so that I did

not  need to setup  mapping for instruction address.

As for SMP supporting,I tried to close one of the CPUs in
default_machine_kexec,

and found that , when cpu1  closed  ,and if the second kernel is NON-

SMP,everything went well.so I added some code in

kexec-tools, to make sure the 'kexec' process was running on CPU 0.


So, there left one problem, I can not start the second SMP-kernel,
even if I  closed

CPU1.  Any suggestions?


PTW:

no-smp ---> no-smp.........OK
no-smp --->smp...............OK

smp(with cpu1 closed)---->no-smp..............OK
smpw(with cpu1 closed)---->smp ................FAILED


regards,

wilbur
