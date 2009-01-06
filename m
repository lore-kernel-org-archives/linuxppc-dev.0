Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8F681DE51D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 08:15:15 +1100 (EST)
Date: Wed, 7 Jan 2009 00:15:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20090106211513.GA23914@oksana.dev.rtsoft.ru>
References: <C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
	<c384c5ea0901061053r21fbc853y3b28ae3c8e3a0e6f@mail.gmail.com>
	<20090106192747.GA3056@oksana.dev.rtsoft.ru>
	<2B8AFE67-67BF-4926-B41B-79ACD72CA505@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <2B8AFE67-67BF-4926-B41B-79ACD72CA505@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, Wolfgang Denk <wd@denx.de>,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 06, 2009 at 02:38:57PM -0600, Kumar Gala wrote:
[...]
>>>>> Why?  Unless the BSP u-boots do something insane, I think we  
>>>>> should try
>>>>> to have the upstream kernel boot on the u-boot that comes on the  
>>>>> board
>>>>> (it's not nice to require users to reflash unnecessarily).
>>>>
>>>> Just in case, the latest version of this patch set is compatible  
>>>> with
>>>> the FSL u-boots.
>>>>
>>>
>>> Up to now, I was testing PCIe with this combo:
>>> - U-Boot 1.3.0-rc2 (Nov 19 2007 - 16:37:36) MPC83XX, was on the board
>>> - dtc 1.1.0
>>> - Linux 2.6.24.3 w/ Freescale patches from http://www.bitshrine.org/gpp/
>>>
>>>
>>> That u-boot (i.e. on the mpc8315e-rdb board) had PCIe initialization.
>>>
>>> Is u-boot PCIe initialization required for this kernel patch to work?
>>
>> Yup.
>
> Really?  what for?

Hm. U-Boot should initialize SerDes and PCI-E controller (pcie laws,
inbound/outbound windows, clocks, etc.)

Though if PCI-E controller wasn't initialized (i.e. board reflashed
with the community u-boot), Linux just won't probe the pcie controller:

cfg_bar = in_le32(hose->cfg_data + PEX_OUTWIN0_BAR);
if (!cfg_bar) {
	/* PCI-E isn't configured. */
	ret = -ENODEV;
	goto err1;
}

Or did I misunderstand the question?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
