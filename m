Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0A652C04FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:30:17 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 15:21:01 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CC8432BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:30:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3N5U6X115073308
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:30:06 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3N5UBcX006740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:30:11 +1000
Message-ID: <51761C57.8080307@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 10:59:59 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
References: <20130419114410.19115.35846.stgit@hegdevasant>
 <1366677610.2886.8.camel@pasglop>
In-Reply-To: <1366677610.2886.8.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2013 06:10 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-04-19 at 17:14 +0530, Vasant Hegde wrote:
>> Add new return code to rtas_flash to indicate firmware entitlement
>> expiry. This will be used by the update_flash script to return
>> appropriate message to the user.
>
> What's the point of that patch ? It adds a definition to a private .c
> file not exposed to user space and doesn't do anything with it ...
>

This is to keep our code in sync with PAPR. And when we get this return
code from "ibm,validate-flash-image" RTAS call, user space tools (update_flash) 
reads output buffer via /proc interface to display appropriate message to user.

-Vasant


> Ben.
>
>> Signed-off-by: Ananth N Mavinakayanahalli<ananth@in.ibm.com>
>> Signed-off-by: Vasant Hegde<hegdevasant@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kernel/rtas_flash.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
>> index a7020d2..0a12c16 100644
>> --- a/arch/powerpc/kernel/rtas_flash.c
>> +++ b/arch/powerpc/kernel/rtas_flash.c
>> @@ -64,6 +64,7 @@
>>   #define VALIDATE_TMP_COMMIT_DL 4     /* Validate Return Status */
>>   #define VALIDATE_TMP_COMMIT    5     /* Validate Return Status */
>>   #define VALIDATE_TMP_UPDATE_DL 6     /* Validate Return Status */
>> +#define VALIDATE_OUT_OF_WRNTY  7     /* Validate Return Status */
>>
>>   /* ibm,manage-flash-image operation tokens */
>>   #define RTAS_REJECT_TMP_IMG   0
>
>
