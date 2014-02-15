Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 959AD2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 11:56:04 +1100 (EST)
Message-ID: <52FEBA62.1080702@huawei.com>
Date: Sat, 15 Feb 2014 08:52:50 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/6] PCI,
 acpiphp: Use list_for_each_entry() for bus traversal
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
 <20140214182316.GB31093@google.com>
In-Reply-To: <20140214182316.GB31093@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Russell King <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>,
 linux-pcmcia@lists.infradead.org, Hanjun Guo <guohanjun@huawei.com>,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/2/15 2:23, Bjorn Helgaas wrote:
> On Thu, Feb 13, 2014 at 09:13:58PM +0800, Yijing Wang wrote:
>> Replace list_for_each() + pci_bus_b() with the simpler
>> list_for_each_entry().
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> I applied all six of these (please include a 0/6 cover letter in the
> future; that's a nice place to note that I applied things) to
> pci/list-for-each-entry for v3.15, thanks!

Thanks, I will add cover letter in the next time, sorry.

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
>> -- 
>> 1.7.1
>>
>>
> 
> 


-- 
Thanks!
Yijing
