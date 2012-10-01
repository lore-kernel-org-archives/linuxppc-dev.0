Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B5C8C2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 17:39:26 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 11F583EE0AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 16:39:23 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F041745DE52
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 16:39:22 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C582E45DE4E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 16:39:22 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B59121DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 16:39:22 +0900 (JST)
Received: from g01jpexchkw04.g01.fujitsu.local
 (g01jpexchkw04.g01.fujitsu.local [10.0.194.43])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 711CD1DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 16:39:22 +0900 (JST)
Message-ID: <50694884.7090706@jp.fujitsu.com>
Date: Mon, 1 Oct 2012 16:38:44 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Ni zhan Chen <nizhan.chen@gmail.com>
Subject: Re: [RFC v9 PATCH 03/21] memory-hotplug: store the node id in
 acpi_memory_device
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-4-git-send-email-wency@cn.fujitsu.com>
 <506517C1.7050909@gmail.com>
In-Reply-To: <506517C1.7050909@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 len.brown@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chen,

2012/09/28 12:21, Ni zhan Chen wrote:
> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> The memory device has only one node id. Store the node id when
>> enable the memory device, and we can reuse it when removing the
>> memory device.
>
> one question:
> if use numa emulation, memory device will associated to one node or ...?

Memory device has only one node, even if you use numa emulation.

Thanks,
Yasuaki Ishimatsu

>
>>
>> CC: David Rientjes <rientjes@google.com>
>> CC: Jiang Liu <liuj97@gmail.com>
>> CC: Len Brown <len.brown@intel.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Christoph Lameter <cl@linux.com>
>> Cc: Minchan Kim <minchan.kim@gmail.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> ---
>>   drivers/acpi/acpi_memhotplug.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
>> index 2a7beac..7873832 100644
>> --- a/drivers/acpi/acpi_memhotplug.c
>> +++ b/drivers/acpi/acpi_memhotplug.c
>> @@ -83,6 +83,7 @@ struct acpi_memory_info {
>>   struct acpi_memory_device {
>>       struct acpi_device * device;
>>       unsigned int state;    /* State of the memory device */
>> +    int nid;
>>       struct list_head res_list;
>>   };
>> @@ -256,6 +257,9 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>>           info->enabled = 1;
>>           num_enabled++;
>>       }
>> +
>> +    mem_device->nid = node;
>> +
>>       if (!num_enabled) {
>>           printk(KERN_ERR PREFIX "add_memory failed\n");
>>           mem_device->state = MEMORY_INVALID_STATE;
>
