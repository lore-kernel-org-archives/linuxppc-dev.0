Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tKNJl41LwzDvmq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 01:08:38 +1100 (AEDT)
Subject: Re: [RFC PATCH] of: base: add support to get machine model name
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
 <3670336.mMHByOpDl4@wuerfel>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
Date: Thu, 17 Nov 2016 14:08:30 +0000
MIME-Version: 1.0
In-Reply-To: <3670336.mMHByOpDl4@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/11/16 13:50, Arnd Bergmann wrote:
> On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
>> Currently platforms/drivers needing to get the machine model name are
>> replicating the same snippet of code. In some case, the OF reference
>> counting is either missing or incorrect.
>>
>> This patch adds support to read the machine model name either using
>> the "model" or the "compatible" property in the device tree root node.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I like the idea. One small comment:
>

Thanks. I prefer it as single patch but it can't be applied to any tree.
Any suggestions on handling this patch to fix the warning in -next ?

>> +int of_machine_get_model_name(const char **model)
>> +{
>> +	int error;
>> +	struct device_node *root;
>> +
>> +	root = of_find_node_by_path("/");
>> +	if (!root)
>> +		return -EINVAL;
>
> The global of_root variable points ot this already, and is defined
> in the same file, so I think we can just skip the lookup.
>

Ah right, will fix it.

-- 
Regards,
Sudeep
