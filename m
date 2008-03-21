Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D1FEADDFB2
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 23:59:38 +1100 (EST)
Message-ID: <47E3B189.6060002@ru.mvista.com>
Date: Fri, 21 Mar 2008 16:00:57 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
In-Reply-To: <fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Grant Likely wrote:

> On Thu, Mar 20, 2008 at 8:43 AM, John Linn <john.linn@xilinx.com> wrote:

>>The Xilinx 16550 uart core is not a standard 16550, because it uses
>> word-based addressing rather than byte-based addressing.  As a result,
>> it is not compatible with the open firmware 'ns16550' compatible
>> binding.  This code introduces new bindings, which pass the correct
>> register base and regshift properties to the uart driver to enable
>> this core to be used.  Doing this cleanly required some refactoring of
>> the existing code.

> Personally, I'm not fond of this approach.  There is already some
> traction to using the reg-shift property to specify spacing, and I
> think it would be appropriate to also define a reg-offset property to
> handle the +3 offset and then let the xilinx 16550 nodes use those.

    That's making things only worse than the mere "reg-shift" idea. I think 
that both are totally wrong. Everything about the programming interface should 
be said in the "compatible" and possibly "model" properties. of_serial driver 
should recognize them and pass the necessary details to 8250.c. As for me, I'm 
strongly against plaguing the device tree with the *Linux driver 
implementation specifics* (despite I was trying this with MTD -- there it 
seemed somewhat more grounded :-).

> More comments below.

>> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>> Signed-off-by: John Linn <john.linn@xilinx.com>

>> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
>> index 2efb892..910c94f 100644
>> --- a/drivers/serial/of_serial.c
>> +++ b/drivers/serial/of_serial.c

[...]

>>        return 0;
>>  }
>> @@ -81,8 +82,9 @@ static int __devinit of_platform_serial_probe(struct of_device *ofdev,
>>        if (info == NULL)
>>                return -ENOMEM;
>>
>> -       port_type = (unsigned long)id->data;
>> -       ret = of_platform_serial_setup(ofdev, port_type, &port);
>> +       memcpy(info, id->data, sizeof(struct of_serial_info));
>> +       port_type = info->type;
>> +       ret = of_platform_serial_setup(ofdev, info, &port);
>>        if (ret)
>>                goto out;
>>
>> @@ -100,7 +102,6 @@ static int __devinit of_platform_serial_probe(struct of_device *ofdev,
>>        if (ret < 0)
>>                goto out;
>>
>> -       info->type = port_type;
>>        info->line = ret;
>>        ofdev->dev.driver_data = info;
>>        return 0;
>> @@ -128,15 +129,33 @@ static int of_platform_serial_remove(struct of_device *ofdev)
>>        return 0;
>>  }
>>
>> +static struct of_serial_info __devinitdata ns8250_info = { .type = PORT_8250 };
>> +static struct of_serial_info __devinitdata ns16450_info = { .type = PORT_16450 };
>> +static struct of_serial_info __devinitdata ns16550_info = { .type = PORT_16550 };
>> +static struct of_serial_info __devinitdata ns16750_info = { .type = PORT_16750 };
>> +static struct of_serial_info __devinitdata xilinx_16550_info = {
>> +       .type = PORT_16550,
>> +       .regshift = 2,
>> +       .regoffset = 3,

    I see that the data is already encoded in the driver itself, so I agree 
with the patch.

>> +};
>> +static struct of_serial_info __devinitdata unknown_info = { .type = PORT_UNKNOWN };

> In support of my argument; the fact that you need a table of data says
> to me that this data should really be encoded in the device tree.  :-)

    Not at all.

> Cheers,
> g.

WBR, Sergei
