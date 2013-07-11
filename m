Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E9E32C02C1
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:34:40 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 11 Jul 2013 14:24:32 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 43F892CE804A
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:34:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6B4JOWe721386
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:19:25 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6B4YVYq007082
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:34:32 +1000
Message-ID: <51DE35D5.5070005@linux.vnet.ibm.com>
Date: Thu, 11 Jul 2013 10:04:29 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix the corrupt r3 error during MCE handling.
References: <20130710130155.4993.61577.stgit@mars>
 <8761wild20.fsf@linux.vnet.ibm.com>
In-Reply-To: <8761wild20.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 07/10/2013 07:41 PM, Aneesh Kumar K.V wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> During Machine Check interrupt on pseries platform, R3 generally points to
>> memory region inside RTAS (FWNMI) area. We see r3 corruption because when RTAS
>> delivers the machine check exception it passes the address inside FWNMI area
>> with the top most bit set. This patch fixes this issue by masking top two bit
>> in machine check exception handler.
> 
> I always got that error and used to wonder why I find FWNMI
> corrupt. IS this a rtas bug or is it documented in papr ?

Nope. There is no mention of it in PAPR. It looks like a bug in RTAS.

> 
> 
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
>> +
>>  	if (!VALID_FWNMI_BUFFER(regs->gpr[3])) {
>>  		printk(KERN_ERR "FWNMI: corrupt r3 0x%016lx\n", regs->gpr[3]);
>>  		return NULL;
>>
> 
> -aneesh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
