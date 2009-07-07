Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ECC97B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 22:56:36 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 50CD1DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 22:56:36 +1000 (EST)
Received: by yxe37 with SMTP id 37so3274633yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Jul 2009 05:56:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A523984.2080904@marel.com>
References: <4A523984.2080904@marel.com>
Date: Tue, 7 Jul 2009 08:50:10 -0400
Message-ID: <9e4733910907070550h2c1abee2l102a0aca21bba34b@mail.gmail.com>
Subject: Re: dma_ops->map_page == NULL
From: Jon Smirl <jonsmirl@gmail.com>
To: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 6, 2009 at 1:51 PM, K=E1ri Dav=ED=F0sson<kari.davidsson@marel.c=
om> wrote:
> I am doing a driver that uses dma_map_single().
>
> After changing to to linux 2.6.29.3 I am getting
> segfaults in dma_map_single() because dma_ops->map_page is NULL.
> Actually dma_ops looks funky too.
>
> The driver is an of_platform_driver which is declared as an child of
> the lbp (fsl,lpb) node of the device tree.
>
> This is on powerpc 5200b platform.

I have hit this before, in my case the driver pointer was null. It
faulted on dma_ops->map_page which had nothing to do with the real
problem which was the null driver pointer. I spent a long time looking
at this until I figured out that the reported error was bogus compared
to the actual problem.


>
> rg
> kd
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Jon Smirl
jonsmirl@gmail.com
