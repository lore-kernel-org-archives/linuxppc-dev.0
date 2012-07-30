Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 306F72C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 15:37:03 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Jul 2012 11:06:56 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6U5aSmD23724236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 11:06:29 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6U5aR4c024272
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 15:36:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V4 11/12] arch/powerpc: properly offset the context bits
 for 1T segemnts
In-Reply-To: <20120730005803.GB21364@bloggs.ozlabs.ibm.com>
References: <1343221085-30661-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343221085-30661-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120730005803.GB21364@bloggs.ozlabs.ibm.com>
Date: Mon, 30 Jul 2012 11:06:27 +0530
Message-ID: <873949n738.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Wed, Jul 25, 2012 at 06:28:04PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We should do rldimi r10,r9,USER_ESID_BITS,0 only after populating
>> r10 with ESID bits.
>
> This needs a lot more explanation as to what the problem is that this
> patch aims to fix.  Is it a problem today without your other patches,
> or is it introduced by previous patches?
>
> In any case I think there is an error in the patch, see below...
>
>>  0:	/* user address: proto-VSID = context << 15 | ESID. First check
>> @@ -155,13 +157,16 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>>  	ld	r9,PACACONTEXTID(r13)
>>  BEGIN_FTR_SECTION
>>  	cmpldi	r10,0x1000
>> +	bge	9f
>>  END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>>  	rldimi	r10,r9,USER_ESID_BITS,0
>> +	b	slb_finish_load
>>  BEGIN_FTR_SECTION
>> -	bge	slb_finish_load_1T
>> +9:
>> +	srdi	r10,r10,40-28		/* get 1T ESID */
>> +	rldimi	r10,r9,USER_ESID_BITS,0
>
> Shouldn't this one be USER_ESID_BITS_1T?  And in that case, since
> USER_ESID_BITS == USER_ESID_BITS_1T + 12, I think the patch would
> then introduce no change in behaviour (other than being slightly
> slower than the current code).  Or am I missing something? -- in
> that case we really need a longer and better explanation with the
> patch.

Ok I missed that we used USER_ESID_BITS there. This patch can be
dropped. I looked at the 1T code, and assumed that we were wrongly
shifting the context bits there.

-aneesh
