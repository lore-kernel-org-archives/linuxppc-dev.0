Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id BF94BB7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 08:56:58 +1100 (EST)
Received: by ywh39 with SMTP id 39so3701688ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 13:56:55 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911191401.37531.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE44@Exchange.discretix.com>
	<200911191441.27581.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
	<c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 14:56:35 -0700
Message-ID: <fa686aa40911201356k3ac97283l3950cd27f5984b2c@mail.gmail.com>
Subject: Re: Bug in drivers/serial/of_serial.c?
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Linn <linnj@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[fixed top-posting nonsense  :-) ]

On Thu, Nov 19, 2009 at 10:22 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
>> index 02406ba..241be77 100644
>> --- a/drivers/serial/of_serial.c
>> +++ b/drivers/serial/of_serial.c
>> @@ -161,7 +161,9 @@ static int of_platform_serial_remove(struct
>> of_device *ofdev)
>>  static struct of_device_id __devinitdata of_platform_serial_table[] =
> {
>>       { .type = "serial", .compatible = "ns8250",   .data = (void
>> *)PORT_8250, },
>>       { .type = "serial", .compatible = "ns16450",  .data = (void
>> *)PORT_16450, },
>> +     { .type = "serial", .compatible = "xlnx,xps-uart16550-2.00.b",
>> .data = (void *)PORT_16550A, },
>>       { .type = "serial", .compatible = "ns16550",  .data = (void
>> *)PORT_16550, },
>> +     { .type = "serial", .compatible = "ns16550a", .data = (void
>> *)PORT_16550A, },
>>       { .type = "serial", .compatible = "ns16750",  .data = (void
>> *)PORT_16750, },
>>       { .type = "serial", .compatible = "ns16850",  .data = (void
>> *)PORT_16850, },
>>  #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
>
> NAK.

No, I wouldn't NAK this.  It is an appropriate fix to still support
older trees that use the ns16550 value.  Arnd, I've got no problem
with this being merged.

g.

>
> If the problem is in the device trees that are being generated, we
> should fix the issue there.
> We've been trying to avoid putting the fully specified IP versions in
> the kernel like this, since
> the IP changes so often.

Yes, the error is in the device tree generator... which is *exactly*
why the fully specified IP version is in the device tree; so that a
driver can work around bugs like this.  You're right that we avoid
specifying it to eliminate an explosion of xlnx,<device><version>
strings in the kernel; but it is perfectly safe to use in situations
like this.

As you also know, but it is worth stating here for the record, this is
also exactly why newer versions of the IP claim compatibility with
fully specified versions of older IP.  So that the list of strings
doesn't explode, but also so that it claims compatibility with a real
version of the device (not a made up string whose meaning can change
over time).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
