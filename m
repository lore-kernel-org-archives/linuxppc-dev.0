Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 3E74DB7C33
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 01:28:35 +1100 (EST)
Received: by yxe11 with SMTP id 11so48859yxe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 06:28:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B728869.1090404@grandegger.com>
References: <4B5871F2.9090005@grandegger.com>
	<20100121.180311.228791894.davem@davemloft.net>
	<20100209152317.5303b1b3@wker>
	<20100209.121356.216640014.davem@davemloft.net>
	<4B72794A.9010805@grandegger.com> <4B728869.1090404@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 10 Feb 2010 07:28:14 -0700
Message-ID: <fa686aa41002100628x7ffc8fa9h3170f58387c5b67d@mail.gmail.com>
Subject: Re: [net-next-2.6 PATCH 2/3] fs_enet: Add support for MPC512x to
	fs_enet driver
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	agust@denx.de, David Miller <davem@davemloft.net>, kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 3:20 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Wolfgang Grandegger wrote:
>> Hi David,
>>
>> David Miller wrote:
>>> From: Anatolij Gustschin <agust@denx.de>
>>> Date: Tue, 9 Feb 2010 15:23:17 +0100
>>>
>>>> In my understanding, in the ESP scsi driver the set of defines for
>>>> the register offsets is common for all chip drivers. The chip driver
>>>> methods for register access translate the offsets because the
>>>> registers on some chips are at different intervals (4-byte, 1-byte,
>>>> 16-byte for mac_esp.c). But the register order is the same for
>>>> different chips.
>>>>
>>>> In our case non only the register order is not the same for 8xx
>>>> FEC and 5121 FEC, but there are also other differences, different
>>>> reserved areas between several registers, some registers are
>>>> available only on 8xx and some only on 5121.
>>> That only means you would need to use a table based register address
>>> translation scheme, rather than a simple calculation. =A0Something
>>> like:
>>>
>>> static unsigned int chip_xxx_table[] =3D
>>> {
>>> =A0 =A0 =A0[GENERIC_REG_FOO] =A0 =A0 =A0 =A0=3D CHIP_XXX_FOO,
>>> =A0 =A0 =A0...
>>> };
>>>
>>> static u32 chip_xxx_read_reg(struct chip *p, unsigned int reg)
>>> {
>>> =A0 =A0 =A0unsigned int reg_off =3D chip_xxx_table[reg];
>>>
>>> =A0 =A0 =A0return readl(p->regs + reg_off);
>>> }
>>>
>>> And this table can have special tokens in entries for
>>> registers which do not exist on a chip, so you can trap
>>> attempted access to them in these read/write handlers.
>>
>> Yes, that could be done, but to honest, I do not see any improvement in
>> respect to the previous patch where the register offset were defined via
>> pointers within a structure.
>>
>>> Please stop looking for excuses to fork this driver, a
>>> unified driver I think can be done cleanly.
>>
>> Other people suggested to fork the driver because it's getting too ugly.
>
> That said, I think there is consensus that it does not make sense, and
> it's even not possible, to provide a kernel image which runs on both,
> the 8xx and the mpc512x. Therefore, there is also no need for sharing
> this driver at run time. Compile time selection would allow a more
> elegant and transparent implementation. Would that be an acceptable
> solution?

I'm okay with compile time selection.

g.
