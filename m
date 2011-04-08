Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0EF7EB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Apr 2011 00:38:36 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p38EMxe1016534
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 08:22:59 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p38EcUe6120842
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 08:38:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p38EcS1l017017
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 08:38:29 -0600
Message-ID: <4D9F1DE0.9030908@linux.vnet.ibm.com>
Date: Fri, 08 Apr 2011 07:38:24 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1]  powerpc/eeh: Add support for ibm,configure-pe RTAS
	call
References: <4D9CEE45.9000904@linux.vnet.ibm.com>
	<1302147331.2458.26.camel@pasglop>
In-Reply-To: <1302147331.2458.26.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/6/2011 8:35 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2011-04-06 at 15:50 -0700, Richard A Lary wrote:
>> From: Richard A. Lary<rlary@linux.vnet.ibm.com>
>>
>> Added support for ibm,configure-pe RTAS call introduced with
>> PAPR 2.2.
>
> Care to tell us a bit about the difference ? :-) There's nothing obvious
> in the code.... Also you added calls to rtas_configure_bridge() and
> eeh_restore_bars() to eeh_slot_error_Detail(), that might want some
> explanation as well.

I was directed by Platform Firmware team to use the new configure-pe call
on platforms which support it.  Other than that, all I can tell you is
what PAPR+ 2.5 has to say:

---
Section 7.3.12.2 ibm,configure-pe
This call has about the same semantics as the ibm,configure-bridge RTAS
call, except that it:
1. Has the additional semantics of bypassing the configuration process
    if the PE has previously not been reset by the platform as a result
    of entering the EEH Stopped State.
2. Configures all the configurations spaces within the PE, including those
    of the endpoint devices within the PE (see Requirement R1–7.3.12.2–3).

Thus, this RTAS call can be made at the beginning of any EEH processing.

---

The addition of calls to rtas_configure_bridge() and eeh_restore_bars()
were also added as directed by Platform Firmware team.
Platform Firmware advised these calls were required to allow access to
all devices under the Partitionable Endpoint by gather_pci_data()
on PCIe adapters which contain PCIe Switches/Bridges.

I have verified in testing that the addition of rtas_configure_bridge()
and eeh_restore_bars() do indeed allow gather_pci_data() to read config
space on every device under the PE, which returned all FF's prior
to addition of those calls.

> Cheers,
> Ben.
>
>> Signed-off-by: Richard A. Lary<rlary@linux.vnet.ibm.com>
>> ---
>>    arch/powerpc/platforms/pseries/eeh.c |   13 	12 +	1 -	0 !
>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> Index: b/arch/powerpc/platforms/pseries/eeh.c
>> ===================================================================
>> --- a/arch/powerpc/platforms/pseries/eeh.c
>> +++ b/arch/powerpc/platforms/pseries/eeh.c
>> @@ -95,6 +95,7 @@ static int ibm_slot_error_detail;
>>    static int ibm_get_config_addr_info;
>>    static int ibm_get_config_addr_info2;
>>    static int ibm_configure_bridge;
>> +static int ibm_configure_pe;
>>
>>    int eeh_subsystem_enabled;
>>    EXPORT_SYMBOL(eeh_subsystem_enabled);
>> @@ -263,6 +264,8 @@ void eeh_slot_error_detail(struct pci_dn
>>    	pci_regs_buf[0] = 0;
>>
>>    	rtas_pci_enable(pdn, EEH_THAW_MMIO);
>> +	rtas_configure_bridge(pdn);
>> +	eeh_restore_bars(pdn);
>>    	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
>>
>>    	rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
>> @@ -896,6 +899,7 @@ void
>>    rtas_configure_bridge(struct pci_dn *pdn)
>>    {
>>    	int config_addr;
>> +	int token;
>>    	int rc;
>>
>>    	/* Use PE configuration address, if present */
>> @@ -903,7 +907,13 @@ rtas_configure_bridge(struct pci_dn *pdn
>>    	if (pdn->eeh_pe_config_addr)
>>    		config_addr = pdn->eeh_pe_config_addr;
>>
>> -	rc = rtas_call(ibm_configure_bridge,3,1, NULL,
>> +	/* Use new configure-pe function, if supported */
>> +	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE)
>> +		token = ibm_configure_pe;
>> +	else
>> +		token = ibm_configure_bridge;
>> +
>> +	rc = rtas_call(token, 3, 1, NULL,
>>    	               config_addr,
>>    	               BUID_HI(pdn->phb->buid),
>>    	               BUID_LO(pdn->phb->buid));
>> @@ -1079,6 +1089,7 @@ void __init eeh_init(void)
>>    	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
>>    	ibm_get_config_addr_info2 = rtas_token("ibm,get-config-addr-info2");
>>    	ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
>> +	ibm_configure_pe = rtas_token("ibm,configure-pe");
>>
>>    	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
>>    		return;
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
