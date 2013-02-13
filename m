Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0D9D2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 14:24:24 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Feb 2013 08:52:39 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A5BA8394004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 08:54:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1D3OEKF28246044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 08:54:14 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1D3OGCm012681
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 14:24:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Make context bits depend on virtual addr
 size.
In-Reply-To: <1360701185.2035.10.camel@pasglop>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360701185.2035.10.camel@pasglop>
Date: Wed, 13 Feb 2013 08:54:16 +0530
Message-ID: <87sj50kian.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2013-02-13 at 00:01 +0530, Aneesh Kumar K.V wrote:
>> + * Be careful with this value. This determines the VSID_MODULUS_*  and that
>> + * need to be co-prime with VSID_MULTIPLIER*
>> + */
>> +#if defined(CONFIG_POWER6_CPU) || defined(CONFIG_POWER7_CPU)
>> +/*
>> + * Even if cpu support 68 bits, we limit this to 66 because
>> + * we support only 2^19 context.
>> + */
>> +#define MAX_VIRTUAL_ADDR_BITS 66
>> +#else
>> +/* power4,power 5 and cell is 65 */
>> +#define MAX_VIRTUAL_ADDR_BITS 65
>> +#endif
>> +
>
> A compile option ? Really ? Ugh...

I actually wanted that to be done in Kconfig.cputype, but haven't found
a nice way to do it. Considering we are switching between only two
values, I was thinking an #ifdef would work.

-aneesh
