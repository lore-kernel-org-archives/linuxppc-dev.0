Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0122B67A46
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 16:12:28 +1100 (EST)
In-Reply-To: <20050317215852.GJ8345@smtp.west.cox.net>
References: <20050317215852.GJ8345@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <5aa169978e1eb58d1b61f211646a873b@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 17 Mar 2005 23:12:17 -0600
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: building ppc_htab?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Crap :(
>  >
> > > #ifdef CONFIG_PPC32
> > >=A0=A0=A0=A0=A0=A0=A0=A0 {
>  > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extern struct =
file_operations ppc_htab_operations;
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 entry =3D =
create_proc_entry("ppc_htab",=20
> S_IRUGO|S_IWUSR,
>  > > NULL);
>  > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (entry)
>  > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 entry->proc_fops =3D &ppc_htab_operations;
> > >=A0=A0=A0=A0=A0=A0=A0=A0 }
>  > > #endif
>  > >
> > > Are you suggesting this should live elsewhere?=A0 I'm not that=20
> familiar
> > > with proc code.
>  >
> > Yes, it should live in ppc_htab.c.=A0 See the CONFIG_SYSCTL stuff=20
> already
>  > in ppc_htab.c for l2crvec.
>
> Der, that's not the same thing!=A0 I still swear there's a way to do =
this
>  w/o messing w/ fs/proc/proc_misc.c, but I don't recall a good =
example.

Will, for now I will add a conditional on CONFIG_PPC_STD_MMU.  We can=20
move this out once we figure out how to do it outside of=20
fs/proc/proc_misc.c.

- kumar
