Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23BA11A08D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jan 2015 20:57:40 +1100 (AEDT)
Message-ID: <1422093450.4949.89.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Sat, 24 Jan 2015 10:57:30 +0100
In-Reply-To: <20150123035029.GA19657@shangw>
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw> <20150120235338.GA5280@shangw>
 <20150123035029.GA19657@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, wenxiong@linux.vnet.ibm.com,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-23 at 14:50 +1100, Gavin Shan wrote:

> Messages from Brian for reference:
> 
> | The API has changed. I wrote the pci_set_pcie_reset_state API originally.
> | When this API was put in place initially, it was perfectly legal to call it
> | from an atomic context. Can you clarify why we have to have the delay in the
> | pci_set_pcie_reset_state function? Shouldn't it be the responsibility of the
> | callers to ensure a proper delay is used? This was always the case until
> | recently.
> 
> So please ignore this patch and I'll send another one, which is implemented in
> above approach.

I still think it's not a great idea to allow that API to be called in
atomic context.

Brian, the reset API for PCIe involves FW calls which might have to do
a bunch of stuff under the hood, including potentially significant
delays.

For example, under OPAL (and I suppose PowerVM), if doing a PERST, the
API calls will loop until the link is back up, at least when "releasing"
the reset line.

I wouldn't be surprised if on x86, similar kinds of ACPI calls are
needed which may not be the best thing to do in atomic context.

I don't see any specific performance issues with issuing resets, so I
would strongly advocate for changing the API requirements instead so
that it's called from a task context.

Cheers,
Ben.



> Thanks,
> Gavin
> 
> >>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >>>> Tested-by: Wen Xiong<wenxiong@linux.vnet.ibm.com>
> >>>> ---
> >>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 12 ++++++++----
> >>>>  1 file changed, 8 insertions(+), 4 deletions(-)
> >>>> 
> >>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> >>>> index a6c7e19..67623a3 100644
> >>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> >>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> >>>> @@ -503,8 +503,7 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
> >>>>   */
> >>>>  static int pseries_eeh_reset(struct eeh_pe *pe, int option)
> >>>>  {
> >>>> -	int config_addr;
> >>>> -	int ret;
> >>>> +	int config_addr, delay, ret;
> >>>>  
> >>>>  	/* Figure out PE address */
> >>>>  	config_addr = pe->config_addr;
> >>>> @@ -528,9 +527,14 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
> >>>>  	/* We need reset hold or settlement delay */
> >>>>  	if (option == EEH_RESET_FUNDAMENTAL ||
> >>>>  	    option == EEH_RESET_HOT)
> >>>> -		msleep(EEH_PE_RST_HOLD_TIME);
> >>>> +		delay = EEH_PE_RST_HOLD_TIME;
> >>>> +	else
> >>>> +		delay = EEH_PE_RST_SETTLE_TIME;
> >>>> +
> >>>> +	if (in_atomic())
> >>>> +		udelay(delay * 1000);
> >>>>  	else
> >>>> -		msleep(EEH_PE_RST_SETTLE_TIME);
> >>>> +		msleep(delay);
> >>>>  
> >>>>  	return ret;
> >>>>  }
> >>>
> >>>
