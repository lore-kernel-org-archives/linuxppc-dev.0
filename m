Return-Path: <scottwood@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D0742C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 10:48:47 +1100 (EST)
Message-ID: <1384213672.1403.17.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: don't init the mpic ipi for the SoC which
 has doorbell support
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 11 Nov 2013 17:47:52 -0600
In-Reply-To: <20131109064336.GB27936@pek-khao-d1.corp.ad.wrs.com>
References: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
 <1383845691.23598.125.camel@snotra.buserror.net>
 <20131108015446.GA31761@pek-khao-d1.corp.ad.wrs.com>
 <1383945372.23598.211.camel@snotra.buserror.net>
 <20131109064336.GB27936@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-11-09 at 14:43 +0800, Kevin Hao wrote:
> On Fri, Nov 08, 2013 at 03:16:12PM -0600, Scott Wood wrote:
> > OK...  Why are you splitting out smp_85xx_basic_setup()?
> 
> In the current implementation of smp_85xx_setup_cpu(), we only invoke
> the function mpic_setup_this_cpu() when the smp_85xx_ops.probe is set 
> to smp_mpic_probe(). So if we set smp_85xx_ops.probe to NULL when doorbell
> is available, we must make sure that the mpic_setup_this_cpu() is also invoked
> when there does have a mpic. The smp_85xx_basic_setup() is for the board which
> has no mpic.
> 
>   static void smp_85xx_setup_cpu(int cpu_nr)
>   {
>   	if (smp_85xx_ops.probe == smp_mpic_probe)
>   		mpic_setup_this_cpu();
>   
>   	if (cpu_has_feature(CPU_FTR_DBELL))
>   		doorbell_setup_this_cpu();
>   }
> 
> >  Where do you
> > call it other than from smp_85xx_setup_cpu()?
> 
> We would set the .setup_cpu() to smp_85xx_basic_setup() if it is a
> non-mpic board. The following is quoted form the patch:
>    	np = of_find_node_by_type(NULL, "open-pic");
>    	if (np) {
>    		smp_85xx_ops.probe = smp_mpic_probe;
>   +		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
>    		smp_85xx_ops.message_pass = smp_mpic_message_pass;
>   -	}
>   +	} else
>   +		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;

OK, somehow I missed the change to .setup_cpu before. :-P

-Scott
