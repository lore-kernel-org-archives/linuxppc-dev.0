Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x234.google.com (mail-ea0-x234.google.com
 [IPv6:2a00:1450:4013:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA0222C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 07:02:14 +1000 (EST)
Received: by mail-ea0-f180.google.com with SMTP id g10so1356699eak.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 14:02:08 -0700 (PDT)
Message-ID: <519D324D.6070903@gmail.com>
Date: Wed, 22 May 2013 23:02:05 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
In-Reply-To: <20130522201607.GA18823@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2013 10:16 PM, Jason Gunthorpe wrote:
> On Wed, May 22, 2013 at 10:04:02PM +0200, Sebastian Hesselbarth wrote:
>> Ethernet controllers found on Kirkwood SoCs not only suffer from loosing
>> MAC address register contents on clock gating but also some important
>> registers are reset to values that would break ethernet. This patch
>
> FWIW, we found that the bootloader has to write to PSC1, the driver
> doesn't work with the power on/reset value of the register. So I think
> it is safe to assume that all kirkwood bootloaders alter the value.

It is safe to assume the bootloader alters it, but that modification is
lost when clocks get gated. I assume on clock ungate, the controller is
reset. Saying this, I will double check Dove's reset value but looks 
like reset mess has been fixed in that later SoC.

> Our systems write the value 0x00638488 to PSC1.
>
> I looked at patching mv643xx_eth, but ran into the same complexity you
> did, it isn't clear what variants of this IP block have the
> register/etc.

For Orion SoCs it is quite clear to me, with Gregory Clement and Thomas
Petazzoni we could also confirm if it does any harm there if we
unconditionally clear it. But for PPC system controllers I have no
idea...

>> +	/* Kirkwood resets some registers on gated clocks. Especially
>> +	 * CLK125_BYPASS_EN must be cleared but is not available on
>> +	 * all other SoCs/System Controllers using this driver.
>> +	 */
>> +	if (of_machine_is_compatible("marvell,kirkwood"))
>> +		wrlp(mp, PORT_SERIAL_CONTROL1,
>> +		     rdlp(mp, PORT_SERIAL_CONTROL1)&  ~CLK125_BYPASS_EN);
>
> of_machine_is_compatible seems heavy handed, I would expect this to be
> based on the compatible string of the ethernet node itself, not the
> machine??

I have no strong opinion about checking the machine compatible or have
an extra compatible string for Kirkwood ethernet. Both would work fine
and are checked once upon probe anyway.

Sebastian
