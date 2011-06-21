Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81A55B6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 06:30:46 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5LKORHL013976
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2011 14:24:27 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5LKUM1f293836
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2011 14:30:22 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5LEUKOC004249
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2011 08:30:21 -0600
Message-ID: <4E00FF58.7070802@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2011 15:30:16 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
	<20110615233417.GB6324@us.ibm.com>
	<20110616075114.GH8141@htj.dyndns.org>
	<4DFA0507.3090609@linux.vnet.ibm.com>
	<20110616152836.GA15268@us.ibm.com>
	<20110621160714.GA14174@us.ibm.com>
In-Reply-To: <20110621160714.GA14174@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jgarzik@pobox.com, wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	mbizon@freebox.fr, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks good to me. Jeff/Tejun - any issues with merging this?

Thanks,

Brian

On 06/21/2011 11:07 AM, Nishanth Aravamudan wrote:
> Ping on this -- Tejun, Brian, Jeff, this is a pretty annoying 2.6.39
> regression which it would be good to have fixed in 3.0.
> 
> Thanks,
> Nish
> 
> On 16.06.2011 [08:28:36 -0700], Nishanth Aravamudan wrote:
>> On 16.06.2011 [08:28:39 -0500], Brian King wrote:
>>> On 06/16/2011 02:51 AM, Tejun Heo wrote:
>>>> On Wed, Jun 15, 2011 at 04:34:17PM -0700, Nishanth Aravamudan wrote:
>>>>>> That looks like the right thing to do. For ipr's usage of
>>>>>> libata, we don't have the concept of a port frozen state, so this flag
>>>>>> should really never get set. The alternate way to fix this would be to
>>>>>> only set ATA_PFLAG_FROZEN in ata_port_alloc if ap->ops->error_handler
>>>>>> is not NULL.
>>>>>
>>>>> It seemed like ipr is as you say, but I wasn't sure if it was
>>>>> appropriate to make the change above in the common libata-scis code or
>>>>> not. I don't want to break some other device on accident.
>>>>>
>>>>> Also, I tried your suggestion, but I don't think that can happen in
>>>>> ata_port_alloc? ata_port_alloc is allocated ap itself, and it seems like
>>>>> ap->ops typically gets set only after ata_port_alloc returns?
>>>>
>>>> Maybe we can test error_handler in ata_sas_port_start()?
>>>
>>> Good point. Since libsas is converted to the new eh now, we would need to have
>>> this test.
>>
>> Commit 7b3a24c57d2eeda8dba9c205342b12689c4679f9 ("ahci: don't enable
>> port irq before handler is registered") caused a regression for CD-ROMs
>> attached to the IPR SATA bus on Power machines:
>>
>>   ata_port_alloc: ENTER
>>   ata_port_probe: ata1: bus probe begin
>>   ata1.00: ata_dev_read_id: ENTER
>>   ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>>   ata1.00: ata_dev_read_id: ENTER
>>   ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>>   ata1.00: limiting speed to UDMA7:PIO5
>>   ata1.00: ata_dev_read_id: ENTER
>>   ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>>   ata1.00: disabled
>>   ata_port_probe: ata1: bus probe end
>>   scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
>>
>> The FROZEN flag added in that commit is only cleared by the new EH code,
>> which is not used by ipr. Clear this flag in the SAS code if we don't
>> support new EH.
>>
>> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index d51f979..ebe1685 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3797,6 +3797,12 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
>>   */
>>  int ata_sas_port_start(struct ata_port *ap)
>>  {
>> +	/*
>> +	 * the port is marked as frozen at allocation time, but if we don't
>> +	 * have new eh, we won't thaw it
>> +	 */
>> +	if (!ap->ops->error_handler)
>> +		ap->pflags &= ~ATA_PFLAG_FROZEN;
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(ata_sas_port_start);
>>
>>
>> -- 
>> Nishanth Aravamudan <nacc@us.ibm.com>
>> IBM Linux Technology Center
> 


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
