Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 869051A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:53:43 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Jan 2015 09:53:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E68572BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:53:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0KNreb638731950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:53:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0KNre2H030279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:53:40 +1100
Date: Wed, 21 Jan 2015 10:53:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
Message-ID: <20150120235338.GA5280@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150120225607.GA12174@shangw>
Cc: wenxiong@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2015 at 09:56:07AM +1100, Gavin Shan wrote:
>On Tue, Jan 20, 2015 at 10:28:16AM +0100, Benjamin Herrenschmidt wrote:
>>On Mon, 2015-01-19 at 09:47 +1100, Gavin Shan wrote:
>>> On pseries platform, the EEH reset backend pseries_eeh_reset() can
>>> be called in atomic context as follows. For this case, we should
>>> call udelay() instead of msleep() to avoid context switching.
>>> 
>>>      drivers/scsi/ipr.c::ipr_reset_slot_reset_done()
>>>      drivers/pci/pci.c::pci_set_pcie_reset_state()
>>>      arch/powerpc/kernel/eeh.c::pcibios_set_pcie_reset_state()
>>>      arch/powerpc/platforms/pseries/eeh_pseries.c::pseries_eeh_reset()
>>
>>It's not acceptable to introduce multi-millisecond delays at interrupt
>>time. In fact, we should generally not use udelay in such context.
>>
>>I understand that this is an exceptional error handling case but it's
>>still not right.
>>
>
>Yes, I agree it's unsafe to udelay for multi-milliseconds as the queued
>works in atomic context is expected to be completed as soon as possible.
>
>>Are there many other users of pci_set_pcie_reset_state() at interrupt
>>time ? Can we have a discussion with the PCI folks as to whether that
>>should be legal or not ?
>>
>>I'm tempted to require that it's made illegal.
>
>Currently, there are 2 drivers calling this function: IPR and misc/genwqe.
>Also, VFIO would call this function for IBM and Mellanox adapters in PowerKVM
>repository. For now, IPR driver is the only one call this function in atomic
>context. 
>
>Sure, I'll send one email to confirm with PCI folks. I guess it's illegal
>to call pci_set_pcie_reset_state() in atomic context. If it's the case,
>I'm afraid Wendy has to change IPR driver to replace the reset timer with
>something else (e.g. workqueue).
>

Another way is to drop the hold/settle delays for pcibios_set_pcie_reset_state()
and IPR relies on the timer interval to cover them. Wendy, could you please
let me know if it would work for you or not?

    Start reset timer;
    Timer expires, assert the reset. Restart the timer with assert delay;
    Timer expires, deassert the reset. Restart the timer with settle delay;
    Timer expires, ready for subsequent works;

Thanks,
Gavin

>>
>>Ben.
>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> Tested-by: Wen Xiong<wenxiong@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> index a6c7e19..67623a3 100644
>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> @@ -503,8 +503,7 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
>>>   */
>>>  static int pseries_eeh_reset(struct eeh_pe *pe, int option)
>>>  {
>>> -	int config_addr;
>>> -	int ret;
>>> +	int config_addr, delay, ret;
>>>  
>>>  	/* Figure out PE address */
>>>  	config_addr = pe->config_addr;
>>> @@ -528,9 +527,14 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
>>>  	/* We need reset hold or settlement delay */
>>>  	if (option == EEH_RESET_FUNDAMENTAL ||
>>>  	    option == EEH_RESET_HOT)
>>> -		msleep(EEH_PE_RST_HOLD_TIME);
>>> +		delay = EEH_PE_RST_HOLD_TIME;
>>> +	else
>>> +		delay = EEH_PE_RST_SETTLE_TIME;
>>> +
>>> +	if (in_atomic())
>>> +		udelay(delay * 1000);
>>>  	else
>>> -		msleep(EEH_PE_RST_SETTLE_TIME);
>>> +		msleep(delay);
>>>  
>>>  	return ret;
>>>  }
>>
>>
