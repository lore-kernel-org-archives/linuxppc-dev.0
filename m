Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 969AC2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 11:03:48 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 2 Jun 2013 21:03:46 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E439A6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 21:03:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5313hel271440
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:03:43 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5313g0K004965
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 22:03:43 -0300
Date: Mon, 3 Jun 2013 09:03:41 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/23] powerpc/eeh: Refactor eeh_reset_pe_once()
Message-ID: <20130603010341.GA7958@shangw.(null)>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-9-git-send-email-shangw@linux.vnet.ibm.com>
 <1370060330.3766.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370060330.3766.5.camel@pasglop>
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

On Sat, Jun 01, 2013 at 02:18:50PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
>> The patch changes the criteria used to judge if the PE has been
>> resetted successfully. We needn't the PE status is exactly equal
>> to the combo: (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE).
>
>The comment above doesn't mean anything :-)
>
>I assume you meant to write "we shouldn't check that the
>returned PE status is exactly equal to the two flags X and Y,
>but instead only check that they are both set".
>

Thanks, Ben. I'll update it accordingly in next version :-)

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/eeh.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
>> index 39d2ea6..ffe34c4 100644
>> --- a/arch/powerpc/platforms/pseries/eeh.c
>> +++ b/arch/powerpc/platforms/pseries/eeh.c
>> @@ -527,7 +527,6 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
>>  	 * Partitionable Endpoint trumps hot-reset.
>>    	 */
>>  	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
>> -
>
>Unrelated churn
>

Ok. Will remove it in next version.

>>  	if (freset)
>>  		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
>>  	else
>> @@ -565,6 +564,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
>>   */
>>  int eeh_reset_pe(struct eeh_pe *pe)
>>  {
>> +	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>>  	int i, rc;
>>  
>>  	/* Take three shots at resetting the bus */
>> @@ -572,7 +572,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
>>  		eeh_reset_pe_once(pe);
>>  
>>  		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
>> -		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
>> +		if ((rc & flags) == flags)
>>  			return 0;
>>  
>>  		if (rc < 0) {

Thanks,
Gavin
