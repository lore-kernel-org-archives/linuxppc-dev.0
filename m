Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69EBCDE180
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 23:11:30 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3OD6oRg031851
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 09:06:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3ODBQnk175738
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 09:11:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3ODBPpO021151
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 09:11:26 -0400
Date: Fri, 24 Apr 2009 09:10:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] i2c: i2c-ibm_iic message can be confusing
Message-ID: <20090424131023.GK3825@zod.rchland.ibm.com>
References: <20090202120159.2478d7af@lappy.seanm.ca>
	<20090417203600.1d0c5cf0@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090417203600.1d0c5cf0@lappy.seanm.ca>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 08:36:00PM -0400, Sean MacLennan wrote:
>Any update on the status of this patch? This patch was acked by Jean.
>
>The patchwork entry is http://patchwork.ozlabs.org/patch/21576/ and the
>original patch message is below.

Yeah, that's a bit annoying.  A case of too many trees again.

Ben,

Do you want to take this through your tree or should I take it through the
powerpc tree?  I'll be up-front and say silence will translate to 'powerpc tree'

josh

>
>Cheers,
>   Sean
>
>On Mon, 2 Feb 2009 12:01:59 -0500
>Sean MacLennan <smaclennan@pikatech.com> wrote:
>
>> This is a trivial patch that does not need to be in 2.6.29. While
>> tracking down an EEPROM problem, I found the messages confusing... it
>> looked like the EEPROM was being started before the I2C driver!
>> 
>> Here is an example:
>> 
>> at24 0-0052: 512 byte 24c04 EEPROM (writable)
>> ibm-iic ef600700.i2c: using standard (100 kHz) mode
>> ad7414 0-004a: chip found
>> 
>> It looks like the at24 starts first, then the i2c driver, then the
>> ad7414. By moving the message to after the of scan, we always get the
>> driver, then the devices.
>> 
>> Cheers,
>>    Sean
>> 
>> Print the i2c driver message before scanning for devices so that the
>> logs show the driver, then the devices. Currently you can get
>> device(s), driver, device(s).
>> 
>> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
>> ---
>> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c
>> b/drivers/i2c/busses/i2c-ibm_iic.c index 88f0db7..7fc0729 100644
>> --- a/drivers/i2c/busses/i2c-ibm_iic.c
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
>> @@ -756,12 +756,12 @@ static int __devinit iic_probe(struct of_device
>> *ofdev, goto error_cleanup;
>>  	}
>>  
>> -	/* Now register all the child nodes */
>> -	of_register_i2c_devices(adap, np);
>> -
>>  	dev_info(&ofdev->dev, "using %s mode\n",
>>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100
>> kHz)"); 
>> +	/* Now register all the child nodes */
>> +	of_register_i2c_devices(adap, np);
>> +
>>  	return 0;
>>  
>>  error_cleanup:
>>  
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
