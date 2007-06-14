Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A3C0DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 07:10:45 +1000 (EST)
In-Reply-To: <20070612160628.GB2481@chiana.homelinux.org>
References: <4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
	<1181169093.31677.260.camel@localhost.localdomain>
	<d3c57096eec4553de180adab085d0145@kernel.crashing.org>
	<20070611162135.GS2591@chiana.homelinux.org>
	<894636D6-AC2E-4D28-8698-EB43C7354BB5@kernel.crashing.org>
	<20070612160628.GB2481@chiana.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F8BCBDB1-B699-4353-8FD8-A8FA60380C6F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Thu, 14 Jun 2007 16:04:57 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 12, 2007, at 11:06 AM, Marc Leeman wrote:

>> I'm confused what you are comparing here, 3 seconds on arch=ppc vs
>> over a minute on arch=powerpc?
>
> Loading of a TI DSP over HPI. HPI is implemented in UPMB  
> (programmed by
> U-Boot); all that the kernel has to do is write to the in U-Boot
> programmed location (0xe2400000) to trigger the UPMB HPI protocol.
>
>> I'd expect the driver to be exactly the same (or close to it) for
>> arch=ppc vs arch=powerpc.
>
> Same here: there are a number of performance issues wrt to an older  
> 8245
> based implementation (network seems slower too) and this was not one I
> expected while switching to powerpc.

Are you comparing 8245 on arch=ppc to 83xx on arch=powerpc or 83xx in  
both cases?

>> There shouldn't be, but if you are seeing this we really should
>> figure out what's going on.
>>
>> What kernel is this on?  What processor are you using?
>
> $ cat /proc/cpuinfo
> processor       : 0
> cpu             : e300c1
> clock           : 396.000000MHz
> revision        : 1.1 (pvr 8083 0011)
> bogomips        : 131.28
> timebase        : 66000000
> platform        : BARCO834x SVC2

Hmm, we really need to put SVR in there as well (add that to the todo  
list).  Which 83xx is this?

> $ uname -a
> Linux barco 2.6.21.1-barco1 #1 PREEMPT Tue Jun 12 09:48:12 CEST  
> 2007 ppc unknown
>
> The board is based on the FreeScale SYS/EMDS reference design.
>
> Most of the HPI operations are stuff like this:
>
> static inline int8_t _hpi_set_hhwil(uint8_t b)
> {
>         volatile immap_t* im;
>
>         if(!(im = ioremap((immrbar),sizeof(struct immap)))){
>                 return -EINVAL;
>         }
>         (b)?(im->gpio[0].dat |= HHWIL):(im->gpio[0].dat &= ~HHWIL);
>         iounmap(im);
>
>         return 0;
> }
>
> static inline uint32_t __hpi_read_hpid(void)
> {
>         uint32_t returnval;
>
>         /* Program HPID */
>         _hpi_set_hcntl1(1);
>         _hpi_set_hcntl0(1);
>
>         /* first halfword */
>         _hpi_set_hhwil(0);
>         /* dummy read */
>         returnval = (((uint32_t)(*hpi_dsp))<<16);
>
>         /* delay */
>         udelay(1);
>
>         /* second halfword */
>         _hpi_set_hhwil(1);
>         /* dummy read */
>         returnval |= *hpi_dsp;
>
>         /* delay */
>         udelay(1);
>
>         return returnval;
> }
>
> The ioremap was certainly a bottleneck; and moving it to  
> initialisation
> with a global pointer got us from 60 secs back to around 1 sec, but  
> the
> a similar effect was obtained on the ppc arch with this change  
> (this was
> just making a bad situation to be hidden).

Do you sense of how many calls you make to _hpi_set_hhwil &  
__hpi_read_hpid?

I think I know why the ppc case was more efficient.

> Even after this change; the load of a streaming application was
> something of 40% on ppc and 60% on powerpc.

What's going on during the streaming?

- k
