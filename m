Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09F52B6F0C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 03:25:00 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBIGMJXA028362
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 11:22:19 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBIGOsQ41708076
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 11:24:54 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBIGOr3e026392
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 14:24:54 -0200
Message-ID: <4B2BACD3.7010903@austin.ibm.com>
Date: Fri, 18 Dec 2009 10:24:51 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 5/6 v5] CPU probe/release files
References: <4AE8ADCF.6090104@austin.ibm.com>	<4AE8B072.1070603@austin.ibm.com>
	<m2oclw9wt4.fsf@igel.home>
In-Reply-To: <m2oclw9wt4.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Nathan Fontenot <nfont@austin.ibm.com> writes:
> 
>> Index: powerpc/arch/powerpc/Kconfig
>> ===================================================================
>> --- powerpc.orig/arch/powerpc/Kconfig	2009-10-28 15:21:47.000000000 -0500
>> +++ powerpc/arch/powerpc/Kconfig	2009-10-28 15:21:53.000000000 -0500
>> @@ -320,6 +320,10 @@
>>  
>>  	  Say N if you are unsure.
>>  
>> +config ARCH_CPU_PROBE_RELEASE
>> +	def_bool y
>> +	depends on HOTPLUG_CPU
>> +
> 
> That does not work.
> 
> drivers/built-in.o: In function `.store_online':
> cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock'
> cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlock'
> make: *** [.tmp_vmlinux1] Error 1
> 
> cpu_hotplug_driver_lock is only defined on pseries, but HOTPLUG_CPU is
> also defined on pmac.

These two routines should be defined as a no-op if CONFIG_ARCH_CPU_PROBE_RELEASE
is not defined in linux/cpu.h.  The update below should be in the patch set
you are looking at. 

from linux/cpu.h:

#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
extern void cpu_hotplug_driver_lock(void);
extern void cpu_hotplug_driver_unlock(void);
#else
static inline void cpu_hotplug_driver_lock(void)
{
}

static inline void cpu_hotplug_driver_unlock(void)
{
}
#endif

-Nathan Fontenot
