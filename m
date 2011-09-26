Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09B53B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 08:12:31 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXXw-YMFG4vVbYQKOtDYHtriaXe-=sz6YBivFXbp=mH2PQ@mail.gmail.com>
Date: Mon, 26 Sep 2011 17:12:09 -0500
Message-Id: <FAF4E48A-0966-4A6E-8D31-B30D07CB0746@kernel.crashing.org>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
	<CAOZdJXXw-YMFG4vVbYQKOtDYHtriaXe-=sz6YBivFXbp=mH2PQ@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Anatolij Gustschin <agust@denx.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 25, 2011, at 12:06 PM, Tabi Timur-B04825 wrote:

> On Fri, Sep 23, 2011 at 2:32 PM, Anatolij Gustschin <agust@denx.de> =
wrote:
>=20
>> diff --git a/arch/powerpc/platforms/85xx/Kconfig =
b/arch/powerpc/platforms/85xx/Kconfig
>> index 1b393f4..b29d4f2 100644
>> --- a/arch/powerpc/platforms/85xx/Kconfig
>> +++ b/arch/powerpc/platforms/85xx/Kconfig
>> @@ -80,7 +80,7 @@ config P1010_RDB
>>  config P1022_DS
>>        bool "Freescale P1022 DS"
>>        select DEFAULT_UIMAGE
>> -       select CONFIG_PHYS_64BIT        # The DTS has 36-bit =
addresses
>> +       select PHYS_64BIT       # The DTS has 36-bit addresses
>=20
> I have no idea how this happened, but I wonder if it's a good idea.
> On the Freescale BSP, the default config for the P1022DS is 32-bit,
> not 36-bit, so one day we might have a 32-bit config in the upstream
> repository.
>=20
> PHYS_64BIT is already covered by the defconfig.  I wonder if we should
> just delete the bad line, and let the defconfig select the address
> size.

Why, the way this patch makes it will work both with a 32-bit or 36-bit =
address map.   The comment should be fixed since its wrong.

- k=
