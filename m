Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C15DBB7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 20:18:03 +1100 (EST)
In-Reply-To: <cb9ecdfa1001180026q5856b170t3f4c71191a7b99d8@mail.gmail.com>
References: <cb9ecdfa1001172304q132d5324qa963d0d5cdfb7806@mail.gmail.com>	
	<OF593A1F75.3C3C7D18-ONC12576AF.002B1239-C12576AF.002BB30A@transmode.se>
	<cb9ecdfa1001180026q5856b170t3f4c71191a7b99d8@mail.gmail.com>
Subject: Re: jffs2_gcd_mtdx thread and umount problem.
To: Johnny Hung <johnny.hacking@gmail.com>
Message-ID: <OF4F0C58C2.1BF896BC-ONC12576AF.0031AB45-C12576AF.0032B052@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 18 Jan 2010 10:13:39 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Johnny Hung <johnny.hacking@gmail.com> wrote on 18/01/2010 09:26:26:
>
Please don't top post.

> Yes, umount / reboot command doesn't hang after first boot + wait for=

> 20 minutes. The jffs2_gcd_mtdx will re-erase empty blocks but how do =
I
> know it is finished?

You don't or just monitor jffs2_gcd_mtdx until it is finished.

>
> BTW, why jffs2_gcd_mtd need to re-erase empty blocks and it will caus=
e
> some command cannot work if erase block is necessary. I mean many
> pepple could meet this problem if it is need to erase empty block and=

> how do they overcome or workaround it.

Because it might not be completely erased due to power failure in the
middle of an erase. You get random bit flips if that happens.

You can avoid this by writing clean markers in every empty block when y=
ou
install it, a bit messy though and it won't solve the general problem: =
Try
removing a few big files and then reboot, you will have to wait then to=
o.
If you don't use JFFS2 as a module and unload it, you can my old patch =
which will
solve both problems.

    Jocke
>
> Thank you so much, Jocke
> BRs, H. Johnny
>
> > I guess this is the first reboot after mounting a new JFFS2 FS?
> > Then JFFS2 is reerasing empty blocks and you will have to wait
> > until it is done.
> >
> > I posted a patch long ago for this, but it was racy w.r.t JFSS2 mod=
ule unload so
> > it didn't make it into the repo. Search the list for
> > "[JFFS2] Stop erasing blocks when rebooting." to find my old patch
> >
> > =A0Jocke
> >
> >
>=
