Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68F592C0151
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 14:01:09 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Apr 2013 09:25:18 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 54064E0054
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 09:32:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3H40s8Y66388198
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 09:30:55 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3H40vf8021779
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 14:00:58 +1000
Message-ID: <516E1E6C.2040106@linux.vnet.ibm.com>
Date: Wed, 17 Apr 2013 09:30:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V2 2/5] powerpc, perf: Add basic assembly code to read
 BHRB entries on POWER8
References: <1366127650-1952-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366127650-1952-3-git-send-email-khandual@linux.vnet.ibm.com>
 <AAEA07FE-7530-46D3-B2FC-B3FD8EC2C6E2@kernel.crashing.org>
In-Reply-To: <AAEA07FE-7530-46D3-B2FC-B3FD8EC2C6E2@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2013 10:53 PM, Segher Boessenkool wrote:
>> +/* r3 = n  (where n = [0-1023])
>> + * The maximum number of BHRB entries supported with PPC_MFBHRBE
>> instruction
>> + * is 1024. We have limited number of table entries here as POWER8
>> implements
>> + * 32 BHRB entries.
>> + */
>> +
>> +/* .global read_bhrb */
>> +_GLOBAL(read_bhrb)
>> +    cmpldi    r3,1023
> 
> This should be 31, since that is the last entry in the table below.

Hey Segher,

Would fix this in the next version. Thanks for pointing it out.

Regards
Anshuman
