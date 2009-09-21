Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED38DB7B6F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 17:31:01 +1000 (EST)
Date: Mon, 21 Sep 2009 09:30:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Metzger, Markus T" <markus.t.metzger@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] perf_counter/powerpc: Fix compilation after
	perf_counter_overflow change
Message-ID: <20090921073043.GB24467@elte.hu>
References: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
	<928CFBE8E7CB0040959E56B4EA41A77EC69BA5E0@irsmsx504.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <928CFBE8E7CB0040959E56B4EA41A77EC69BA5E0@irsmsx504.ger.corp.intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Metzger, Markus T <markus.t.metzger@intel.com> wrote:

> >-----Original Message-----
> >From: Paul Mackerras [mailto:paulus@samba.org]
> >Sent: Monday, September 21, 2009 8:45 AM
> 
> 
> >Markus, please take care in future to mention it in the changelog if
> >your patches touch definitions used by other architectures.  If you
> >could go so far as to use grep a bit more and fix up other
> >architectures' callsites for the things you're changing, that would be
> >very much appreciated.  Thanks.
> 
> I'm sorry I missed that.
> 
> There's one more place in arch/sparc/.
> The below patch should fix it, but I have no means to test it.

You also missed a third thing:

+static inline int
+perf_output_begin(struct perf_output_handle *handle, struct perf_counter *c,
+                 unsigned int size, int nmi, int sample)               { }

an 'int' function returning void ...

Plus all the !PERF_COUNTERS branch of empty inlines is pointless - these 
facilities are used by perfcounters code only. I fixed that too.

> 
> Index: b/arch/sparc/kernel/perf_counter.c
> ===================================================================
> --- a/arch/sparc/kernel/perf_counter.c
> +++ b/arch/sparc/kernel/perf_counter.c
> @@ -493,7 +493,6 @@ static int __kprobes perf_counter_nmi_ha
>  
>  	regs = args->regs;
>  
> -	data.regs = regs;
>  	data.addr = 0;
>  
>  	cpuc = &__get_cpu_var(cpu_hw_counters);
> @@ -513,7 +512,7 @@ static int __kprobes perf_counter_nmi_ha
>  		if (!sparc_perf_counter_set_period(counter, hwc, idx))
>  			continue;
>  
> -		if (perf_counter_overflow(counter, 1, &data))
> +		if (perf_counter_overflow(counter, 1, &data, regs))
>  			sparc_pmu_disable_counter(hwc, idx);
>  	}

Looks correct to me and i've also done a Sparc cross build with the fix 
in place and it builds fine besides the unrelated build error pasted 
below. I've added it to the other fix and if David acks it will send it 
to Linus later today.

Thanks,

	Ingo

/home/mingo/tip/drivers/video/console/vgacon.c: In function 'vgacon_startup':
/home/mingo/tip/drivers/video/console/vgacon.c:516: warning: passing argument 1 of 'scr_readw' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:517: warning: passing argument 1 of 'scr_readw' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:518: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:519: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:520: warning: passing argument 1 of 'scr_readw' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:520: warning: passing argument 1 of 'scr_readw' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:521: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:522: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:525: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:526: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:527: warning: passing argument 1 of 'scr_readw' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:527: warning: passing argument 1 of 'scr_readw' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:528: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:529: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:532: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c:533: warning: passing argument 2 of 'scr_writew' discards qualifiers from pointer target type
/home/mingo/tip/drivers/video/console/vgacon.c: In function 'vgacon_do_font_op':
/home/mingo/tip/drivers/video/console/vgacon.c:1126: error: implicit declaration of function 'vga_writeb'
/home/mingo/tip/drivers/video/console/vgacon.c:1129: error: implicit declaration of function 'vga_readb'
make[4]: *** [drivers/video/console/vgacon.o] Error 1
make[3]: *** [drivers/video/console] Error 2
make[2]: *** [drivers/video] Error 2
make[2]: *** Waiting for unfinished jobs....
