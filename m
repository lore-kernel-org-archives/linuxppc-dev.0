Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfXt66Pp3zDq7b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 02:34:54 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BFY3Mv097296
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 10:34:52 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g2fa3c2cw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 10:34:51 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 11 Feb 2018 08:34:51 -0700
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
To: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
 <20180211235944.14c2be39@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 21:04:42 +0530
MIME-Version: 1.0
In-Reply-To: <20180211235944.14c2be39@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ba493b6c-c61a-5097-e896-5ae3f0128b3a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/11/2018 07:29 PM, Nicholas Piggin wrote:
> On Sat, 10 Feb 2018 13:54:27 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> In preparation for the following patch which will fix an issue on
>> the 8xx by re-using the 'slices', this patch enhances the
>> 'slices' implementation to support 32 bits CPUs.
>>
>> On PPC32, the address space is limited to 4Gbytes, hence only the low
>> slices will be used.
>>
>> This patch moves "slices" functions prototypes from page64.h to slice.h
>>
>> The high slices use bitmaps. As bitmap functions are not prepared to
>> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
>> slice_bitmap_xxx() functions which will void on PPC32
> 
> On this last point, I think it would be better to put these with the
> existing slice bitmap functions in slice.c and just have a few #ifdefs
> for SLICE_NUM_HIGH == 0.
> 

We went back and forth with that. IMHO, we should avoid as much #ifdef 
as possible across platforms. It helps to understand the platform 
restrictions better as we have less and less access to these platforms. 
The above change indicates that nohash 32 wants to use the slice code 
and they have different restrictions. With that we now know that 
book3s64 and nohash 32 are the two different configs using slice code.

-aneesh
