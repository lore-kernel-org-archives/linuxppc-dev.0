Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB9252C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 13:21:03 +1100 (EST)
Message-ID: <52FD7D3D.4030409@huawei.com>
Date: Fri, 14 Feb 2014 10:19:41 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] PCI,
 acpiphp: Use list_for_each_entry() for bus traversal
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
 <2601738.3Ek05F9oo5@vostro.rjw.lan>
In-Reply-To: <2601738.3Ek05F9oo5@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Cc: Russell King <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>,
 linux-pcmcia@lists.infradead.org, Hanjun Guo <guohanjun@huawei.com>,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/2/14 7:54, Rafael J. Wysocki wrote:
> On Thursday, February 13, 2014 09:13:58 PM Yijing Wang wrote:
>> Replace list_for_each() + pci_bus_b() with the simpler
>> list_for_each_entry().
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> Looks reasonable to me.
> 
> Does it conflict with anything currently in linux-next (the linux-next branch
> of linux-pm.git in particular)?

Hi Rafael,
   I applied this to your linux-next branch successfully . No conflicts found.

Thanks!
Yijing.

> 
>> ---
>>  drivers/pci/hotplug/acpiphp_glue.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> index cd929ae..aee6a0a 100644
>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> @@ -450,7 +450,7 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
>>   */
>>  static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
>>  {
>> -	struct list_head *tmp;
>> +	struct pci_bus *tmp;
>>  	unsigned char max, n;
>>  
>>  	/*
>> @@ -463,8 +463,8 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
>>  	 */
>>  	max = bus->busn_res.start;
>>  
>> -	list_for_each(tmp, &bus->children) {
>> -		n = pci_bus_max_busnr(pci_bus_b(tmp));
>> +	list_for_each_entry(tmp, &bus->children, node) {
>> +		n = pci_bus_max_busnr(tmp);
>>  		if (n > max)
>>  			max = n;
>>  	}
>>
> 


-- 
Thanks!
Yijing
