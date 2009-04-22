Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id BB598DE0E0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 05:35:30 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so121162qwe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 12:35:28 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
Date: Wed, 22 Apr 2009 14:35:24 -0500
Message-ID: <ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
Subject: Re: removing get_immrbase()??
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 1:38 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> I'm not sure if we can actually get away with completely removing
> get_immrbase() but I figured I'd give everyone something to flame me abou=
t.
> =A0The current users are:
>
> CPM/QE related users.

I'm okay with doing this for QE, but I don't see it used in any QE code.

> arch/powerpc/include/asm/cpm2.h:#define CPM_MAP_ADDR (get_immrbase() +
> 0x80000)
> arch/powerpc/sysdev/cpm2.c: =A0 =A0 cpm2_immr =3D ioremap(get_immrbase(),
> CPM_MAP_SIZE);
> =A0 =A0 =A0 =A0these two are related and seem like we could look for "fsl=
,cpm2"

That's okay, as long as you don't break compatibility with older
device trees that don't have that property, unless you can demonstrate
that these trees would never work with the current kernel anyway.

I think this is a good idea, but it looks like we'll need to define a
whole bunch of new structures to replace all of the "+ offset" usages.

--=20
Timur Tabi
Linux kernel developer at Freescale
