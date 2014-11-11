Return-Path: <linux@roeck-us.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FDD01A00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 21:42:29 +1100 (AEDT)
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99247140170
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 21:42:28 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Xo8u1-003RoR-Hl
 for linuxppc-dev@ozlabs.org; Tue, 11 Nov 2014 10:42:25 +0000
Message-ID: <5461E80D.4010307@roeck-us.net>
Date: Tue, 11 Nov 2014 02:42:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 41/48] powerpc: Register with kernel power-off handler
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>	
 <1415583785-6980-42-git-send-email-linux@roeck-us.net>
 <1415691766.9757.1.camel@concordia>
In-Reply-To: <1415691766.9757.1.camel@concordia>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexander Graf <agraf@suse.de>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/10/2014 11:42 PM, Michael Ellerman wrote:
> On Sun, 2014-11-09 at 17:42 -0800, Guenter Roeck wrote:
>> Register with kernel power-off handler instead of setting pm_power_off
>> directly.
>>
>> If there is an indication that there can be more than one power-off handler,
>> use register_power_off_handler, otherwise use register_power_off_handler_simple
>> to register the power-off handler.
>>
>> If the power-off handler only resets or stops the system, select the fallback
>> priority to indicate that the power-off handler is one of last resort.
>> If the power-off handler powers off the system, select the default priority,
>> unless the power-off handler installation code suggests that there can be
>> more than one power-off handler and the new handler is only installed
>> conditionally. In this case, install the handler with low priority.
>>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Can you fold in the patch below. I know pm.h is included by device.h, so most
> things will already have it, but I'd rather be explicit.
>
> With that you can add my:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>

Done.

Thanks,
Guenter
