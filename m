Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C067FB81AD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 21:21:43 +1100 (EST)
Message-ID: <4B728869.1090404@grandegger.com>
Date: Wed, 10 Feb 2010 11:20:25 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [net-next-2.6 PATCH 2/3] fs_enet: Add support for MPC512x to
	fs_enet driver
References: <4B5871F2.9090005@grandegger.com>	<20100121.180311.228791894.davem@davemloft.net>	<20100209152317.5303b1b3@wker>
	<20100209.121356.216640014.davem@davemloft.net>
	<4B72794A.9010805@grandegger.com>
In-Reply-To: <4B72794A.9010805@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	agust@denx.de, kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Hi David,
> 
> David Miller wrote:
>> From: Anatolij Gustschin <agust@denx.de>
>> Date: Tue, 9 Feb 2010 15:23:17 +0100
>>
>>> In my understanding, in the ESP scsi driver the set of defines for
>>> the register offsets is common for all chip drivers. The chip driver
>>> methods for register access translate the offsets because the
>>> registers on some chips are at different intervals (4-byte, 1-byte,
>>> 16-byte for mac_esp.c). But the register order is the same for
>>> different chips.
>>>
>>> In our case non only the register order is not the same for 8xx
>>> FEC and 5121 FEC, but there are also other differences, different
>>> reserved areas between several registers, some registers are
>>> available only on 8xx and some only on 5121.
>> That only means you would need to use a table based register address
>> translation scheme, rather than a simple calculation.  Something
>> like:
>>
>> static unsigned int chip_xxx_table[] =
>> {
>> 	[GENERIC_REG_FOO]	 = CHIP_XXX_FOO,
>> 	...
>> };
>>
>> static u32 chip_xxx_read_reg(struct chip *p, unsigned int reg)
>> {
>> 	unsigned int reg_off = chip_xxx_table[reg];
>>
>> 	return readl(p->regs + reg_off);
>> }
>>
>> And this table can have special tokens in entries for
>> registers which do not exist on a chip, so you can trap
>> attempted access to them in these read/write handlers.
> 
> Yes, that could be done, but to honest, I do not see any improvement in
> respect to the previous patch where the register offset were defined via
> pointers within a structure.
> 
>> Please stop looking for excuses to fork this driver, a
>> unified driver I think can be done cleanly.
> 
> Other people suggested to fork the driver because it's getting too ugly.

That said, I think there is consensus that it does not make sense, and
it's even not possible, to provide a kernel image which runs on both,
the 8xx and the mpc512x. Therefore, there is also no need for sharing
this driver at run time. Compile time selection would allow a more
elegant and transparent implementation. Would that be an acceptable
solution?

Wolfgang.
