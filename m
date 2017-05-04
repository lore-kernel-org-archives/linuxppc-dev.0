Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJZVv451SzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 22:45:10 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: Paul Clarke <pc@us.ibm.com>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2] powerpc/kprobes: refactor kprobe_lookup_name for
 safer string operations
Date: Thu, 4 May 2017 12:45:00 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFE5478@AcuExch.aculab.com>
References: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Naveen N. Rao [mailto:naveen.n.rao@linux.vnet.ibm.com]
> Sent: 04 May 2017 11:25
> Use safer string manipulation functions when dealing with a
> user-provided string in kprobe_lookup_name().
>=20
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changed to ignore return value of 0 from strscpy(), as suggested by
> Masami.

let's see what this code looks like;

>  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
>  	bool dot_appended =3D false;
> +	const char *c;
> +	ssize_t ret =3D 0;
> +	int len =3D 0;
> +
> +	if ((c =3D strnchr(name, MODULE_NAME_LEN, ':')) !=3D NULL) {

I don't like unnecessary assignments in conditionals.

> +		c++;
> +		len =3D c - name;
> +		memcpy(dot_name, name, len);
> +	} else
> +		c =3D name;
> +
> +	if (*c !=3D '\0' && *c !=3D '.') {
> +		dot_name[len++] =3D '.';
>  		dot_appended =3D true;

If you don't append a dot, then you can always just lookup
the original string.

>  	}
> +	ret =3D strscpy(dot_name + len, c, KSYM_NAME_LEN);
> +	if (ret > 0)
> +		addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);

I'm not sure you need 'ret' here at all.

> +	/* Fallback to the original non-dot symbol lookup */
> +	if (!addr && dot_appended)
>  		addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(name);

We can bikeshed this function to death:

	/* The function name must start with a '.'.
	 * If it doesn't then we insert one. */
	c =3D strnchr(name, MODULE_NAME_LEN, ':');
	if (c && c[1] && c[1] !=3D '.') {
		/* Insert a '.' after the ':' */
		c++;
		len =3D c - name;
		memcpy(dot_name, name, len);
	} else {
		if (name[0] =3D=3D '.')
			goto check_name:
		/* Insert a '.' before name */
		c =3D name;
		len =3D 0;
	}

	dot_name[len++] =3D '.';
	if (strscpy(dot_name + len, c, KSYM_NAME_LEN) > 0) {
		addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
		if (addr)
			return addr;
	}
	/* Symbol with extra '.' not found, fallback to original name */

check_name:
	return (kprobe_opcode_t *)kallsyms_lookup_name(name);

	David
