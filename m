Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 7290CDE03B
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 16:58:02 +1000 (EST)
Date: Mon, 18 May 2009 08:57:55 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Make the NR_CPUS max 8192 
In-Reply-To: <9686.1242620044@neuling.org>
Message-ID: <alpine.LRH.2.00.0905180857060.16754@vixen.sonytel.be>
References: <17087.1242609196@neuling.org> <1242609873.13757.4.camel@concordia>
	<9686.1242620044@neuling.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 May 2009, Michael Neuling wrote:
> > > We can compile and boot with NR_CPUS=3D8192, so make this the max.  1024
> > > was an arbitrary decision anyway.
> > 
> > Is 8192 still arbitrary? Or does something break above that?
> 
> Yeah, the compile breaks after that with 4K pages.
> 
> In drivers/base/node.c we have:
> 	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
> 	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
> which causes:
> drivers/base/node.c: In function 'node_read_cpumap':
> drivers/base/node.c:31: error: size of array 'type name' is negative
> 
> I can compile with 16384 CPUs with 64K pages, but it doesn't boot.  
> 
> sfr asked for size info for different builds, so I may as well repost
> them here:
> 
>    text	   data		bss		dec		hex	filename
> 9237767	3225768		4409996		16873531	101783b	vmlinux.1024
> 9247355	4769472		7373708		21390535	14664c7	vmlinux.2048
> 9267239	7857032		13301132	30425403	1d0413b	vmlinux.4096
> 9302623	14035832	25155980	48494435	2e3f763	vmlinux.8192
> 9373283	26389360	48865676	84628319	50b535f	vmlinux.16384

Will distros now start pushing NR_CPUS=8192-kernels on us?

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
