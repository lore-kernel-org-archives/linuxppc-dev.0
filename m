Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id C1E862BF16
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2005 06:31:31 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 37so335134wra
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 11:31:30 -0800 (PST)
Message-ID: <4240b91605011011314bb06814@mail.gmail.com>
Date: Mon, 10 Jan 2005 20:31:29 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050110191248.GB3391@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
	<4240b9160501101014317b8d85@mail.gmail.com>
	<20050110182940.GA3391@smtp.west.cox.net>
	<4240b91605011010593d2f3b3d@mail.gmail.com>
	<20050110191248.GB3391@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 10 Jan 2005 12:12:48 -0700, Tom Rini <trini@kernel.crashing.org> wr=
ote:
> On Mon, Jan 10, 2005 at 07:59:50PM +0100, Jerome Glisse wrote:
> > > I have a feeling CONFIG_6xx isn't selected for a good reason.  Can yo=
u
> > > try, as a kludge, removing define_bool PPC_PREP from arch/ppc/Kconfig
> > > and seeing if you can build / boot ?  Thanks.
> > >
> > > --
> > > Tom Rini
> > > http://gate.crashing.org/~trini/
> > >
> >
> > Seems that this flags is linked to many things :) I tried removing PPC_=
PREP
> > bool but the kernel fail to compile with again new errors :
> >
>=20
> One last thing before we just do what you suggested originally, can you
> hack it so that PPC_PREP is still set, but on 970 we still set
> CONFIG_6xx?  Thanks again.
>=20
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>=20

This issue must be strongly linked with the Murphy Law.
Got another compile error when y a add CONFIG_6xx=3Dy
to my kernel config.

  LD      .tmp_vmlinux1
ld: arch/ppc/kernel/idle_6xx.o: No such file: Aucun fichier ou
r=E9pertoire de ce type

Unfortunetly i've got to move (some trip for my study) and i won't be
able to have access any g5 or PPC970 with linux on it until i came back
friday or saturday. Anyway i may access my mail until then.

Does this disable_6xx_mmu function do something that we should really
have on PPC970 ? I hadn't get enought time to look at this function and
understand it.

By the way, even if i pretty sure this is not related, my kernel is patched
with one of my patch (i posted it on this mailling list) that add support o=
f U3
agp bridge on G5.

This patch only affect few file and if i remember well, i have tested witho=
ut
it too with no success.

Files affected by my patch pciids.h, uninorth.c(char/driver/agp),=20
uninorth.h(asm-ppc&64). and some change in Kconfig of (char/driver/agp)

One strange things is that no one except me report error on compilation ?
No one use linux with g5, am i alone :) ?

best,
Jerome Glisse
