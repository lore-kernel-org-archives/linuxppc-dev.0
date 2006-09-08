Return-Path: <sachinp@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B565D67B94
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 12:29:57 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k882Ts6T021308
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 22:29:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k882TsDf375062
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 20:29:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k882TreM018408
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 20:29:53 -0600
Message-ID: <4500D5A0.1010602@in.ibm.com>
Date: Fri, 08 Sep 2006 07:59:52 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] kdump : Support kernels having 64k page size.
References: <44FE15B0.3030909@in.ibm.com>	
	<1157511577.3661.7.camel@localhost.localdomain>	
	<44FE6700.8080504@us.ibm.com>	
	<1157590304.22705.267.camel@localhost.localdomain>	
	<4500C0BA.8060408@in.ibm.com>
	<1157677687.22705.364.camel@localhost.localdomain>
In-Reply-To: <1157677687.22705.364.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------060609060504010306040405"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060609060504010306040405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Fri, 2006-09-08 at 06:30 +0530, Sachin P. Sant wrote:
>   
>>> You should always do 64k regardless of the page size. I think we have
>>> some ABI requirements here for ELF sections to be 64k aligned anyway
>>> no ?
>>>
>>>   
>>>       
>> Ben are you aware of any doc where i can find more information. I 
>> checked the
>> 64Bit PowerPC ELF ABI doc but couldn't find any specific information about
>> this.
>>
>> Also other question is  If we create a 64k segment irrespective of page size
>> [ as compared to 32k currently ] we would be writing extra 32k even for
>> page size of 4K. Which means we have 32k less memory for the kdump
>> kernel. Wouldn't that be an issue ?
>>     
>
> 32k sounds like a drop of water in the kdump pool ...
>
> Ben.
>
>   
The following kernel patch [ along with a patch to kexec tools posted
seperately ]is required to generate proper core files using kdump on ppc64.

* Create a backup region of 64K size irrespective of the PAGE SIZE.
 At present 32K was used as backup size. In the case of 64K page size, 
second
  PT_LOAD segments starts at 32K and the first one is not page aligned.
  __ioremap() (crash_dump.c) fails if pfn = 0 which is the case for the 
second
  PT_LOAD segment. This is not an issue for 4K page size because the the 
first
  page (32K backup) is copied to second kernel memory and thus referencing
  with the second kernel pfn.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>

Thanks
-Sachin

--------------060609060504010306040405
Content-Type: text/plain;
 name="64k-backup-size-for-kdump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="64k-backup-size-for-kdump"

* Create a backup region of 64K size irrespective of the PAGE SIZE.
  At present 32K was used as backup size. In the case of 64K page size, second 
  PT_LOAD segments starts at 32K and the first one is not page aligned. 
  __ioremap() (crash_dump.c) fails if pfn = 0 which is the case for the second 
  PT_LOAD segment. This is not an issue for 4K page size because the the first 
  page (32K backup) is copied to second kernel memory and thus referencing 
  with the second kernel pfn. 

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/include/asm-powerpc/kdump.h b/include/asm-powerpc/kdump.h
--- a/include/asm-powerpc/kdump.h	2006-09-01 00:40:10.000000000 +0530
+++ b/include/asm-powerpc/kdump.h	2006-09-08 07:12:18.000000000 +0530
@@ -7,7 +7,7 @@
 /* How many bytes to reserve at zero for kdump. The reserve limit should
  * be greater or equal to the trampoline's end address.
  * Reserve to the end of the FWNMI area, see head_64.S */
-#define KDUMP_RESERVE_LIMIT	0x8000
+#define KDUMP_RESERVE_LIMIT	0x10000 /* 64K */
 
 #ifdef CONFIG_CRASH_DUMP
 

--------------060609060504010306040405--
