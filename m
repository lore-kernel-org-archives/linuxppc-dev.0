Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 721962C009A
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 16:06:24 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 11:29:44 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5D0781258053
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 11:35:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6F66Enr32702570
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 11:36:14 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6F66GRY032224
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 16:06:17 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix the corrupt r3 error during MCE handling.
In-Reply-To: <51DE4887.6050206@linux.vnet.ibm.com>
References: <20130710130155.4993.61577.stgit@mars>
 <51DE4887.6050206@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 11:36:16 +0530
Message-ID: <87k3ksjr1j.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 07/10/2013 06:32 PM, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> 
>> During Machine Check interrupt on pseries platform, R3 generally points to
>> memory region inside RTAS (FWNMI) area. We see r3 corruption because when RTAS
>> delivers the machine check exception it passes the address inside FWNMI area
>> with the top most bit set. This patch fixes this issue by masking top two bit
>> in machine check exception handler.
>> 
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/ras.c |    3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
>> index 7b3cbde..721c058 100644
>> --- a/arch/powerpc/platforms/pseries/ras.c
>> +++ b/arch/powerpc/platforms/pseries/ras.c
>> @@ -287,6 +287,9 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
>>  	unsigned long *savep;
>>  	struct rtas_error_log *h, *errhdr = NULL;
>> 
>> +	/* Mask top two bits */
>> +	regs->gpr[3] &= ~(0x3UL << 62);
>
> We need to replace this "62" with a shift macro specifying the significance
> of these top two address bits in the real mode.

huh??

(gdb) p/t 0x3ull << 62
$4 = 1100000000000000000000000000000000000000000000000000000000000000

Why you need an extra comment to explain 62. But yes, we can possibly
write that this is an RTAS bug

-aneesh
