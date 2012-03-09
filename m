Return-Path: <jwboyer@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37F49B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 22:40:41 +1100 (EST)
Received: by qcha6 with SMTP id a6so1041886qch.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2012 03:40:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1331264145.3105.56.camel@pasglop>
References: <1331263072-9612-1-git-send-email-mla@apm.com>
 <1331264145.3105.56.camel@pasglop>
Date: Fri, 9 Mar 2012 06:40:38 -0500
Message-ID: <CA+5PVA4sbuRsxO7Qv5RU8J+i1QcYGjS9O45ev-JRJz6B=i4Mfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/44x: Fix PCI MSI support for Maui APM821xx
 SoC and Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, open-source-review@apm.com,
 Tirumala R Marri <tmarri@apm.com>, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>,
 Mai La <mla@apm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 8, 2012 at 10:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2012-03-09 at 10:17 +0700, Mai La wrote:
>> This patch consists of:
>> - Enable PCI MSI as default for Bluestone board
>> - Define number of MSI interrupt for Maui APM821xx SoC using in Blueston=
e board
>> - Fix returning ENODEV as finding MSI node
>> - Fix MSI physical high and low address
>> - Keep MSI data logically
>>
>> Signed-off-by: Mai La <mla@apm.com>
>> ---
>
>> index 7b4df37..c86231e 100644
>> --- a/arch/powerpc/sysdev/Kconfig
>> +++ b/arch/powerpc/sysdev/Kconfig
>> @@ -20,6 +20,12 @@ config PPC_MSI_BITMAP
>> =A0 =A0 =A0 default y if FSL_PCI
>> =A0 =A0 =A0 default y if PPC4xx_MSI
>>
>> +config PPC4xx_NR_MSI_IRQS
>> + =A0 =A0 int "Number of PCI MSI interrupts"
>> + =A0 =A0 depends on PCI_MSI && PPC4xx_MSI
>> + =A0 =A0 default "4" if !APM821xx
>> + =A0 =A0 default "8" if APM821xx
>> +
>
> =A0.../...
>
>> +#define NR_MSI_IRQS CONFIG_PPC4xx_NR_MSI_IRQS
>
> ARGH.
>
> We asked to -NOT MAKE THIS A COMPILE TIME OPTION-

Actually, I asked for basically exactly above.  I was _wrong_ in asking,
but it was asked for.

> CONFIG_foo is as bad as your previous ifdef, in fact you just added a
> useless config option here.
>
> Make that number dynamic. Count the entries in the device-tree (or add
> a property with the number in it, whatever you fancy the most) but make
> it something detected at RUNTIME !!!!!

My apologies Mai.  Ben is correct here and I should have thought more
about my suggestion before I made it.

josh
