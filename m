Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn5Qy21RTzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:21:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] powerpc: dts: use #include "..." to include local DT
In-Reply-To: <CAK7LNARnkHTyAMXjPZnOxOkP_b8vc6qvYOv-wf_Fn0eaPSdpeA@mail.gmail.com>
References: <1495602744-18874-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNARnkHTyAMXjPZnOxOkP_b8vc6qvYOv-wf_Fn0eaPSdpeA@mail.gmail.com>
Date: Tue, 13 Jun 2017 20:21:45 +1000
Message-ID: <87r2yogpc6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Hi
>
> (+Anatolij Gustschin <agust@denx.de>)
>
>
> Ping.
> I am not 100% sure who is responsible for this,
> but somebody, could take a look at this patch, please?

Have you tested it actually works?

It sounds reasonable, and if it behaves as you describe there is no
change in behaviour, right?

cheers

> 2017-05-24 14:12 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Most of DT files in PowerPC use #include "..." to make pre-processor
>> include DT in the same directory, but we have 3 exceptional files
>> that use #include <...> for that.
>>
>> Fix them to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
>> dtc_cpp_flags.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/powerpc/boot/dts/ac14xx.dts     | 2 +-
>>  arch/powerpc/boot/dts/mpc5121ads.dts | 2 +-
>>  arch/powerpc/boot/dts/pdm360ng.dts   | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
>> index 27fcabc2f857..83bcfd865167 100644
>> --- a/arch/powerpc/boot/dts/ac14xx.dts
>> +++ b/arch/powerpc/boot/dts/ac14xx.dts
>> @@ -10,7 +10,7 @@
>>   */
>>
>>
>> -#include <mpc5121.dtsi>
>> +#include "mpc5121.dtsi"
>>
>>  / {
>>         model = "ac14xx";
>> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
>> index 75888ce2c792..73c30621429b 100644
>> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
>> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
>> @@ -9,7 +9,7 @@
>>   * option) any later version.
>>   */
>>
>> -#include <mpc5121.dtsi>
>> +#include "mpc5121.dtsi"
>>
>>  / {
>>         model = "mpc5121ads";
>> diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
>> index 0cec7244abe7..445b88114009 100644
>> --- a/arch/powerpc/boot/dts/pdm360ng.dts
>> +++ b/arch/powerpc/boot/dts/pdm360ng.dts
>> @@ -13,7 +13,7 @@
>>   * option) any later version.
>>   */
>>
>> -#include <mpc5121.dtsi>
>> +#include "mpc5121.dtsi"
>>
>>  / {
>>         model = "pdm360ng";
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> -- 
> Best Regards
> Masahiro Yamada
