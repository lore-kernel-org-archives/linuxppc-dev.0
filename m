Return-Path: <strosake@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 537FB67A3D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 08:13:07 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7UMD3gP018817
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 18:13:03 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7UMD3c7226670
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 18:13:03 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7UMD3Vl022182
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 18:13:03 -0400
Message-ID: <44F60D6C.6070303@austin.ibm.com>
Date: Wed, 30 Aug 2006 17:13:00 -0500
From: Mike Strosaker <strosake@austin.ibm.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] reboot when panic_timout is set
References: <20060821161132.GA31085@aepfle.de>
	<44EF428B.8010100@austin.ibm.com>
	<20060825201402.GA28214@aepfle.de>
In-Reply-To: <20060825201402.GA28214@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:

>On Fri, Aug 25, Mike Strosaker wrote:
>
>>Olaf Hering wrote:
>>    
>>
>>>Only call into RTAS when booted with panic=0 because the RTAS call does 
>>>not return.
>>>The system has to be rebooted via the HMC or via the management console 
>>>right now.
>>>This is cumbersome and not what the default panic=180 is supposed to do.
>>>      
>>>
>>The os-term call is supposed to indicate to the platform that it should 
>>follow it's abnormal OS termination policy.  I normally set my 
>>partitions to reboot immediately after an os-term call.  I believe that 
>>"/usr/sbin/serv_config -b" (installed with powerpc-utils-papr) is used 
>>to set that policy from the command line.
>>    
>>
>
>That doesnt help me at all if the kernel crashes before it reaches
>/init. And if one has to call a binary anyway to set or upgrade the
>policy, this binary can also set /proc/sys/kernel/panic to 0.
>  
>
Hmm... I thought there was a way to modify the reboot policy from SMS or 
the OF command line, but I can't find a way offhand.  I'm trying to find 
out from the firmware people here.  It used to be an NVRAM variable in 
one of the partitions visible to the OS (and so changable from OF with 
the setenv command), but that's not the case anymore; it's now modified 
by the ibm,set-system-parameter RTAS call.

>Do I have to set it for each boot, or is a change permanent?
>  
>
The change is stored in NVRAM, and thus is persistent across reboots.
