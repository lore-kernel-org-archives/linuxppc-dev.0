Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLQ904QsLzDvqY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 17:35:32 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tLQ8z6vkkz9t1T
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 17:35:31 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAJ6XtlC120120
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 01:35:29 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26tcw0r8uq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 01:35:28 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 23:35:28 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/64: Provide functions for accessing POWER9
 partition table
In-Reply-To: <20161119041954.GF29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
 <878tsgoobx.fsf@linux.vnet.ibm.com>
 <20161119041954.GF29462@fergus.ozlabs.ibm.com>
Date: Sat, 19 Nov 2016 12:05:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h974m0ye.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Fri, Nov 18, 2016 at 07:57:30PM +0530, Aneesh Kumar K.V wrote:
>> Paul Mackerras <paulus@ozlabs.org> writes:
>>  +
>> > +	/* Global flush of TLBs and partition table caches for this lpid */
>> > +	asm volatile("ptesync");
>> > +	asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : : "r"(0x800), "r" (lpid));
>> > +	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
>> > +}
>> 
>> 
>> It would be nice to convert that 0x800 to a documented IS value or better use
>> radix__flush_tlb_pid() ?
>
> Well, not radix__flush_tlb_pid - this isn't radix and it isn't a PID
> flush.  I could use TLBIEL_INVAL_SET_LPID except the name implies it's
> for tlbiel and this is a tlbie.
>

I wrote that wrong, we really don't have tlb_pid() what we have is tlb_lpid().

void radix__flush_tlb_lpid(unsigned long lpid)
{
	unsigned long rb,rs,prs,r;
	unsigned long ric = RIC_FLUSH_ALL;

	rb = 0x2 << PPC_BITLSHIFT(53); /* IS = 2 */
	rs = lpid & ((1UL << 32) - 1);
	prs = 0; /* partition scoped */
	r = 1;   /* raidx format */

	asm volatile("ptesync": : :"memory");
	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
	asm volatile("eieio; tlbsync; ptesync": : :"memory");
}
