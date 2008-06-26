Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id DF833DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 13:32:22 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so9080696rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 20:32:21 -0700 (PDT)
Message-ID: <4b73d43f0806252032p15d390c9g177c74705564211@mail.gmail.com>
Date: Wed, 25 Jun 2008 21:32:21 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] powerpc: pci config cleanup
In-Reply-To: <1214441634.32022.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214425164-1267-1-git-send-email-jrigby@freescale.com>
	<1214425164-1267-2-git-send-email-jrigby@freescale.com>
	<1214441634.32022.2.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Michael, your explanation makes things make more sense.  I was
just a half intelligent monkey trying to replicate the existing logic.
 I think your explanation also answers Ben's question also.

On Wed, Jun 25, 2008 at 6:53 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Wed, 2008-06-25 at 14:19 -0600, John Rigby wrote:
>> change
>>     bool "PCI support" if <long ugly expression>
>> to
>>     bool "PCI support" if PPC_HAS_PCI
>>
>> and add select PPC_HAS_PCI to all the config nodes that
>> were previously in the PCI if expression
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 3934e26..fa9bd91 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -542,11 +542,12 @@ config FSL_LBC
>>  config MCA
>>       bool
>>
>> +config PPC_HAS_PCI
>> +     bool
>> +
>>  config PCI
>> -     bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
>> -             || PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
>> -             || PPC_PS3 || 44x
>> -     default y if !40x && !CPM2 && !8xx && !PPC_MPC512x && !PPC_83xx \
>> +     bool "PCI support" if PPC_HAS_PCI
>> +     default y if !40x && !CPM2 && !8xx && !PPC_83xx \
>>               && !PPC_85xx && !PPC_86xx
>>       default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
>>       default PCI_QSPAN if !4xx && !CPM2 && 8xx
>
> This is backward I think. The bool says whether you get to choose if you
> have PCI, not if you have it. It should be called CAN_CHOOSE_PCI or
> something.
>
> For example this makes no sense:
>
>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>> index 07fe5b6..e205066 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -7,6 +7,7 @@ config PPC_PSERIES
>>       select RTAS_ERROR_LOGGING
>>       select PPC_UDBG_16550
>>       select PPC_NATIVE
>> +     select PPC_HAS_PCI if EMBEDDED
>
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
