Return-Path: <dwilder@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E52C167BD6
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 08:43:01 +1000 (EST)
Received: from e5.ny.us.ibm.com (e5.pok.ibm.com [9.56.232.145])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3CJdgfp015661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 15:39:43 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3CJdQQv007727
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 15:39:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3CJdKfB130074
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 15:39:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3CJdJii004713
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 15:39:20 -0400
Message-ID: <443D618D.5050407@us.ibm.com>
Date: Wed, 12 Apr 2006 13:22:37 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] 2 of 3   kdump-ppc64-soft-reset-fixes
References: <443ADCCE.1070504@us.ibm.com> <20060412171520.GA24681@suse.de>
In-Reply-To: <20060412171520.GA24681@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: akpm@osdl.org, fastboot@lists.osdl.org, mchintage@in.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:

> On Mon, Apr 10, David Wilder wrote:
>
>
>  
>
>>+++ 2617-rc1/arch/powerpc/kernel/crash.c	2006-04-05 13:24:19.000000000 -0700
>>    
>>
>
>  
>
>>@@ -185,15 +277,14 @@ void default_machine_crash_shutdown(stru
>> 	 * The kernel is broken so disable interrupts.
>> 	 */
>> 	local_irq_disable();
>>-
>>-	if (ppc_md.kexec_cpu_down)
>>-		ppc_md.kexec_cpu_down(1, 0);
>>-
>> 	/*
>> 	 * Make a note of crashing cpu. Will be used in machine_kexec
>> 	 * such that another IPI will not be sent.
>>    
>>
>
>This change conflicts with the patch for interrupt shutdown. I guess
>both patches are needed, as each one fixes a different bug?
>
>http://ozlabs.org/pipermail/linuxppc-dev/2006-April/021855.html
>[PATCH] powerpc: Disable and EOI interrupts in machine_crash_shutdown()
>
>  
>

Yes both are needed,  I don t see the conflict.  If you apply interrupt 
shutdown first then the soft-reset patch.  It should work ok.


-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789
