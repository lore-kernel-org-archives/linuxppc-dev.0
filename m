Return-Path: <bigeasy@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 89A7AB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 06:21:04 +1000 (EST)
Message-ID: <4A98317B.6050805@linutronix.de>
Date: Fri, 28 Aug 2009 21:35:23 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add kexec support on FSL-Book-E
References: <e997b7420908011825n4ba2df16u71d53953d6774c21@mail.gmail.com>	
	<20090804194135.GA19171@www.tglx.de>
	<e997b7420908250909k74208353v81240eebd3d0896a@mail.gmail.com>
In-Reply-To: <e997b7420908250909k74208353v81240eebd3d0896a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wilbur.chan wrote:
> Hi  Sebastian,
Hi Wilbur,

> Recently I've implemented  non-SMP kexec on MPC8572 and P2020ds(2G ram).
> 
> 
> 
> I modified your
> 
> misc_32.S that , I setuped  two '1G' entries  after the "rfi"
> instruction, so that I did
> not  need to setup  mapping for instruction address.
If you send some patches I could add them to my tree so we have
everything together.

> As for SMP supporting,I tried to close one of the CPUs in
> default_machine_kexec,
> 
> and found that , when cpu1  closed  ,and if the second kernel is NON-
> 
> SMP,everything went well.so I added some code in
> 
> kexec-tools, to make sure the 'kexec' process was running on CPU 0.
I remember that ppc64 had some code to suspend and start the second CPU in
the purgatory code. Not sure if there is a generic way for this on ppc32
or it is a book-e thing. Haven't look at it (yet).

> So, there left one problem, I can not start the second SMP-kernel,
> even if I  closed
> 
> CPU1.  Any suggestions?
The interesting thing is where do you hang/crash. It could be possible
that the kernel is waiting for the non-boot cpus to show up and it
doesn't. Have you look how u-boot prepares the cpus and how kernel
disables them on shutdown?


> PTW:
> 
> no-smp ---> no-smp.........OK
> no-smp --->smp...............OK
Does this mean your smp kernel has more that one CPU or just one?

> smp(with cpu1 closed)---->no-smp..............OK
> smpw(with cpu1 closed)---->smp ................FAILED
> 
> 
> regards,
> 
> wilbur

Sebastian
