Return-Path: <haren@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0442E67B59
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 12:18:16 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k692IDIv023020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 22:18:13 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k692HQHX149984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 20:17:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k692IDcs016658
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 20:18:13 -0600
Message-ID: <44B06756.8090301@us.ibm.com>
Date: Sat, 08 Jul 2006 19:17:58 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: EOI and clear IPI fix in xics_teardown_cpu()
References: <44B05BD0.304@us.ibm.com>
	<1152409027.4128.14.camel@localhost.localdomain>
In-Reply-To: <1152409027.4128.14.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------010801080604040403050600"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010801080604040403050600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>On Sat, 2006-07-08 at 18:28 -0700, Haren Myneni wrote:
>  
>
>>If OK, please sent this patch to upstream.
>>
>>Thanks
>>Haren
>>
>>When invoked kdump boot, plpar_eoi() call is getting failed and calling 
>>panic().
>>Kernel panic - not syncing: bad return code EOI - rc = -4, value=ff000000
>>
>>The issue is with the desc->chip->eoi(XICS_IPI) in xics_teardown_cpu(). 
>>Instead of passing the virq to desc->chip->eoi(), XICS_IPI is used. 
>>Also, clear IPI in xics_teardown_cpu() got removed recently (in 
>>2.6.17-git25).  Noticed in some crash dump cases (Ex: initiate kdump 
>>boot using soft-reset and xmon is enabled), IPI is not cleared for some 
>>CPU(s) before starting the kdump boot. Hence, causing the kdump boot 
>>failure.
>>    
>>
>
>It's already fixed in my latest patch that fixes some issues with the
>new irq rework. Hopefully, paul will send the patch upstream tomorrow
>after we had a chance to test it a bit more.
>
>Cheers,
>Ben
>
>  
>
Ok, Are you talking about the patch posted 
http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024350.html? Sorry, I 
did not notice it before I posted. Yes, it is fixed passing proper ipi 
value to desc->chip->eoi(). But, we also to need to clear IPI  in 
xics_teardown_cpu(). 
 
Thanks
Haren





--------------010801080604040403050600
Content-Type: text/x-patch;
 name="ppc64-kdump-clear-IPI-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-kdump-clear-IPI-fix.patch"

--- 2618-rc1/arch/powerpc/platforms/pseries/xics.c.orig	2006-07-08 13:14:29.000000000 -0700
+++ 2618-rc1/arch/powerpc/platforms/pseries/xics.c	2006-07-08 11:47:07.000000000 -0700
@@ -783,6 +783,14 @@ void xics_teardown_cpu(int secondary)
 	xics_set_cpu_priority(cpu, 0);
 
 	/*
+	 * Clear IPI
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_qirr_info(cpu, 0xff);
+	else
+		direct_qirr_info(cpu, 0xff);
+
+	/*
 	 * we need to EOI the IPI if we got here from kexec down IPI
 	 *
 	 * probably need to check all the other interrupts too

--------------010801080604040403050600--
