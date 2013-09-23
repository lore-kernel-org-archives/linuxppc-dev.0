Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D96C52C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 18:50:04 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14928-07 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 23 Sep 2013 09:49:52 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 1/2] powerpc: make kernel module helper endian-safe.
Date: Mon, 23 Sep 2013 09:34:15 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B734F@saturn3.aculab.com>
In-Reply-To: <1379702541-28372-1-git-send-email-ebs@ebshome.net>
References: <1379702541-28372-1-git-send-email-ebs@ebshome.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Eugene Surovegin" <ebs@ebshome.net>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -62,6 +62,16 @@ struct ppc64_stub_entry
>     r2) into the stub. */
>  static struct ppc64_stub_entry ppc64_stub =3D
>  { .jump =3D {
> +#ifdef __LITTLE_ENDIAN__
> +	0x00, 0x00, 0x82, 0x3d, /* addis   r12,r2, <high> */
> +	0x00, 0x00, 0x8c, 0x39, /* addi    r12,r12, <low> */
> +	/* Save current r2 value in magic place on the stack. */
> +	0x28, 0x00, 0x41, 0xf8, /* std     r2,40(r1) */
> +	0x20, 0x00, 0x6c, 0xe9, /* ld      r11,32(r12) */
> +	0x28, 0x00, 0x4c, 0xe8, /* ld      r2,40(r12) */
> +	0xa6, 0x03, 0x69, 0x7d, /* mtctr   r11 */
> +	0x20, 0x04, 0x80, 0x4e  /* bctr */
> +#else
>  	0x3d, 0x82, 0x00, 0x00, /* addis   r12,r2, <high> */
>  	0x39, 0x8c, 0x00, 0x00, /* addi    r12,r12, <low> */
>  	/* Save current r2 value in magic place on the stack. */
> @@ -70,6 +80,7 @@ static struct ppc64_stub_entry ppc64_stub =3D
>  	0xe8, 0x4c, 0x00, 0x28, /* ld      r2,40(r12) */
>  	0x7d, 0x69, 0x03, 0xa6, /* mtctr   r11 */
>  	0x4e, 0x80, 0x04, 0x20  /* bctr */
> +#endif

Seems to me that should be a list of 32bit constants.

	David
