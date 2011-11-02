Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C463EB6F71
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2011 20:40:00 +1100 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/usb: use ioremap instead of base plus offset to
 access regs
Date: Wed, 2 Nov 2011 09:39:21 +0000
Message-ID: <267A3B246C22C34A8E574051858E077017FA88@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320217708-32658-1-git-send-email-Shaohui.Xie@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AE9E@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE9E@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>-----Original Message-----
>From: David Laight [mailto:David.Laight@ACULAB.COM]
>Sent: Wednesday, November 02, 2011 5:07 PM
>To: Xie Shaohui-B21989; linuxppc-dev@lists.ozlabs.org
>Cc: linux-usb@vger.kernel.org
>Subject: RE: [PATCH] powerpc/usb: use ioremap instead of base plus offset
>to access regs
>
>
>>  #ifndef CONFIG_ARCH_MXC
>>  	if (pdata->have_sysif_regs)
>> -		usb_sys_regs =3D (struct usb_sys_interface *)
>> -				((u32)dr_regs + USB_DR_SYS_OFFSET);
>> +		usb_sys_regs =3D ioremap(res->start + USB_DR_SYS_OFFSET,
>> +				sizeof(struct
>usb_sys_interface)/sizeof(int));
>>  #endif
>
>That ioremap() doesn't look right.
>Isn't the 'size' in bytes??
[Xie Shaohui] Yes, should not use sizeof(int).

>(Although it will only matter if it crosses a page boundary.) Mind you,
>I'd have though the original ioremap() should have covered the entire
>structure??
[Xie Shaohui] The original ioremap() did cover the entire structure, but th=
e sysif_regs are not defined in dr_regs,
So regs of sysif_regs cannot be accessed as a member of a structure, curren=
t driver handle this by type casting, this did work in 32-bit, but in 64-bi=
t, this is not safe. So I use ioremap() to cover it again.


Best Regards,=20
Shaohui Xie
