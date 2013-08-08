Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 766F92C009F
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 13:40:53 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 8 Aug 2013 13:27:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 926002CE8057
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 13:40:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r783Oxtk1769736
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 13:24:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r783eno8021143
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 13:40:50 +1000
Message-ID: <5203133F.8000808@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 09:10:47 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 7/9] powerpc: Decode and save machine check event.
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093913.5389.80206.stgit@mars.in.ibm.com>
 <1375900904.18333.26.camel@snotra.buserror.net>
In-Reply-To: <1375900904.18333.26.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2013 12:11 AM, Scott Wood wrote:
> On Wed, 2013-08-07 at 15:09 +0530, Mahesh J Salgaonkar wrote:
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index a1aba53..0b5b04a 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -35,7 +35,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
>>  				   misc_$(CONFIG_WORD_SIZE).o vdso32/
>>  obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
>>  				   signal_64.o ptrace32.o \
>> -				   paca.o nvram_64.o firmware.o
>> +				   paca.o nvram_64.o firmware.o mce.o
> 
> What happens when we build mce.o on book3e?
> 
> Please don't take things that are specific to certain hardware and try
> to apply them to all powerpc.

sure. I will move it under obj-$(CONFIG_PPC_BOOK3S_64).

> 
> For that matter, it would be nice if book3s-specific (or POWER-specific)
> patches had that in the subject prefix, just as booke-specific patches
> do.

Sure will follow this for future versions.

Thanks,
-Mahesh.
