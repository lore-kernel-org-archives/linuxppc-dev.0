Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B69811A065B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 08:49:38 +1100 (AEDT)
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
To: Rob Herring <robherring2@gmail.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq+BnPEKkRgQX4+e0MA9dKLVLhy8rVF25Fr9yXL2jp+WLA@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5664AD69.6050702@roeck-us.net>
Date: Sun, 6 Dec 2015 13:49:29 -0800
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+BnPEKkRgQX4+e0MA9dKLVLhy8rVF25Fr9yXL2jp+WLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2015 12:28 PM, Rob Herring wrote:
> +Guenter
>
> On Wed, Nov 4, 2015 at 7:12 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> In current implementation, unflatten_dt_node() is called recursively
>> to unflatten device nodes in FDT blob. It's stress to limited stack
>> capacity.
>>
>> This avoids calling the function recursively, meaning the device
>> nodes are unflattened in one call on unflatten_dt_node(): two arrays
>> are introduced to track the parent path size and the device node of
>> current level of depth, which will be used by the device node on next
>> level of depth to be unflattened. Also, the parameter "poffset" and
>> "fpsize" are unused and dropped.
>
> Do you plan to respin the OF parts at least soon? There's another
> problem Guenter found that of_fdt_unflatten_tree is not re-entrant due
> to "depth" being static and this series fixes that. So I'd rather
> apply this and avoid adding a mutex if possible.
>

Hi Rob,

We see this problem in 4.1, so whatever patch you accept should be
back-ported to at least that release.

Any idea when this patch will be accepted ? We actively see the problem
in our kernel, so I'll need a solution soon. Otherwise I'll have to apply
my patch to our kernel and revert it as soon as the 'real' patch has been
back-ported.

Thanks,
Guenter
