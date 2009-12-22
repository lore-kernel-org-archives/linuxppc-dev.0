Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39DD4B6F08
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 13:17:53 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBM296jG023777
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 21:09:06 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBM2Hodj1241342
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 21:17:50 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBM2HoI2007215
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 21:17:50 -0500
Message-ID: <4B302C46.2010802@austin.ibm.com>
Date: Mon, 21 Dec 2009 20:17:42 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/6 v5] CPU probe/release files
References: <4AE8ADCF.6090104@austin.ibm.com>	
	<4AE8B072.1070603@austin.ibm.com> <m2oclw9wt4.fsf@igel.home>
	<1261212415.2173.94.camel@pasglop>
In-Reply-To: <1261212415.2173.94.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2009-12-18 at 15:33 +0100, Andreas Schwab wrote:
>> Nathan Fontenot <nfont@austin.ibm.com> writes:
>>
>>> Index: powerpc/arch/powerpc/Kconfig
>>> ===================================================================
>>> --- powerpc.orig/arch/powerpc/Kconfig	2009-10-28 15:21:47.000000000 -0500
>>> +++ powerpc/arch/powerpc/Kconfig	2009-10-28 15:21:53.000000000 -0500
>>> @@ -320,6 +320,10 @@
>>>  
>>>  	  Say N if you are unsure.
>>>  
>>> +config ARCH_CPU_PROBE_RELEASE
>>> +	def_bool y
>>> +	depends on HOTPLUG_CPU
>>> +
>> That does not work.
>>
>> drivers/built-in.o: In function `.store_online':
>> cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock'
>> cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlock'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> cpu_hotplug_driver_lock is only defined on pseries, but HOTPLUG_CPU is
>> also defined on pmac.
> 
> Well, the stuff was merged ... so we need to fix it.
> 
> Nathan, the problem is that the above wlil define ARCH_CPU_PROBE_RELEASE
> for any powerpc platform that has HOTPLUG_CPU. So a kernel that doesn't
> have pSeries support but has hotplug CPU will have a problem, though for
> some reason none of my test configs triggered it (I'll have to check why
> next week).
> 
> The right approach here is to have cpu_hotplug_driver_lock go through
> ppc_md. I suppose, along with some of the other CPU hotplug platform
> specific bits.
> 

Sounds good to me,  I'll get a patch together.

-Nathan Fontenot
