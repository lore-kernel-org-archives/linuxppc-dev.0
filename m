Return-Path: <clg@fr.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C79341A0BF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 21:54:32 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 23 Feb 2015 10:54:28 -0000
Message-ID: <54EB06C8.2080705@fr.ibm.com>
Date: Mon, 23 Feb 2015 11:54:00 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
 <20150220165212.GE22752@roeck-us.net> <54E795FA.1090005@fr.ibm.com>
 <54E7C8C7.40001@roeck-us.net> <54E83051.9080107@fr.ibm.com>
 <54E865EC.60101@roeck-us.net>
In-Reply-To: <54E865EC.60101@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2015 12:03 PM, Guenter Roeck wrote:
> On 02/20/2015 11:14 PM, Cedric Le Goater wrote:
>> On 02/21/2015 12:52 AM, Guenter Roeck wrote:
>>> On 02/20/2015 12:15 PM, Cedric Le Goater wrote:
>>>> On 02/20/2015 05:52 PM, Guenter Roeck wrote:
>>>>> On Fri, Feb 20, 2015 at 04:07:34PM +0100, Cédric Le Goater wrote:
>>>>>> Hello !
>>>>>>
>>>>>> These patches rework the ibmpowernv driver to support the new device
>>>>>> tree as proposed by this patchset on the skiboot mailing list :
>>>>>>
>>>>>>     https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html
>>>>>>
>>>>>> They are based on Linux 3.19 and were tested on IBM Power and Open Power
>>>>>> systems running trusty.
>>>>>>
>>>>>> The main issue is that the new device tree is incompatible with the
>>>>>> previous ibmpowernv drivers. The consequence is no powernv sensors
>>>>>> on systems with such a opal/linux configuration.
>>>>>>
>>>>> I don't think that would be acceptable. There must be lots of such
>>>>> systems out there. Why does it have to be incompatible ?
>>>>> Can't it support both the old and new versions ?
>>>>
>>>> I should have provided more explanation in the Linux patchset. Sorry
>>>> for that. Here is the rationale behind this brutal code change.
>>>>
>>>> The initial ibmpowernv driver was designed in the early days of the
>>>> powernv platform and the device tree it is using to expose the sensors
>>>> has some limitations that makes it difficult to add new ones. The current
>>>> layout of the device tree is also tightly coupled to IBM Power systems
>>>> and their service processor (FSP). Open Power systems are different and
>>>> need a different solution.
>>>>
>>>> It is to get more sensors out the P8 (and there are quite a few) that
>>>> the OPAL patchset [1] proposes a new device tree. On the Linux side, it
>>>> feels simpler to make a jump forward and break the compatibility than
>>>> to maintain multiple branches of code just to keep alive an early v1
>>>> of the ibmpowernv driver.
>>>>
>>>
>>> Would it possibly be appropriate to write a different driver for the new
>>> device tree ?
>>
>> Sure. That is an option.
>>
>> There are no conflicts between the trees so we can live with two drivers
>> using the same sensors/ root node. With time we will deprecate the initial
>> one.
>>
> You lost me a bit. Are you saying you are going to replace the devicetree
> properties with something that is incompatible but retain the same
> compatible properties ? If so, how do you expect this to work ?
> How do you expect to be able to determine which version of devicetree
> is loaded, and thus which driver is needed ?
>
> I'll have to understand this way better. The link above doesn't explain
> what the differences are, nor how the driver is supposed to know what
> to do.
 
Sure. My bad. I did not provide enough information in this RFC. Thanks for
your patience ! 


The current hwmon driver ibmpowernv relies on a device tree provided by 
the OPAL firmware. Today, this tree has the following layout :

	ibm,opal/sensors/
	|-- amb-temp#1-data
	|   |-- compatible
	|   |-- linux,phandle
	|   |-- name
	|   |-- phandle
	|   `-- sensor-id
	|-- amb-temp#1-thrs
	|   |-- compatible
	|   |-- linux,phandle
	|   |-- name
	|   |-- phandle
	|   `-- sensor-id
	|-- cooling-fan#10-data
	|   |-- compatible
	|   |-- linux,phandle
	|   |-- name
	|   |-- phandle
	|   `-- sensor-id
	|-- cooling-fan#10-faulted
	|   |-- compatible
	|   |-- linux,phandle
	|   |-- name
	|   |-- phandle
	|   `-- sensor-id
	|-- cooling-fan#10-thrs
	|   |-- compatible
	|   |-- linux,phandle
	|   |-- name
	|   |-- phandle
	|   `-- sensor-id
	...

It has some limitations and we want to change it to something more flexible, 
giving us the ability to add new sensors. The new device tree layout is 
described here :

	https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html


Both layouts use the same root node "ibm,opal/sensors" but the underlying
nodes have nothing in common, which means that the current driver ibmpowernv
will not 'see' any sensors on a system with an OPAL firmware exposing the new 
device tree. One will need new code for it. 

We have a few options to add support for this new tree :

 1. modify the current driver to parse the two trees. It seems overly complex 
    and the resulting code will be a pain to maintain. 

 2. add a new driver. As the two drivers can cohabitate, it is a viable solution.
    We will let the old driver rot in its corner and deprecate it one day. Kind
    of ugly to keep this code around.

 3. replace the current driver with a new one. The simplest and most brutal but 
    it also means we loose sensor support for IBM P8 systems running the old OPAL 
    firmware. I don't think it is a problem as these systems are bound to update 
    their firmware due to the amount of development currently being done on the 
    OPAL side.

    Open Power systems are not impacted.


Is that clearer ? and I would go for option 3.

Thanks,

C.
   






C. 
