Return-Path: <prvs=0379e8dc59=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEB581A0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 19:59:58 +1100 (AEDT)
Message-ID: <5450AC85.40302@keymile.com>
Date: Wed, 29 Oct 2014 09:59:49 +0100
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
In-Reply-To: <1414537731.23458.120.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8
Cc: "Boschung, Rainer" <Rainer.Boschung@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>,
 Linux I2C <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/29/2014 12:08 AM, Scott Wood wrote:
> On Fri, 2014-10-17 at 11:27 +0200, Valentin Longchamp wrote:
>> With "fsl-i2c" compatibility the i2c frequency is not set
>> correctly, because it sets no prescaler. According to the AN2919 from
>> Freescale and the QorIQ (P2041) documentation, the source clock is 1/2
>> the platform clock. This implies that a prescaler of 2 must be used.
>>
>> This changes the compatibility of the qoriq-i2c .dtsi files to pick the
>> mpc8543, which uses the same driver but sets the correct prescaler.
>>
>> Signed-off-by: Rainer Boschung <rainer.boschung@keymile.com>
>> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
>> ---
>>
>>  arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi | 4 ++--
>>  arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
>> index 5f9bf7d..aa6c366 100644
>> --- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
>> +++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
>> @@ -36,7 +36,7 @@ i2c@118000 {
>>  	#address-cells = <1>;
>>  	#size-cells = <0>;
>>  	cell-index = <0>;
>> -	compatible = "fsl-i2c";
>> +	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
>>  	reg = <0x118000 0x100>;
>>  	interrupts = <38 2 0 0>;
>>  	dfsrr;
>> @@ -46,7 +46,7 @@ i2c@118100 {
>>  	#address-cells = <1>;
>>  	#size-cells = <0>;
>>  	cell-index = <1>;
>> -	compatible = "fsl-i2c";
>> +	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
>>  	reg = <0x118100 0x100>;
>>  	interrupts = <38 2 0 0>;
>>  	dfsrr;
> 
> Are all chips that use this dtsi 100% compatible with mpc8543's i2c, or
> just in ways the Linux driver cares about?

I have just looked briefly at the mpc8548 RM (covers mpc8543) and its i2c
controller looks the same as the qoriq's. I cannot however state if they are
100% compatible.

If we wanted to be on the safe side and strict (since we are not sure that the
hardware is 100% compatible), we maybe should add a fsl,qoriq-i2c compatible to
the driver that does the same as mpc8543-i2c.

> 
> What about fsl,mpc8544-i2c, which has additional special handling in the
> driver, but is only used in socrates.dts (not mpc8544ds.dts)?

>From the mpc8544 RM, this controller looks the same as the above 2, except for
the prescaler from the driver which is set to 3. As to why it is only used in
the socrates.dts, I cannot comment about it.

The prescaler is confirmed to be 3 by default by the Table 3 of the AN-219 for
the mpc8544.

> 
> What about pq3-i2c-*.dtsi?
> 

This is also interesting: from the AN-219 Table 4, some pq3 have a 2:1
(mcpc8536/43/45/47/48/67/68/72, plus p2020) prescaler where some don't
(mpc8533/44, where it can be 3:1 -default- or 2:1). However pq3-i2c-*.dtsi
defines no prescaler.

Now if I look at what files include these pq3-i2c-*.dtsi, I see some that are in
the the 2:1 list:
arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
arch/powerpc/boot/dts/fsl/p2020si-post.dtsi

I don't have any hardware to do some tests with these, but from my measurements
on our qoriq based system (P2041 SoC) I think that the generated I2C clocks for
the above SoC currently are not correct because of the ignored prescaler.

Valentin
