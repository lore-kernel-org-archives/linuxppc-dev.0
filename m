Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7759E1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 22:55:00 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 09:54:55 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DFD341DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 06:54:48 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13BtVAn4956304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 09:55:32 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13BspA5027846
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 09:54:51 -0200
Subject: Re: [PATCH 1/2] powerpc/eeh: Check for EEH availability in
 eeh_add_device_early()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1453234700-27593-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160202224438.GA6888@gwshan>
Cc: paulus@samba.org, nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56B1EA8B.9040401@linux.vnet.ibm.com>
Date: Wed, 3 Feb 2016 09:54:51 -0200
MIME-Version: 1.0
In-Reply-To: <20160202224438.GA6888@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 08:44 PM, Gavin Shan wrote:
>> /**
>> + * eeh_available - Checks for the availability of EEH based on running
>> + * architecture.
>> + *
>> + * This routine should be used in case we need to check if EEH is
>> + * available in some situation, regardless if EEH is enabled or not.
>> + * For example, if we hotplug-add a PCI device on a machine with no
>> + * other PCI device, EEH won't be enabled, yet it's available if the
>> + * arch supports it.
>> + */
>> +static inline bool eeh_available(void)
>> +{
>> +	if (machine_is(pseries) || machine_is(powernv))
>> +		return true;
>> +	return false;
>> +}
>> +
>
> As I was told by somebody else before, the comments for static function
> needn't to be exported.
>

Thanks for the advice Gavin, but I didn't get it. What means comments 
not being exported? For sure I can change the comment if desired, but I 
can't see any issue with it.


>> +/**
>>   * eeh_add_device_early - Enable EEH for the indicated device node
>>   * @pdn: PCI device node for which to set up EEH
>>   *
>> @@ -1072,7 +1089,7 @@ void eeh_add_device_early(struct pci_dn *pdn)
>> 	struct pci_controller *phb;
>> 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>
>> -	if (!edev || !eeh_enabled())
>> +	if (!edev || !eeh_available())
>> 		return;
>>
>> 	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
>
> The change here seems not correct enough. Before the changes, eeh_add_device_early()
> does nothing if EEH is disabled on pSeries. With the changes applied, the EEH device
> (edev) will be scanned even EEH is disabled on pSeries.
>
>  From the code changes, I didn't figure out the real problem you try to fix. Cell
> platform doesn't have flag EEH_PROBE_MODE_DEVTREE. So the function does nothing
> on Cell platform except calling into pdn_to_eeh_dev(). I'm not sure if the kernel
> crashed in pdn_to_eeh_dev() on Cell platform?

Gavin, thanks for the comments. Seems your commit d91dafc02f4 
("powerpc/eeh: Delay probing EEH device during hotplug") solved the 
problem with Cell arch. Notice that Michael pointed the issue with Cell 
and fixed it by commit 89a51df5ab1d ("powerpc/eeh: Fix crash in 
eeh_add_device_early() on Cell").

But you commit is recent than Michael's and since it adds the check for 
EEH_PROBE_MODE_DEVTREE, the Cell crash doesn't happen anymore. It's my 
bad, I should have checked the dates of commits to figure your commit is 
recent than Michael's one.

Anyway, the modification proposed by this patch is useless if we revert 
Michael's commit then. Gavin and Michael, are you OK if I revert it?

The reason for the revert is that we can't check for eeh_enabled() here 
- imagine the following scenario: we boot a machine with no PCI device, 
then, we hotplug-add a PCI device. When we reach eeh_add_device_early(), 
the function eeh_enabled() is false because at boot time we had no PCI 
devices so EEH is not initialized/enabled.

Cheers,


Guilherme
