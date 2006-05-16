Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46938679EF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 14:43:22 +1000 (EST)
Subject: Re: ppc32 kernel boot problem (pmu related?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Pilatzke <nathanpilatzke@gmail.com>
In-Reply-To: <98889dd30605152106m9090ba3ga1a4c7706aace3ef@mail.gmail.com>
References: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
	<1147403525.7343.19.camel@localhost.localdomain>
	<98889dd30605120540n214800fbk8899fe9e39e972cf@mail.gmail.com>
	<1147658309.21291.73.camel@localhost.localdomain>
	<98889dd30605152106m9090ba3ga1a4c7706aace3ef@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 14:43:13 +1000
Message-Id: <1147754594.13588.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> And that's where is locks hard.  Just as an alternative I tried
> compiling without i2c support, but the kernel locks hard at the exact
> same point.  Compiling without the pmu code is the only way I can get
> the kernel to boot.  There are some kernel messages missing from a
> kernel compiled with pmu versus a kernel without pmu, namely:
> 
> On node 0 total pages: 163840
>  DMA zone: 163840 pages, LIFO batch: 31
> 
> and
> 
> Calibrating delay loop... 49.79 BogoMIPS (lpj=99584)
> 
> but they do not seem to be anything serious.  Where to go from here?
> Thanks for the debugging suggestions so far, keep them coming please.

Can you try editing arch/powerpc/platforms/powermac/low_i2c.c, in
function pmac_i2c_init(), comment out the call to pmac_i2c_devscan() and
tell me if that makes a difference.

Thanks,
Ben.
