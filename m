Return-Path: <jsurf@heckheck.com>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [204.127.192.84])
	by ozlabs.org (Postfix) with ESMTP id BEF2E67CED
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 17:23:03 +1100 (EST)
Message-ID: <4551768F.9040601@heckheck.com>
Date: Wed, 08 Nov 2006 01:17:51 -0500
From: Jim Heck <jsurf@heckheck.com>
MIME-Version: 1.0
To: robin.gilks@tait.co.nz
Subject: Re: 2.6.18 fails in call_usermodedata() on 8xx
References: <45512174.7020205@tait.co.nz>
In-Reply-To: <45512174.7020205@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robin,

Could you provide some more details of your problem with dma_alloc_init 
for the 8xx.  I posted a few days back on Saturday about problems I was 
having getting an RPXLiteDW (based on the 823) to work with a late 
2.6.xx kernel.  I had traced the problem down (working without a probe) 
to problems with cpm_dpalloc() and cpm_dpram_addr() in the allocation of 
DP Ram buffers for the network loopback device.  DMA rings a bell since 
the failure occurred near where the /arch/ppc/8xx_io/enet.c driver is 
calling  dma_alloc_coherent().

The details on what code you had to change in the kernel, and the 
problems you were seeing might help me greatly.

Thanks for any help,

-Jim Heck

Robin Gilks wrote:
> Greetings
>
> Having (sort of) mastered the bdi2000, I'm trying to bring up a 8xx card
> thats been debugged and working with a 2.4 kernel for the last 3 years
> but is failing miserably on a 2.6.18 kernel.
>
> My initial problems in dma_alloc_init I seem to have fixed by moving
> CONFIG_CONSISTENT_START to 0xa0000000 from the default of 0xff100000 but
> now I'm failing in call_usermodedata(). Any attempt to check the values 
> of structures (eg. current->fs->root) results in an error of the form:
>
> (gdb) print *current
> Cannot access memory at address 0xc01e27a8
>
> so I'm a bit stuck with further debugging.
>
> Is there anything I should be looking out for in particular with an 8xx
> CPU and a late 2.6 kernel? My understanding was that it now worked but
> the config documentation is a bit thin on the ground :-(
>
> Cheers
>
>   
