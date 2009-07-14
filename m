Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6BDE7B7092
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 17:10:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEB62DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 17:10:28 +1000 (EST)
Subject: Re: [patch 3/3] powerpc: Preload application text segment instead
	of TASK_UNMAPPED_BASE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20090714065425.555222245@samba.org>
References: <20090714065350.659537380@samba.org>
	<20090714065425.555222245@samba.org>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 17:10:23 +1000
Message-Id: <1247555423.29462.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-07-14 at 16:53 +1000, Anton Blanchard wrote:
> plain text document attachment (preload_0x10000000)
> TASK_UNMAPPED_BASE is not used with the new top down mmap layout. We can
> reuse this preload slot by loading in the segment at 0x10000000, where almost
> all PowerPC binaries are linked at.
> 
> On a microbenchmark that bounces a token between two 64bit processes over pipes
> and calls gettimeofday each iteration (to access the VDSO), both the 32bit and
> 64bit context switch rate improves (tested on a 4GHz POWER6):
> 
> 32bit: 273k/sec -> 283k/sec
> 64bit: 277k/sec -> 284k/sec

Any chance you can put that little test program online somewhere ?

Cheers,
Ben.
