Return-Path: <robherring2@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A2B502C02AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 23:57:18 +1000 (EST)
Received: by mail-wi0-f179.google.com with SMTP id hj3so6353555wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 06:57:13 -0700 (PDT)
Message-ID: <51DD6832.1060707@gmail.com>
Date: Wed, 10 Jul 2013 08:57:06 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Alexander Popov <a13xp0p0v88@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 Grant Likely <grant.likely@linaro.org>,
 Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Timur Tabi <timur@tabi.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [V2 2/2] powerpc/512x: add LocalPlus Bus FIFO device driver
References: <1373451678-20065-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130710134624.GC2615@book.gsilab.sittig.org>
In-Reply-To: <20130710134624.GC2615@book.gsilab.sittig.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 08:46 AM, Gerhard Sittig wrote:
> On Wed, Jul 10, 2013 at 14:21 +0400, Alexander Popov wrote:
>>
>> This is SCLPC device driver for the Freescale MPC512x.
>> It is needed for Direct Memory Access to the devices on LocalPlus Bus.
>>
>> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
>> ---
>>  arch/powerpc/boot/dts/mpc5121.dtsi            |   8 +-
>>  arch/powerpc/include/asm/mpc5121.h            |  32 ++
>>  arch/powerpc/platforms/512x/Kconfig           |   6 +
>>  arch/powerpc/platforms/512x/Makefile          |   1 +
>>  arch/powerpc/platforms/512x/mpc512x_lpbfifo.c | 485 ++++++++++++++++++++++++++
>>  5 files changed, 531 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
>>
>> diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
>> index bd14c00..6e0b0c0 100644
>> --- a/arch/powerpc/boot/dts/mpc5121.dtsi
>> +++ b/arch/powerpc/boot/dts/mpc5121.dtsi
>> @@ -261,7 +261,13 @@
>>  		/* LocalPlus controller */
>>  		lpc@10000 {
>>  			compatible = "fsl,mpc5121-lpc";
>> -			reg = <0x10000 0x200>;
>> +			reg = <0x10000 0x100>;
>> +		};
>> +
>> +		sclpc@10100 {
>> +			compatible = "fsl,mpc512x-lpbfifo";

The binding needs to be documented.

Rob
