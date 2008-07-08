Return-Path: <mmlnx@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63A11DDFB6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 01:56:40 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m68FuaJn031379
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 11:56:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m68Fuadk169194
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 11:56:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m68FuZMo013099
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 11:56:36 -0400
Message-ID: <48738E32.2000703@us.ibm.com>
Date: Tue, 08 Jul 2008 08:56:34 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linasvepstas@gmail.com
Subject: Re: [PATCH] Restore PERR/SERR bit settings during EEH device recovery
References: <4872DC9C.4000706@us.ibm.com>
	<3ae3aa420807080638t41e8851bx2ad061dd5a4e0279@mail.gmail.com>
In-Reply-To: <3ae3aa420807080638t41e8851bx2ad061dd5a4e0279@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> 2008/7/7 Mike Mason <mmlnx@us.ibm.com>:
>> The following patch restores the PERR and SERR bits in the PCI
>> command register during an EEH device recovery.
>> We have found at least one case (an Agilent test card) where the
>> PERR/SERR bits are set to 1 by firmware at boot time, but are
>> not restored to 1 during EEH recovery.
> 
> Any chance they should be zero, and were accidentally set to 1?
> In which case, you'd need an else clause, below.

I suppose it's possible.  I'll add your suggestion and resubmit.

Mike

> 
>> The patch fixes the
>> Agilent card problem.  It has been tested on several other EEH-enabled cards
>> with no regressions.
>>
>> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
>>
>> --- linux-2.6.26-rc9/arch/powerpc/platforms/pseries/eeh.c       2008-07-07
>> 16:06:57.000000000 -0700
>> +++ linux-2.6.26-rc9-new/arch/powerpc/platforms/pseries/eeh.c   2008-07-07
>> 16:11:10.000000000 -0700
>> @@ -812,6 +812,7 @@
>> static inline void __restore_bars (struct pci_dn *pdn)
>> {
>>        int i;
>> +       u32 cmd;
>>
>>        if (NULL==pdn->phb) return;
>>        for (i=4; i<10; i++) {
>> @@ -832,6 +833,15 @@
>>
>>        /* max latency, min grant, interrupt pin and line */
>>        rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
>> +
>> +       /* Restore PERR & SERR bits, some devices require it,
>> +          don't touch the other command bits */
>> +       rtas_read_config(pdn, PCI_COMMAND, 4, &cmd);
>> +       if (pdn->config_space[1] & PCI_COMMAND_PARITY)
>> +               cmd |= PCI_COMMAND_PARITY;
> 
> else cmd &= ~PCI_COMMAND_PARITY;
> 
>> +       if (pdn->config_space[1] & PCI_COMMAND_SERR)
>> +               cmd |= PCI_COMMAND_SERR;
> 
> else cmd &= ~PCI_COMMAND_SERR;
> 
>> +       rtas_write_config(pdn, PCI_COMMAND, 4, cmd);
>> }
> 
> Other than that, I'll add an
> 
> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> 
> --linas
