Return-Path: <thunderbird2k@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id 83887DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 18:03:54 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id f33so332361fkf.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 01:03:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1239953159.7443.33.camel@pasglop>
References: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
	<1239953159.7443.33.camel@pasglop>
Date: Fri, 17 Apr 2009 10:03:52 +0200
Message-ID: <c8485d470904170103g35e331b0g95d83613ed4bc1f4@mail.gmail.com>
Subject: Re: pci32 code - early_*config*
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 9:25 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2009-04-15 at 01:17 -0500, Kumar Gala wrote:
>> Ben,
>>
>> I was looking at what I need to get some additional bits of PCI code
>> building w/your ppc64 booke patches. =A0One thing it looks like we need
>> is the early config cycle code. =A0The question I have is do we think we
>> still need the null_ops support? =A0Also do we think we every get called
>> with a NULL hose?
>>
>> This is fake_pci_bus() in arch/powerpc/kernel/pci_32.c
>
> Hrm.
>
> I'm not fan of the early config stuff, remind me why we need it ?
>
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

There are cases when it is really needed (or you would have to access
the address and data bus by hand). In my case I'm using a Xilinx PLB
soft-core and if certain options in the configuration header aren't
set (which aren't set by default) the soft-core is basically disabled.
Cases like this look like valid cases in which early config should be
used.

Roderick Colenbrander
