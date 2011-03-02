Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 980811007D2
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2011 16:49:31 +1100 (EST)
Message-ID: <4D6DDA85.8070204@embedded-sol.com>
Date: Wed, 02 Mar 2011 07:49:57 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
	<20110228211103.GB31428@ovro.caltech.edu>
	<4D6C134C.4070407@embedded-sol.com>
	<20110301002156.GC31428@ovro.caltech.edu>
	<4D6C89A7.8010803@embedded-sol.com>
	<20110301165515.GA23403@ovro.caltech.edu>
	<20110301195208.GC23403@ovro.caltech.edu>
In-Reply-To: <20110301195208.GC23403@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

On 03/01/2011 09:52 PM, Ira W. Snyder wrote:
> On Tue, Mar 01, 2011 at 08:55:15AM -0800, Ira W. Snyder wrote:
>
> [ big snip ]
>
>
> I'd still like the bisect if you have a chance. I've re-reviewed the
> patch series, and found the places that change register writes to the
> controller.
>
> The patch below changes the register operations back to the original
> order. It doesn't make any sense why this would be required, but it is
> worth a quick try.
>
> I've added an "XXX" mark where you can comment out a single line if this
> patch fails. It is highly unlikely to make any difference, but I'm
> really having a hard time understanding what is wrong.
>
>
This patch fixes the problem. See below

__dma_request_channel: success (dma0chan0)
dmatest: Started 1 threads using dma0chan0
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372000 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3720c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372120 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3721e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=0
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=8
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan0: 85xx, running workaround
of:fsl-elo-dma ffe0c300.dma: chan0: dma_halt mode=0x08000140
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=8
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372000 callback
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372000 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3720c0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372120 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372180 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3721e0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 free
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #0: No errors with src_off=0x10a8 dst_off=0x1914 
len=0x1dca
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=8
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=10
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan0: 85xx, running workaround
of:fsl-elo-dma ffe0c300.dma: chan0: dma_halt mode=0x08000141
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=10
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 callback
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 free
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #1: No errors with src_off=0xdb8 dst_off=0xc14 len=0x526
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3721e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372120 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3720c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=10
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=17
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan0: 85xx, running workaround
of:fsl-elo-dma ffe0c300.dma: chan0: dma_halt mode=0x08000141
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=17
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 callback
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3721e0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372180 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372120 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3720c0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 free
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #2: No errors with src_off=0xf48 dst_off=0x85d len=0x188f
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3720c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372120 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3721e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372000 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372300 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372360 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3723c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372420 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372480 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3724e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372540 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=17
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=32
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan0: 85xx, running workaround
of:fsl-elo-dma ffe0c300.dma: chan0: dma_halt mode=0x08000141
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=32
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 callback
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372060 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3720c0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372120 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372180 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3721e0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3722a0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372240 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372000 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372300 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372360 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3723c0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372420 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372480 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3724e0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef372540 free
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #3: No errors with src_off=0x4ff dst_off=0x453 len=0x395d
dma0chan0-copy0: terminating after 4 tests, 0 failures (status 0)

Felix.
