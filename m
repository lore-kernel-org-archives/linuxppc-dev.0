Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id E1163B6F70
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 22:15:48 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 16365-05 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  3 Nov 2011 11:15:44 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/usb: use unsigned long to type cast an address of
 ioremap
Date: Thu, 3 Nov 2011 11:14:14 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA1@saturn3.aculab.com>
In-Reply-To: <1320314302-7973-1-git-send-email-Shaohui.Xie@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Shaohui Xie" <Shaohui.Xie@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Below are codes for accessing usb sysif_regs in driver:
>=20
> usb_sys_regs =3D (struct usb_sys_interface *)
> 	((u32)dr_regs + USB_DR_SYS_OFFSET);
>=20
> these codes work in 32-bit, but in 64-bit, use u32 to type cast the
address
> of ioremap is not right, and accessing members of 'usb_sys_regs' will
cause
> call trace, so use unsigned long for both 32-bit and 64-bit.

Wouldn't a (char *) cast be even better?

	David
