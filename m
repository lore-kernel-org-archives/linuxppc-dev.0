Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60912DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:01:12 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] powerpc: Make the NR_CPUS max 8192 
In-reply-to: <alpine.LRH.2.00.0905180857060.16754@vixen.sonytel.be> 
References: <17087.1242609196@neuling.org> <1242609873.13757.4.camel@concordia>
	<9686.1242620044@neuling.org>
	<alpine.LRH.2.00.0905180857060.16754@vixen.sonytel.be>
Date: Mon, 18 May 2009 17:01:11 +1000
Message-ID: <31374.1242630071@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <alpine.LRH.2.00.0905180857060.16754@vixen.sonytel.be> you wrote:
> On Mon, 18 May 2009, Michael Neuling wrote:
> > > > We can compile and boot with NR_CPUS=3D8192, so make this the max.  102
4
> > > > was an arbitrary decision anyway.
> > > 
> > > Is 8192 still arbitrary? Or does something break above that?
> > 
> > Yeah, the compile breaks after that with 4K pages.
> > 
> > In drivers/base/node.c we have:
> > 	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
> > 	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
> > which causes:
> > drivers/base/node.c: In function 'node_read_cpumap':
> > drivers/base/node.c:31: error: size of array 'type name' is negative
> > 
> > I can compile with 16384 CPUs with 64K pages, but it doesn't boot.  
> > 
> > sfr asked for size info for different builds, so I may as well repost
> > them here:
> > 
> >    text	   data		bss		dec		hex	filenam
e
> > 9237767	3225768		4409996		16873531	101783b	vmlinux
.1024
> > 9247355	4769472		7373708		21390535	14664c7	vmlinux
.2048
> > 9267239	7857032		13301132	30425403	1d0413b	vmlinux
.4096
> > 9302623	14035832	25155980	48494435	2e3f763	vmlinux
.8192
> > 9373283	26389360	48865676	84628319	50b535f	vmlinux
.16384
> 
> Will distros now start pushing NR_CPUS=8192-kernels on us?

Yeah, that's a concern.

Mikey
