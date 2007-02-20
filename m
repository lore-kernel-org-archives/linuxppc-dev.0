Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5C297DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 09:04:46 +1100 (EST)
In-Reply-To: <20070218142926.GA29002@lixom.net>
References: <Pine.LNX.4.61.0702152045190.9034@ld0175-tx32.am.freescale.net>
	<20070218142926.GA29002@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A13088DB-319F-4EAA-941F-EC2D9D45F6D0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [RFC 5/7] Unite all PCI-e on 85xx and 86xx under one codebase
Date: Tue, 20 Feb 2007 16:03:41 -0600
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 18, 2007, at 08:29, Olof Johansson wrote:

> On Thu, Feb 15, 2007 at 08:46:03PM -0600, Andy Fleming wrote:
>>  	if (devfn != 0x0 && bus->number == 0xff)
>>  		return PCIBIOS_DEVICE_NOT_FOUND;
>>
>> +	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
>> +		| (0 << 16) | (0x4 & 0xfc));
>> +	link_training_stat = in_le32(hose->cfg_data);
>> +	if ((link_training_stat & 0x5f) < 0x16)  /* Training failure */
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>
> Huh? (0x4 & 0xfc) doesn't make much sense, neither does 0 << 16. Can't
> you just hardcode the full hex value there, if you're not going to
> use symbolic constants, there's not much use in or:ing stuff together
> anyway. I.e. 0x84000004


Agreed

Andy
