Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C6406DDEB7
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 05:36:18 +1100 (EST)
Message-ID: <477FCE21.9080808@pikatech.com>
Date: Sat, 05 Jan 2008 13:36:17 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c-ibm_iic driver
References: <477EF225.4070505@pikatech.com> <200801051224.52693.arnd@arndb.de>
	<200801051349.34488.sr@denx.de> <200801051354.11202.arnd@arndb.de>
In-Reply-To: <200801051354.11202.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Saturday 05 January 2008, Stefan Roese wrote:
>   
>>> This is probably not specific enough. I'm rather sure that someone at IBM
>>> has implemented an i2c chip that this driver doesn't support. Maybe
>>>
>>>       .compatible = "ibm,405-iic"
>>>
>>> or similar would be a better thing to check for.
>>>       
>>         .compatible = "ibm,4xx-iic"
>>
>> please, since 405 and 440 have the same I2C controller.
>>
>>     
>
> But that's not how compatible properties work -- they should not
> contain wildcards. If you have different devices that are
> backwards compatible, you should list the older one in all
> newer devices, e.g. the 440 can list that it is compatible
> with both ibm,405-iic and ibm,440-iic. If there was an earlier
> 401 that had iic as well, you may even want to include that
> in the device tree.
>
> 	Arnd <><
>   
Ok. The 44x based .dts files do not list 405-iic, so would I think I 
will add two compatibility matches, one for 405 and one for 440EP. That 
way I do not break all the current .dts files. Everybody ok with that?

Cheers,
    Sean
