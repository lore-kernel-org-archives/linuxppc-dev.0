Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B999E2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 13:32:13 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 11 Jun 2013 21:32:11 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1BF1219D803E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 21:32:00 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C3W8Re152324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 21:32:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5C3W61f001471
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 21:32:07 -0600
Date: Wed, 12 Jun 2013 11:32:03 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/27] powerpc/eeh: I/O chip EEH state retrieval
Message-ID: <20130612033203.GA10000@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-16-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936224.8250.93.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370936224.8250.93.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 11, 2013 at 05:37:04PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
>> The patch adds I/O chip backend to retrieve the state for the
>> indicated PE. While the PE state is temperarily unavailable,
>> we return the default wait time (1000ms).
>> 
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/eeh-ioda.c |  102 ++++++++++++++++++++++++++++-
>>  1 files changed, 101 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> index e24622e..3c72321 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> @@ -125,10 +125,110 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
>>  	return ret;
>>  }
>>  
>> +/**
>> + * ioda_eeh_get_state - Retrieve the state of PE
>> + * @pe: EEH PE
>> + * @state: return value
>> + *
>> + * The PE's state should be retrieved from the PEEV, PEST
>> + * IODA tables. Since the OPAL has exported the function
>> + * to do it, it'd better to use that.
>> + */
>> +static int ioda_eeh_get_state(struct eeh_pe *pe, int *state)
>> +{
>
>So everywhere you have this "state" argument which isn't a state but a delay ...
>
>Moreover you only initialize it in one specific case and leave it otherwise
>uninitialized....
>
>At the very least, init it to 0 by default as to not leave a dangling
>"return argument" like that. However, I still have a problem with it:
>

Ok. I will update accordingly in upper layer (eeh-powernv.c)
	- Initialize it to value "0".
	- If necessary, return 1 second.

>> +	case OPAL_EEH_STOPPED_TEMP_UNAVAIL:
>> +		result |= EEH_STATE_UNAVAILABLE;
>> +		if (state)
>> +			*state = 1000;
>> +		break;
>
>This is the *only* case where we return anything here. Why do we bother
>then and not have the upper layer simply wait one second whenever it gets
>a temp unavailable result (btw, you didn't differenciate temp unavailable
>from permanently unavailable in your API).
>

We already defferentiated the permanent/temp availibility through the
return value from the function:
	- EEH_STATE_UNAVAILABLE: temporary unavailibility
	- EEH_STATE_NOT_SUPPORT: permanent unavailibility

The EEH core will handle the return value (from the function) accordingly.

>This has impacts on patch 18/27 which I'll cover here:
>
>> +/**
>> + * powernv_eeh_set_option - Initialize EEH or MMIO/DMA reenable
>> + * @pe: EEH PE
>> + * @option: operation to be issued
>> + *
>> + * The function is used to control the EEH functionality globally.
>> + * Currently, following options are support according to PAPR:
>> + * Enable EEH, Disable EEH, Enable MMIO and Enable DMA
>> + */
>> +static int powernv_eeh_set_option(struct eeh_pe *pe, int option)
>> +{
>> +	struct pci_controller *hose = pe->phb;
>> +	struct pnv_phb *phb = hose->private_data;
>> +	int ret = -EEXIST;
>> +
>> +	/*
>> +	 * What we need do is pass it down for hardware
>> +	 * implementation to handle it.
>> +	 */
>> +	if (phb->eeh_ops && phb->eeh_ops->set_option)
>> +		ret = phb->eeh_ops->set_option(pe, option);
>> +
>> +	return ret;
>> +}
>
>Should we implement something here ? IE. Should we look into
>disabling freezing in the PHB via the firmware ? Or we just don't care ?
>

We just don't care. If EEH functionality has been disabled, we shouldn't
run into the code.

>> +/**
>> + * powernv_eeh_get_pe_addr - Retrieve PE address
>> + * @pe: EEH PE
>> + *
>> + * Retrieve the PE address according to the given tranditional
>> + * PCI BDF (Bus/Device/Function) address.
>> + */
>> +static int powernv_eeh_get_pe_addr(struct eeh_pe *pe)
>> +{
>> +	return pe->addr;
>> +}
>>
>> +/**
>> + * powernv_eeh_get_state - Retrieve PE state
>> + * @pe: EEH PE
>> + * @state: return value
>> + *
>> + * Retrieve the state of the specified PE. For IODA-compitable
>> + * platform, it should be retrieved from IODA table. Therefore,
>> + * we prefer passing down to hardware implementation to handle
>> + * it.
>> + */
>> +static int powernv_eeh_get_state(struct eeh_pe *pe, int *state)
>> +{
>> +	struct pci_controller *hose = pe->phb;
>> +	struct pnv_phb *phb = hose->private_data;
>> +	int ret = EEH_STATE_NOT_SUPPORT;
>> +
>> +	if (phb->eeh_ops && phb->eeh_ops->get_state)
>> +		ret = phb->eeh_ops->get_state(pe, state);
>> +
>> +	return ret;
>> +}
>
>Same comments about "state" which is really "delay" and is probably
>not necessary at all ...
>

We need the "delay" in future to support PowerKVM guest. If the
specified PE is being reset, we rely on the delay to hold the
powerkvm guest for a while until the PE reset is done.

>> +/**
>> + * powernv_eeh_reset - Reset the specified PE
>> + * @pe: EEH PE
>> + * @option: reset option
>> + *
>> + * Reset the specified PE
>> + */
>> +static int powernv_eeh_reset(struct eeh_pe *pe, int option)
>> +{
>> +	struct pci_controller *hose = pe->phb;
>> +	struct pnv_phb *phb = hose->private_data;
>> +	int ret = -EEXIST;
>> +
>> +	if (phb->eeh_ops && phb->eeh_ops->reset)
>> +		ret = phb->eeh_ops->reset(pe, option);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * powernv_eeh_wait_state - Wait for PE state
>> + * @pe: EEH PE
>> + * @max_wait: maximal period in microsecond
>> + *
>> + * Wait for the state of associated PE. It might take some time
>> + * to retrieve the PE's state.
>> + */
>> +static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
>> +{
>> +	int ret;
>> +	int mwait;
>> +
>> +	while (1) {
>> +		ret = powernv_eeh_get_state(pe, &mwait);
>> +
>> +		/*
>> +		 * If the PE's state is temporarily unavailable,
>> +		 * we have to wait for the specified time. Otherwise,
>> +		 * the PE's state will be returned immediately.
>> +		 */
>> +		if (ret != EEH_STATE_UNAVAILABLE)
>> +			return ret;
>
>So here we do a compare, while ret is actually a bit mask ...
>
>In fact, ret should be named state_mask or something like that for clarity
>and you should do a bit test here. Also do you want to diffenciate
>permanent unavailability from temp. unavailability ?
>
>> +		max_wait -= mwait;
>
>You decrement max_wait but never test it or use it. You probably mean to
>
>  - Limit mwait to max_wait
>  - If mwait is 0, return
>

Yeah, I will change the code accordingly in next revision.

>> +		msleep(mwait);
>> +	}
>> +
>> +	return EEH_STATE_NOT_SUPPORT;
>> +}
>> +
>> +/**
>> + * powernv_eeh_get_log - Retrieve error log
>> + * @pe: EEH PE
>> + * @severity: temporary or permanent error log
>> + * @drv_log: driver log to be combined with retrieved error log
>> + * @len: length of driver log
>> + *
>> + * Retrieve the temporary or permanent error from the PE.
>> + */
>> +static int powernv_eeh_get_log(struct eeh_pe *pe, int severity,
>> +			char *drv_log, unsigned long len)
>> +{
>> +	struct pci_controller *hose = pe->phb;
>> +	struct pnv_phb *phb = hose->private_data;
>> +	int ret = -EEXIST;
>> +
>> +	if (phb->eeh_ops && phb->eeh_ops->get_log)
>> +		ret = phb->eeh_ops->get_log(pe, severity, drv_log, len);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * powernv_eeh_configure_bridge - Configure PCI bridges in the indicated PE
>> + * @pe: EEH PE
>> + *
>> + * The function will be called to reconfigure the bridges included
>> + * in the specified PE so that the mulfunctional PE would be recovered
>> + * again.
>> + */
>> +static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
>> +{
>> +	struct pci_controller *hose = pe->phb;
>> +	struct pnv_phb *phb = hose->private_data;
>> +	int ret = 0;
>> +
>> +	if (phb->eeh_ops && phb->eeh_ops->configure_bridge)
>> +		ret = phb->eeh_ops->configure_bridge(pe);
>> +
>> +	return ret;
>> +}

Thanks,
Gavin
