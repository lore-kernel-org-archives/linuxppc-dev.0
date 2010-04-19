Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55DBDB7D16
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Apr 2010 14:51:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3J4p72u006565
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Apr 2010 21:51:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3J50rvV020944
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Apr 2010 00:00:54 -0500 (CDT)
Message-ID: <4BCBE133.3010407@freescale.com>
Date: Mon, 19 Apr 2010 12:50:59 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/4] fsl_msi: fix the conflict of virt_msir's chip_data
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271644834.14835.40.camel@concordia>
In-Reply-To: <1271644834.14835.40.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/19/2010 10:40 AM, Michael Ellerman wrote:
> On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
>    
>> From: Zhao Chenhui<b26998@freescale.com>
>>
>> In fsl_of_msi_probe(), the virt_msir's chip_data have been stored
>> the pointer to struct mpic. We add a struct fsl_msi_cascade_data
>> to store the pointer to struct fsl_msi and msir_index.  Otherwise,
>> the pointer to struct mpic will be over-written, and will cause
>> problem when calling eoi() of the irq.
>>      
> I don't quite understand. Do you mean someone was overwriting
> handler_data somewhere?
>    

The patch at http://patchwork.ozlabs.org/patch/48794/ was overwriting 
the chip_data.  We move the newly added pointer to fsl_msi structure to 
the handler data.

>
>    
>> @@ -309,9 +319,19 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
>>   			break;
>>   		virt_msir = irq_of_parse_and_map(dev->node, i);
>>   		if (virt_msir != NO_IRQ) {
>> -			set_irq_data(virt_msir, (void *)i);
>> +			cascade_data = kzalloc(
>> +					sizeof(struct fsl_msi_cascade_data),
>> +					GFP_KERNEL);
>> +			if (!cascade_data) {
>> +				dev_err(&dev->dev,
>> +					"No memory for MSI cascade data\n");
>> +				err = -ENOMEM;
>> +				goto error_out;
>>      
> The error handling in this routine is not great, most of the setup is
> not torn down properly in the error paths AFAICS, this adds another.
>    

You are right.  Need to add a separate patch to fix all these.

Thanks.
- Leo
