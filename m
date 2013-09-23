Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 3AC5C2C0105
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 18:50:04 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 13436-06 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 23 Sep 2013 09:49:52 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 2/2] powerpc: make ftrace endian-safe.
Date: Mon, 23 Sep 2013 09:33:11 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B734E@saturn3.aculab.com>
In-Reply-To: <1379702541-28372-2-git-send-email-ebs@ebshome.net>
References: <1379702541-28372-1-git-send-email-ebs@ebshome.net>
 <1379702541-28372-2-git-send-email-ebs@ebshome.net>
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

> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -174,7 +174,11 @@ __ftrace_make_nop(struct module *mod,
>=20
>  	pr_devel(" %08x %08x\n", jmp[0], jmp[1]);
>=20
> +#ifdef __LITTLE_ENDIAN__
> +	ptr =3D ((unsigned long)jmp[1] << 32) + jmp[0];
> +#else
>  	ptr =3D ((unsigned long)jmp[0] << 32) + jmp[1];
> +#endif
>=20

Why not just:
	ptr =3D *(__u64 *)jmp;

Or, if alignment isn't guaranteed, something that is
equivalent to:
	ptr =3D *(__u64 __attribute__((aligned(4))) *)jmp;

	David
