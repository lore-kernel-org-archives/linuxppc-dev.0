Return-Path: <stripathi@apm.com>
Received: from mail-wg0-f41.google.com (exprod5og120.obsmtp.com [64.18.0.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB22D1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 16:14:27 +1000 (AEST)
Received: by wgin8 with SMTP id n8so139538460wgi.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2015 23:14:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <19876f56-d3ce-4b70-9cb9-fcb43151d52d@BL2FFO11FD044.protection.gbl>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
 <1430456052-8888-2-git-send-email-stripathi@apm.com>
 <19876f56-d3ce-4b70-9cb9-fcb43151d52d@BL2FFO11FD044.protection.gbl>
Date: Mon, 4 May 2015 11:44:24 +0530
Message-ID: <CAOHikRBcO7mAYD7g8bFO9hLdXAeE4e+_GLvwiXHjWt0wxaOLDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
From: Suman Tripathi <stripathi@apm.com>
To: Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, May 4, 2015 at 11:33 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 05/01/2015 06:54 AM, Suman Tripathi wrote:
>> This patch adds the arasan sdhc nodes to reuse the of-arasan
>> driver for APM X-Gene SoC.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  arch/arm64/boot/dts/apm-mustang.dts |  4 ++++
>>  arch/arm64/boot/dts/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
>> index 8eb6d94..d0e52a9 100644
>> --- a/arch/arm64/boot/dts/apm-mustang.dts
>> +++ b/arch/arm64/boot/dts/apm-mustang.dts
>> @@ -44,3 +44,7 @@
>>  &xgenet {
>>       status = "ok";
>>  };
>> +
>> +&sdhc0 {
>> +     status = "ok";
>> +};
>> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
>> index 87d3205..d6c2216 100644
>> --- a/arch/arm64/boot/dts/apm-storm.dtsi
>> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
>> @@ -144,6 +144,40 @@
>>                               clock-output-names = "socplldiv2";
>>                       };
>>
>> +                     ahbclk: ahbclk@1f2ac000 {
>> +                             compatible = "apm,xgene-device-clock";
>> +                             #clock-cells = <1>;
>> +                             clocks = <&socplldiv2 0>;
>> +                             reg = <0x0 0x1f2ac000 0x0 0x1000
>> +                                     0x0 0x17000000 0x0 0x2000>;
>> +                             reg-names = "csr-reg", "div-reg";
>> +                             csr-offset = <0x0>;
>> +                             csr-mask = <0x1>;
>> +                             enable-offset = <0x8>;
>> +                             enable-mask = <0x1>;
>> +                             divider-offset = <0x164>;
>> +                             divider-width = <0x5>;
>> +                             divider-shift = <0x0>;
>> +                             clock-output-names = "ahbclk";
>> +                     };
>> +
>> +                     sdioclk: sdioclk@1f2ac000 {
>> +                             compatible = "apm,xgene-device-clock";
>> +                             #clock-cells = <1>;
>> +                             clocks = <&socplldiv2 0>;
>> +                             reg = <0x0 0x1f2ac000 0x0 0x1000
>> +                                     0x0 0x17000000 0x0 0x2000>;
>> +                             reg-names = "csr-reg", "div-reg";
>> +                             csr-offset = <0x0>;
>> +                             csr-mask = <0x2>;
>> +                             enable-offset = <0x8>;
>> +                             enable-mask = <0x2>;
>> +                             divider-offset = <0x178>;
>> +                             divider-width = <0x8>;
>> +                             divider-shift = <0x0>;
>> +                             clock-output-names = "sdioclk";
>> +                     };
>> +
>>                       qmlclk: qmlclk {
>>                               compatible = "apm,xgene-device-clock";
>>                               #clock-cells = <1>;
>> @@ -503,6 +537,16 @@
>>                       interrupts = <0x0 0x4f 0x4>;
>>               };
>>
>> +             sdhc0: sdhc@1c000000 {
>> +                     device_type = "sdhc";
>> +                     compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
>
> I would just add 4.9a here because you want to use that quirks. We can
> add some quirks to 8.9a version if any new problem arises.

Make sense too. Our's is 4.9a. Thanks for the catch.

>
> Thanks,
> Michal



-- 
Thanks,
with regards,
Suman Tripathi
