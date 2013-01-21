Return-Path: <kishon@ti.com>
Message-ID: <50FD43F5.1020208@ti.com>
Date: Mon, 21 Jan 2013 19:04:45 +0530
From: kishon <kishon@ti.com>
MIME-Version: 1.0
To: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 5/6] usb: otg: add device tree support to otg library
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-6-git-send-email-kishon@ti.com> <50FD40D1.8020405@ti.com>
In-Reply-To: <50FD40D1.8020405@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-doc@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk,
 linux-sh@vger.kernel.org, alexander.shishkin@linux.intel.com,
 stern@rowland.harvard.edu, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, rob.herring@calxeda.com, horms@verge.net.au,
 Marc Kleine-Budde <mkl@pengutronix.de>, haojian.zhuang@gmail.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 eric.y.miao@gmail.com, b-cousson@ti.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com,
 cbou@mail.ru, rob@landley.net, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 21 January 2013 06:51 PM, Roger Quadros wrote:
> On 01/16/2013 05:01 PM, Kishon Vijay Abraham I wrote:
>> Added an API devm_usb_get_phy_by_phandle(), to get usb phy by passing a
>> device node phandle value. This function will return a pointer to
>> the phy on success, -EPROBE_DEFER if there is a device_node for the phandle,
>> but the phy has not been added, or a ERR_PTR() otherwise.
>>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/usb/otg/otg.c   |   77 +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/usb/phy.h |    8 +++++
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
>> index dbf2043..e9799bb 100644
>> --- a/drivers/usb/otg/otg.c
>> +++ b/drivers/usb/otg/otg.c
>> @@ -13,7 +13,9 @@
>>   #include <linux/export.h>
>>   #include <linux/err.h>
>>   #include <linux/device.h>
>> +#include <linux/module.h>
>>   #include <linux/slab.h>
>> +#include <linux/of.h>
>>
>>   #include <linux/usb/otg.h>
>>
>> @@ -34,6 +36,20 @@ static struct usb_phy *__usb_find_phy(struct device *dev, u8 index)
>>   	return ERR_PTR(-ENODEV);
>>   }
>>
>> +static struct usb_phy *__of_usb_find_phy(struct device_node *node)
>> +{
>> +	struct usb_phy  *phy;
>> +
>> +	list_for_each_entry(phy, &phy_list, head) {
>> +		if (node != phy->dev->of_node)
>> +			continue;
>> +
>> +		return phy;
>> +	}
>> +
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>>   static void devm_usb_phy_release(struct device *dev, void *res)
>>   {
>>   	struct usb_phy *phy = *(struct usb_phy **)res;
>> @@ -109,6 +125,67 @@ err0:
>>   }
>>   EXPORT_SYMBOL(usb_get_phy);
>>
>> + /**
>> + * devm_usb_get_phy_by_phandle - find the USB PHY by phandle
>> + * @dev - device that requests this phy
>> + * @phandle - name of the property holding the phy phandle value
>> + * @index - the index of the phy
>> + *
>> + * Returns the phy driver associated with the given phandle value,
>> + * after getting a refcount to it, -ENODEV if there is no such phy or
>> + * -EPROBE_DEFER if there is a phandle to the phy, but the device is
>> + * not yet loaded. While at that, it also associates the device with
>> + * the phy using devres. On driver detach, release function is invoked
>> + * on the devres data, then, devres data is freed.
>> + *
>> + * For use by USB host and peripheral drivers.
>> + */
>> +struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
>> +	const char *phandle, u8 index)
>> +{
>> +	struct usb_phy	*phy = NULL, **ptr;
>> +	unsigned long	flags;
>> +	struct device_node *node;
>> +
>> +	if (!dev->of_node) {
>> +		dev_dbg(dev, "device does not have a device node entry\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	node = of_parse_phandle(dev->of_node, phandle, index);
>> +	if (!node) {
>> +		dev_dbg(dev, "failed to get %s phandle in %s node\n", phandle,
>> +			dev->of_node->full_name);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	ptr = devres_alloc(devm_usb_phy_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr) {
>> +		dev_dbg(dev, "failed to allocate memory for devres\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>
> I fail to understand why you need ptr at all and why do devres_alloc()
> for it.

Thats how we create a "managed device resource". You can have a look at 
Documentation/driver-model/devres.txt and drivers/base/devres.c.

I'm not sure if that is what you are looking for :-P

Thanks
Kishon
