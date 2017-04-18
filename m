Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6lQc4qKTzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:52:23 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH v2 1/5] kprobes: convert kprobe_lookup_name() to a function
Date: Tue, 18 Apr 2017 12:52:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFD3C07@AcuExch.aculab.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <2780c632bc2c6e39f27920f8cc98e17430189e27.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <2780c632bc2c6e39f27920f8cc98e17430189e27.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
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

From: Naveen N. Rao
> Sent: 12 April 2017 11:58
...
> +kprobe_opcode_t *kprobe_lookup_name(const char *name)
> +{
...
> +	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
> +	const char *modsym;
> +	bool dot_appended =3D false;
> +	if ((modsym =3D strchr(name, ':')) !=3D NULL) {
> +		modsym++;
> +		if (*modsym !=3D '\0' && *modsym !=3D '.') {
> +			/* Convert to <module:.symbol> */
> +			strncpy(dot_name, name, modsym - name);
> +			dot_name[modsym - name] =3D '.';
> +			dot_name[modsym - name + 1] =3D '\0';
> +			strncat(dot_name, modsym,
> +				sizeof(dot_name) - (modsym - name) - 2);
> +			dot_appended =3D true;

If the ':' is 'a way down' name[] then although the strncpy() won't
overrun dot_name[] the rest of the code can.

The strncat() call is particularly borked.

	David
