Return-Path: <haren@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80AE2DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 15:15:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBK4FB1F028659
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 23:15:11 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBK4FBew504620
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 21:15:11 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBK4FB6b025074
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 21:15:11 -0700
Message-ID: <4588B89E.3090900@us.ibm.com>
Date: Tue, 19 Dec 2006 20:14:22 -0800
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 2 CPUs, but only one is used
References: <20061217144127.579f01f0.pochini@shiny.it>
	<20061220003545.7053b05c.pochini@shiny.it>
In-Reply-To: <20061220003545.7053b05c.pochini@shiny.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini wrote:

>On Sun, 17 Dec 2006 14:41:27 +0100
>Giuliano Pochini <pochini@shiny.it> wrote:
>
>  
>
>>I have a dual G4 MDD mac running linux 2.6.19. When I boot with maxcpus=1 and
>>then I issue "echo 1 >/sys/devices/system/cpu/cpu1/online" the second CPU is
>>put online without errors, but it stays idle+wait=100% and of course
>>user+system+nice=0%. It works fine without maxcpus=1. No problems with 2.6.18.
>>
>>I saw that there are some cpu hotplug related changes in 2.6.19, but I have
>>no access to a non-ppc dual cpu box to check if the problem also affects
>>other architectures right now.
>>    
>>
>
>I tried to reproduce the problem on an intel box, but I couldn't. /sys
>contains only the cpu0 file if it boots with maxcpus=1.
>  
>
On powerpc, when maxcpus=1 is passed, it does not reflect that change in 
cpu_possible_map. This possible bitmap is created based on device-tree. 
Where as on i386, it does. I.e, cpu_possible_map contains only one cpu. 
/sys entries will be created based on cpu_possible_map (I think). Hence, 
you noticed only cpu0 entry on Intel box. 

- Haren

>
>--
>Giuliano.
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  
>
