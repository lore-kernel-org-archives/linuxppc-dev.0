Return-Path: <pburton@wavecomp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0113.outbound.protection.outlook.com [104.47.38.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GT6C1dHdzF3Nv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 06:36:34 +1000 (AEST)
From: Paul Burton <paul.burton@mips.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Andy
 Whitcroft <apw@canonical.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "jhogan@kernel.org" <jhogan@kernel.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
Date: Thu, 20 Sep 2018 20:36:25 +0000
Message-ID: <20180920203624.s4ivwqlco2icac73@pburton-laptop>
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
 <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
 <87worgia60.fsf@concordia.ellerman.id.au>
 <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
 <d31bd0cb-b9da-6f1b-4f93-da71644668d6@c-s.fr>
In-Reply-To: <d31bd0cb-b9da-6f1b-4f93-da71644668d6@c-s.fr>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

On Thu, Sep 20, 2018 at 01:23:55AM +0000, Christophe Leroy wrote:
> On 09/20/2018 01:19 PM, Christophe LEROY wrote:
> > Le 20/09/2018 =E0 15:13, Michael Ellerman a =E9crit=A0:
> > > Joe Perches <joe@perches.com> writes:
> > > > On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
> > > > > On the below patch, checkpatch reports
> > > > >=20
> > > > > WARNING: struct kgdb_arch should normally be const
> > > > > #127: FILE: arch/powerpc/kernel/kgdb.c:480:
> > > > > +struct kgdb_arch arch_kgdb_ops;
> > > > >=20
> > > > > But when I add 'const', I get compilation failure
> > > >=20
> > > > So don't add const.
> > > >=20
> > > > checkpatch is stupid.=A0 You are not.
> > > >=20
> > > > _Always_ take checkpatch bleats with very
> > > > large grains of salt.
> > > >=20
> > > > Perhaps send a patch to remove kgbd_arch
> > > > from scripts/const_structs.checkpatch as
> > > > it seems not ever to be const.
> > >=20
> > > I think it could/should be const though, it just requires updating al=
l
> > > arches.
> > >=20
> >=20
> > Yes I was thinking about doing it, but first thing is to change the way
> > MIPS initialises it:
> >=20
> > struct kgdb_arch arch_kgdb_ops;
> >=20
> > int kgdb_arch_init(void)
> > {
> >  =A0=A0=A0=A0union mips_instruction insn =3D {
> >  =A0=A0=A0=A0=A0=A0=A0 .r_format =3D {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .opcode =3D spec_op,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .func=A0=A0=A0 =3D break_op,
> >  =A0=A0=A0=A0=A0=A0=A0 }
> >  =A0=A0=A0=A0};
> >  =A0=A0=A0=A0memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR=
_SIZE);
> >=20
> >=20
> > Can this be done staticaly ?

Something like this ought to do the trick:

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index eb6c0d582626..31eff1bec577 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo,=
 int err_code,
 	return -1;
 }
=20
-struct kgdb_arch arch_kgdb_ops;
+struct kgdb_arch arch_kgdb_ops =3D {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	.gdb_bpt_instr =3D { spec_op << 2, 0x00, 0x00, break_op },
+#else
+	.gdb_bpt_instr =3D { break_op, 0x00, 0x00, spec_op << 2 },
+#endif
+};
=20
 int kgdb_arch_init(void)
 {
-	union mips_instruction insn =3D {
-		.r_format =3D {
-			.opcode =3D spec_op,
-			.func	=3D break_op,
-		}
-	};
-	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
-
 	register_die_notifier(&kgdb_notifier);
=20
 	return 0;

Thanks,
    Paul
