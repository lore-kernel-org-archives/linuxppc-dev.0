Return-Path: <javier@dowhile0.org>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXH2r548XzDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 23:49:56 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id d68so17096423ita.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 06:49:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLGC9sh9jhwtCHu1NE2z85cZh0CVXuMc9aohzCoxE_4fg@mail.gmail.com>
References: <20170522140208.24652-1-javier@dowhile0.org>
 <20170522140208.24652-20-javier@dowhile0.org>
 <CAL_JsqLGC9sh9jhwtCHu1NE2z85cZh0CVXuMc9aohzCoxE_4fg@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 23 May 2017 15:49:51 +0200
Message-ID: <CABxcv=nARWUrqSM=vsyrkPygKabcDGP4nTGdQFEEoBWaVLR5dg@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] powerpc/83xx: Add generic compatible string for
 I2C EEPROM
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Rob,

On Tue, May 23, 2017 at 3:42 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 22, 2017 at 9:02 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>> The at24 driver allows to register I2C EEPROM chips using different vendor
>> and devices, but the I2C subsystem does not take the vendor into account
>> when matching using the I2C table since it only has device entries.
>>
>> But when matching using an OF table, both the vendor and device has to be
>> taken into account so the driver defines only a set of compatible strings
>> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>>
>> So add this generic fallback to the device node compatible string to make
>> the device to match the driver using the OF device ID table.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>>
>> ---
>>
>> Changes in v4:
>> - Only use the atmel manufacturer in the compatible string instead of
>>   keeping the deprecated ones (Rob Herring).
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>  arch/powerpc/boot/dts/mpc8308_p1m.dts  | 2 +-
>>  arch/powerpc/boot/dts/mpc8349emitx.dts | 4 ++--
>>  arch/powerpc/boot/dts/mpc8377_rdb.dts  | 2 +-
>>  arch/powerpc/boot/dts/mpc8377_wlan.dts | 2 +-
>>  arch/powerpc/boot/dts/mpc8378_rdb.dts  | 2 +-
>>  arch/powerpc/boot/dts/mpc8379_rdb.dts  | 2 +-
>>  6 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
>> index 57f86cdf9f36..702ab4fc5b4a 100644
>> --- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
>> +++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
>> @@ -123,7 +123,7 @@
>>                         interrupt-parent = <&ipic>;
>>                         dfsrr;
>>                         fram@50 {
>> -                               compatible = "ramtron,24c64";
>> +                               compatible = "atmel,24c64";
>
> This should be '"ramtron,24c64", "atmel,24c64"'
>

Yes, I (hopefully) fixed all the occurrences in the v5 that I posted
today, you are cc'ed on that series too.

Again, sorry for misunderstanding your comment on v3.

Best regards,
Javier
