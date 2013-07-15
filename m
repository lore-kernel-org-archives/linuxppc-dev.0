Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E9AC2C017D
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 16:19:00 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 11:40:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4EFB5E0057
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 11:48:46 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6F6IoUl24838368
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 11:48:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6F6IqWb024132
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 06:18:53 GMT
Message-ID: <51E3942A.9040008@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 11:48:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix the corrupt r3 error during MCE handling.
References: <20130710130155.4993.61577.stgit@mars>
 <51DE4887.6050206@linux.vnet.ibm.com> <87k3ksjr1j.fsf@linux.vnet.ibm.com>
In-Reply-To: <87k3ksjr1j.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2013 11:36 AM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> On 07/10/2013 06:32 PM, Mahesh J Salgaonkar wrote:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> During Machine Check interrupt on pseries platform, R3 generally points to
>>> memory region inside RTAS (FWNMI) area. We see r3 corruption because when RTAS
>>> delivers the machine check exception it passes the address inside FWNMI area
>>> with the top most bit set. This patch fixes this issue by masking top two bit
>>> in machine check exception handler.
>>>
>>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/ras.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
>>> index 7b3cbde..721c058 100644
>>> --- a/arch/powerpc/platforms/pseries/ras.c
>>> +++ b/arch/powerpc/platforms/pseries/ras.c
>>> @@ -287,6 +287,9 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
>>>  	unsigned long *savep;
>>>  	struct rtas_error_log *h, *errhdr = NULL;
>>>
>>> +	/* Mask top two bits */
>>> +	regs->gpr[3] &= ~(0x3UL << 62);
>>
>> We need to replace this "62" with a shift macro specifying the significance
>> of these top two address bits in the real mode.
> 
> huh??
> 
> (gdb) p/t 0x3ull << 62
> $4 = 1100000000000000000000000000000000000000000000000000000000000000
> 
> Why you need an extra comment to explain 62. But yes, we can possibly
> write that this is an RTAS bug

62 was just to point at the top two address bits in the real mode. Extra comment
request was to specify what is the RTAS behaviour or bug with respect to those top
two bits and how we are dealing with them here in this fix.
