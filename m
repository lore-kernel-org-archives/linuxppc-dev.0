Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id CAE5FB6F71
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2011 20:08:16 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 25226-04 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  2 Nov 2011 09:08:01 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/usb: use ioremap instead of base plus offset to
 access regs
Date: Wed, 2 Nov 2011 09:06:33 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE9E@saturn3.aculab.com>
In-Reply-To: <1320217708-32658-1-git-send-email-Shaohui.Xie@freescale.com>
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
>  #ifndef CONFIG_ARCH_MXC
>  	if (pdata->have_sysif_regs)
> -		usb_sys_regs =3D (struct usb_sys_interface *)
> -				((u32)dr_regs + USB_DR_SYS_OFFSET);
> +		usb_sys_regs =3D ioremap(res->start + USB_DR_SYS_OFFSET,
> +				sizeof(struct
usb_sys_interface)/sizeof(int));
>  #endif

That ioremap() doesn't look right.
Isn't the 'size' in bytes??
(Although it will only matter if it crosses a page boundary.)
Mind you, I'd have though the original ioremap() should
have covered the entire structure??

	David
