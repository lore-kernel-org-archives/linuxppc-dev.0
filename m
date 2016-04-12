Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkTFJ2G78zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 11:03:00 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q129so226532pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 18:03:00 -0700 (PDT)
Subject: Re: [PATCH 2/2] powerpc/drivers: Add driver for operator panel on FSP
 machines
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <1460338890-19693-1-git-send-email-sjitindarsingh@gmail.com>
 <1460338890-19693-2-git-send-email-sjitindarsingh@gmail.com>
 <570B35C0.9040205@au1.ibm.com>
Cc: arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <570C493D.1010405@gmail.com>
Date: Tue, 12 Apr 2016 11:02:53 +1000
MIME-Version: 1.0
In-Reply-To: <570B35C0.9040205@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/16 15:27, Andrew Donnellan wrote:
> On 11/04/16 11:41, Suraj Jitindar Singh wrote:
>> Implement new character device driver to allow access from user space
>> to the 2x16 character operator panel display present on powernv machines.
>
> Specifically, on IBM Power Systems machines with FSPs (see comments below).
>
>> This will allow status information to be presented on the display which
>> is visible to a user.
>>
>> The driver implements a 32 character buffer which a user can read/write
>> by accessing the device (/dev/oppanel). This buffer is then displayed on
>> the operator panel display. Any attempt to write past the 32nd position
>> will have no effect and attempts to write more than 32 characters will be
>> truncated. Valid characters are ascii: '.', '/', ':', '0-9', 'a-z',
>> 'A-Z'. All other characters are considered invalid and will be replaced
>> with '.'.
>
> For reference, the ASCII character whitelist is enforced by skiboot, not by the driver (see https://github.com/open-power/skiboot/blob/master/hw/fsp/fsp-op-panel.c#L217). It's been included ever since the first public release of skiboot, so this statement is true for all machines at present, though theoretically might not be true in future skiboots or alternative OPAL implementations (should someone be crazy enough to write one).
>
>> A write call past the 32nd character will return zero characters
>> written. A write call will not clear the display and it is up to the
>> user to put spaces (' ') where blank space is required. The device may
>> only be accessed by a single process at a time.
>>
>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>
> I reviewed an earlier version of this patch internally and Suraj has fixed a bunch of issues which I raised. I'm not hugely experienced with this, but all the obvious things I noticed have gone, so...
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> A couple of minor nitpicks below.

Thanks Andrew, will fix up the wording to align with your requests and improve clarity.
>
>> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>> index 3ec0766..8c91edf 100644
>> --- a/drivers/char/Kconfig
>> +++ b/drivers/char/Kconfig
>> @@ -178,6 +178,20 @@ config IBM_BSR
>>         of threads across a large system which avoids bouncing a cacheline
>>         between several cores on a system
>>
>> +config IBM_OP_PANEL
>> +    tristate "IBM POWER Operator Panel Display support"
>> +    depends on PPC_POWERNV
>> +    default m
>> +    help
>> +      If you say Y here, a special character device node /dev/oppanel will
>
> Add commas: "node, /dev/oppanel, will"
>
>> diff --git a/drivers/char/op-panel-powernv.c b/drivers/char/op-panel-powernv.c
>> new file mode 100644
>> index 0000000..cc72c5d
>> --- /dev/null
>> +++ b/drivers/char/op-panel-powernv.c
> [...]
>> +/*
>> + * This driver creates a character device (/dev/oppanel) which exposes the
>> + * operator panel display (2x16 character display) on IBM pSeries machines.
>
> I'd prefer "IBM Power Systems machines with FSPs" so as to avoid confusion with the Linux pseries platform, to be in line with current IBM branding, and to emphasise that it's only FSP machines (the Power Systems LC models are not).
>
> Hmm, perhaps also mention that in the Kconfig description too?
>
