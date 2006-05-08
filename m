Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4E09A679F2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 04:47:57 +1000 (EST)
In-Reply-To: <20060505045134.022a3e66@vitb.ru.mvista.com>
References: <20060403152622.26013.14459.stgit@vitb.ru.mvista.com>
	<F785D5DD-4C81-48BE-B63C-FF72E2A648E9@freescale.com>
	<20060505045134.022a3e66@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CC73B08A-11D6-4F03-A17D-7D40623E0D58@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/2] PAL: Support of the fixed PHY
Date: Mon, 8 May 2006 13:47:47 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 4, 2006, at 19:51, Vitaly Bordug wrote:

> On Thu, 4 May 2006 19:21:12 -0500
> Andy Fleming <afleming@freescale.com> wrote:
>
>> [snip]
>>
>>> +	/* create phy_device and register it on the mdio bus */
>>> +	phydev = phy_device_create(new_bus, 0, 0);
>>> +
>>> +	/*
>>> +	 Put the phydev pointer into the fixed pack so that bus read/
>>> write code could be able
>>> +	 to access for instance attached netdev. Well it doesn't have  to
>>> do so, only in case
>>> +	 of utilizing user-specified link-update...
>>> +	 */
>>> +	fixed->phydev = phydev;
>>> +
>>> +	if(NULL == phydev) {
>>> +		err = -ENOMEM;
>>> +		goto bus_register_fail;
>>> +	}
>>
>> You're going to need to change this, because phydev isn't guaranteed
>> to be NULL in the event of a failure to allocate.  it will be ERR_PTR
>> (-ENOMEM).  I know you changed this in phy_device_create(), but I
>> have more on that later.  You should do:
>>
>> if (IS_ERR(phydev)) {
>> 	err = PTR_ERR(-ENOMEM);
>> 	goto bus_register_fail;
>> }
>>
>
> Assuming IS_ERR will shoot on NULL too, the code is not quite right 
> (see below) :)
> But I agree this check is odd - will fix.

IS_ERR should be 0 if phydev is NULL.  At least, that is my  
interpretation of the code:

#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
static inline long IS_ERR(const void *ptr)
{
         return IS_ERR_VALUE((unsigned long)ptr);
}


>
>
>> [snip]
>>
>>> +
>>> +	return 0;
>>> +
>>> +bus_register_fail:
>>> +	kfree(new_bus);
>>
>> You need to free regs and dev, too
>>
>>
> ok
>>
>>> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
>>> index 459443b..c87f89e 100644
>>> --- a/drivers/net/phy/mdio_bus.c
>>> +++ b/drivers/net/phy/mdio_bus.c
>>> @@ -66,7 +66,7 @@ int mdiobus_register(struct mii_bus *bus
>>>  		phydev = get_phy_device(bus, i);
>>>
>>>  		if (IS_ERR(phydev))
>>> -			return PTR_ERR(phydev);
>>> +			continue;
>>
>>
>> No.  Why'd you change that?  Now mdiobus_register doesn't return an
>> error if memory runs out.  Here's how the system works:
>> get_phy_device() can return one of three things:
>>
>> 1) A pointer to a newly allocated phy_device
>> 2) a NULL pointer, indicating that there is no PHY at that address
>> (indicated by the bus returning all Fs)
>> 3) an error (due to bus read failure, or to memory allocation
>> failure, as indicated by PTR_ERR(phydev)
>>
>> This change has several issues:
>> 1) due to the change below, IS_ERR(phydev) is never true
>> 2) If you continue, mdiobus_register() will not inform its caller
>> that it failed.
>>
>
> I am not really stick to this change, but it simply does not work  
> otherwise.
> I want the whole bus to be scanned, and the code scans until first  
> fail, and returns error when there's no phy. Hereby, having phy's  
> on 0 and 3 I end up with only 0 registered on bus. So maybe check  
> for NULL and continue, check for err and return... Will inquire and  
> fix - no big deal.


I don't think you've understood the code.  Was this happening to  
you?  Because mdiobus_register scans every PHY.  If get_phy_device  
returns an error, it means that it failed to allocate memory, or it  
failed to manipulate the bus.  Both are terminal errors, since it  
means that either you can't allocate a device, or you can't actually  
read from the bus.  And that means mdiobus_register() needs to return  
failure.  Actually, it looks like there's a memory leak if that happens.

The behavior you suggest is what happens:  If there is an error, the  
loop terminates.  If it returned NULL, then the rest of the loop  
doesn't execute (except for setting bus->phymap[i];


>
>>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/
>>> phy_device.c
>>> index 7da0e3d..0dffecf 100644
>>> --- a/drivers/net/phy/phy_device.c
>>> +++ b/drivers/net/phy/phy_device.c
>>> @@ -46,6 +46,35 @@ static struct phy_driver genphy_driver;
>>>  extern int mdio_bus_init(void);
>>>  extern void mdio_bus_exit(void);
>>>
>>> +struct phy_device* phy_device_create(struct mii_bus *bus, int
>>> addr, int phy_id)
>>> +{
>>> +	struct phy_device *dev;
>>> +	/* We allocate the device, and initialize the
>>> +	 * default values */
>>> +	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
>>> +
>>> +	if (NULL == dev)
>>> +		return NULL;
>>
>> Here's the other change which breaks get_phy_device().  Now it
>> doesn't return an error when it fails to allocate memory, it returns
>> NULL.  Which mdiobus_register doesn't interpret as an error (because
>> it isn't.  Not every PHY address has a device on it).
>>
>
> OK, this part definitely needs a bit attention and a rework. So,  
> phy_device_create should return PTR_ERR if it fail to allocate  
> memory, and we need to keep get_phy_device() return as it was, right?

Were you having problems with the code the old way?  Because I  
believe it should all just work as you want the way it was.  If not,  
we need to look into why NULL pointers were triggering IS_ERR() checks.

Andy
