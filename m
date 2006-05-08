Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7BD8C679E2
	for <linuxppc-dev@ozlabs.org>; Tue,  9 May 2006 06:03:59 +1000 (EST)
Subject: Re: Information for setting up SMT related parameters on linux
	2.6.16 on POWER5
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: "Meswani, Mitesh" <mmeswani@utep.edu>
In-Reply-To: <C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu>
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
	<445BE729.80903@am.sony.com>
	<C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu>
Content-Type: text/plain
Date: Mon, 08 May 2006 15:03:38 -0500
Message-Id: <1147118619.8664.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann%ibmde.RSCS@BLDVMB.POK.IBM.COM>,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-08 at 12:09 -0600, Meswani, Mitesh wrote:
>  
> Hello 

Hi

>  
> I am looking to use the SMT related parameters like Snooze delay, HMT
> thread priorities, SMT ON/Off and wanted to know how to invoke and set
> them. I am running Open Suse 10 with 2.6.16.rc4-3-ppc64 kernel on
> eServer p590 2-way POWER5 partition. 

>  
> I noticed the parameters in /sys/devices/system/cpu/cpu#   with the
> following :
>  
> mmcr0  online       pmc2  pmc5  smt_snooze_delay
> mmcr1  physical_id  pmc3  pmc6  topology
> crash_notes  mmcra  pmc1         pmc4  purr
> 

Some of this is unique to Logical Partitions and cpu's on POWER5 pSeries
hardware..    I think you've already found the useful entry "online",
and the rest would be just trivial information.

On the kernel boot commandline, you can add parms such as
"smt-snooze-delay=xxxx" to set the snooze_delay value, and
"smt-enabled=off" to turn off the secondary threads. 

As you've already found, you can echo values into the sys entries to
cause the cpus to go online or offline.  0=offline, 1=online.   You can
also adjust the value for snooze-delay.  This one defaults to '0'.  This
controls the amount of time the processor thread spins before declaring
that it's got no useful work to do and cedes itself. 

"mmcr*" and "pmc*" are performance counter registers and values.  These
are used by oprofile.

"purr" is a Processor Utilization Resource Register, indicating the
number of ticks that the processor has been in use.  

I believe "crash_notes" has to do with lkcd or crashdump.   

No idea on the "topology" entry.  possibly related to NUMA. 

> setting the value in online to 0 seems to turn off the logical
> processor, but I am not sure what the others are for and the meaning
> of their hex values? 
> It seems that there is include/asm-ppc64/processor.h  with macros like
> HMT_very_low()  ,  wonder if these can be set on command line
>  since I am running unmodified app binaries. 

the HMT_* macros are telling firmware that "this processor thread should
run at this priority".  Typically used when we're waiting on a spinlock.
I.e. When we are waiting on a spinlock, we hit the HMT_low macro to drop
our threads priority, allowing the other thread to use those extra
cycles finish it's stuff quicker, and maybe even release the lock we're
waiting for.          HMT_* is all within the kernel though, no exposure
to userspace apps.  

>  
> Thanks, 
> Mitesh
>  
>  

Hope that is helpful..  
-Will


> Mitesh R. Meswani 
> Ph.D. Candidate 
> Research Associate, PLS2 Group
> Room 106 F, Department of Computer Science
> The University of Texas at El Paso, 
> El Paso, Texas 79968
> Tel: 915 747 8012 (O)
> Email: mmeswani@utep.edu
> 
> ______________________________________________________________________
> From: linuxppc-dev-bounces+mmeswani=utep.edu@ozlabs.org on behalf of
> Geoff Levand
> Sent: Fri 5/5/2006 6:00 PM
> To: Paul Mackerras
> Cc: Arnd Bergmann; Levand,Geoffrey; linux-kernel@vger.kernel.org;
> linuxppc-dev@ozlabs.org; Arnd Bergmann; cbe-oss-dev@ozlabs.org
> Subject: Re: [PATCH 04/13] cell: remove broken __setup_cpu_be function
> 
<Snippage...>

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
