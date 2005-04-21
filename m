Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6A9E967A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 04:03:29 +1000 (EST)
In-Reply-To: <4267E391.5040006@ru.mvista.com>
References: <4267E391.5040006@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7c4c26a737f9d366040482e49f3ca004@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 21 Apr 2005 13:03:13 -0500
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
	thestock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 21, 2005, at 12:32 PM, Vitaly Bordug wrote:

>  Rune Torgersen wrote:
>         From: Vitaly Bordug [ mailto:vbordug@ru.mvista.com ]
>         Sent: Thursday, April 21, 2005 10:29
>
>
>         This is all right. The only thing I still don't understand -
> how this stuff work without PCI IRQ (don't know much about 8266
>
> though).
>
> On my 8272 only one IRQ is produced and it should be demux'ed in order
> for PCI devices to work. I agree that the siumcr stuff would better
>
> reside
>
> in the firmware, and I have submitted related patch to the =
u-boot-users
>
>
> list, but I have no idea whether it would be accepted or not
>
> (Wolfgang?).
>
> Ah.. That. I have that in a board specific file. Looks excactly like=20=

> the
> implementation you have (for the 8266 port) For our internal board, it
> is quite different, so it should probably be in a board specific file
> (eg platforms/board_pci_setup.h)
>
>
>         The main point I actually dislike in the current m8260
>
> implementation
>
> is that it adds defines for the PCI memory map while it exists
> (and already included) in platforms/pq2ads.h. The memory maps are
> nearly the same so we should decide which one will remain.
>
> I think I like the _LOWER/_UPPER/OFFSET variant. And it need to be
> possible to override it in board-files.
> I'll work in getting the 8266 PCI support I have to be integrated into
> the PQ2[F]ADS board support.
>
>
>  Great. Than I'll replace PCI_MSTR_* with _LOWER/_UPPER/OFFSET stuff=20=

> in the board-specific file so that it override m8260_pci.h defines.=A0=20=

> Another issue - I want to keep the setup of the second outbound PCI=20
> window (pcimask1/pcibr1) - since continuous mem/mmio/io is not=20
> flexible enough - and to keep potarx/pobarx/pocmrx assignments as they=20=

> are in pq_... version (changing of course all relative constants to=20
> _LOWER/... stuff).
>
>  Maybe the m8260.[c,h] should be renamed since this suites not only=20
> 826x series?
>
> Comments/objections?

Renaming is fine by me, however I think currently there is an=20
understanding that all *8260* is applicable to all PQ2 family products.

- kumar
