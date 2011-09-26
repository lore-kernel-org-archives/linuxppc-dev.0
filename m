Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D369B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 08:24:52 +1000 (EST)
Message-ID: <4E80FBAB.7080706@freescale.com>
Date: Mon, 26 Sep 2011 17:24:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
References: <1316806370-21067-1-git-send-email-agust@denx.de>	<CAOZdJXXw-YMFG4vVbYQKOtDYHtriaXe-=sz6YBivFXbp=mH2PQ@mail.gmail.com>
	<FAF4E48A-0966-4A6E-8D31-B30D07CB0746@kernel.crashing.org>
In-Reply-To: <FAF4E48A-0966-4A6E-8D31-B30D07CB0746@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Anatolij Gustschin <agust@denx.de>,
	Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/26/2011 05:12 PM, Kumar Gala wrote:
> 
> On Sep 25, 2011, at 12:06 PM, Tabi Timur-B04825 wrote:
> 
>> On Fri, Sep 23, 2011 at 2:32 PM, Anatolij Gustschin <agust@denx.de> wrote:
>>
>>> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
>>> index 1b393f4..b29d4f2 100644
>>> --- a/arch/powerpc/platforms/85xx/Kconfig
>>> +++ b/arch/powerpc/platforms/85xx/Kconfig
>>> @@ -80,7 +80,7 @@ config P1010_RDB
>>>  config P1022_DS
>>>        bool "Freescale P1022 DS"
>>>        select DEFAULT_UIMAGE
>>> -       select CONFIG_PHYS_64BIT        # The DTS has 36-bit addresses
>>> +       select PHYS_64BIT       # The DTS has 36-bit addresses
>>
>> I have no idea how this happened, but I wonder if it's a good idea.
>> On the Freescale BSP, the default config for the P1022DS is 32-bit,
>> not 36-bit, so one day we might have a 32-bit config in the upstream
>> repository.
>>
>> PHYS_64BIT is already covered by the defconfig.  I wonder if we should
>> just delete the bad line, and let the defconfig select the address
>> size.
> 
> Why, the way this patch makes it will work both with a 32-bit or 36-bit address map.   The comment should be fixed since its wrong.

"select" should not be used for things that you think make good
defaults.  It should be used for things that are required.  It's just
like "depends on", except for user interface considerations (and the
whole transitive dependency mess).

-Scott
