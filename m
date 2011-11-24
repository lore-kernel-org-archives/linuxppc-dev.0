Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD7281007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:58:01 +1100 (EST)
Subject: Re: [PATCH] powerpc/usb: use ioremap instead of base plus offset to
 access regs
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <267A3B246C22C34A8E574051858E077017FA88@039-SN1MPN1-005.039d.mgd.msft.net>
Date: Thu, 24 Nov 2011 01:57:48 -0600
Message-Id: <95089726-C330-474E-A24C-EECF7D17682B@kernel.crashing.org>
References: <1320217708-32658-1-git-send-email-Shaohui.Xie@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AE9E@saturn3.aculab.com>
 <267A3B246C22C34A8E574051858E077017FA88@039-SN1MPN1-005.039d.mgd.msft.net>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Cc: David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 2, 2011, at 4:39 AM, Xie Shaohui-B21989 wrote:

>> -----Original Message-----
>> From: David Laight [mailto:David.Laight@ACULAB.COM]
>> Sent: Wednesday, November 02, 2011 5:07 PM
>> To: Xie Shaohui-B21989; linuxppc-dev@lists.ozlabs.org
>> Cc: linux-usb@vger.kernel.org
>> Subject: RE: [PATCH] powerpc/usb: use ioremap instead of base plus =
offset
>> to access regs
>>=20
>>=20
>>> #ifndef CONFIG_ARCH_MXC
>>> 	if (pdata->have_sysif_regs)
>>> -		usb_sys_regs =3D (struct usb_sys_interface *)
>>> -				((u32)dr_regs + USB_DR_SYS_OFFSET);
>>> +		usb_sys_regs =3D ioremap(res->start + USB_DR_SYS_OFFSET,
>>> +				sizeof(struct
>> usb_sys_interface)/sizeof(int));
>>> #endif
>>=20
>> That ioremap() doesn't look right.
>> Isn't the 'size' in bytes??
> [Xie Shaohui] Yes, should not use sizeof(int).
>=20
>> (Although it will only matter if it crosses a page boundary.) Mind =
you,
>> I'd have though the original ioremap() should have covered the entire
>> structure??
> [Xie Shaohui] The original ioremap() did cover the entire structure, =
but the sysif_regs are not defined in dr_regs,
> So regs of sysif_regs cannot be accessed as a member of a structure, =
current driver handle this by type casting, this did work in 32-bit, but =
in 64-bit, this is not safe. So I use ioremap() to cover it again.

What's status on a new version of this patch.

Also, make sure to CC: Greg (gregkh@suse.de) on usb patches

- k=
