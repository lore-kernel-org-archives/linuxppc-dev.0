Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Lw426fNzDqdt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 13:16:52 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hh10so11055765pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 20:16:52 -0700 (PDT)
Date: Tue, 2 Aug 2016 13:16:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michal Sojka <sojkam1@fel.cvut.cz>, linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC5200 does not boot
Message-ID: <20160802131643.0bb9a777@roar.ozlabs.ibm.com>
In-Reply-To: <1470105873.12584.7.camel@kernel.crashing.org>
References: <874m74w1m7.fsf@steelpick.2x.cz>
 <1470105873.12584.7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 02 Aug 2016 12:44:33 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2016-08-02 at 00:44 +0200, Michal Sojka wrote:
> > Hi Benjamin,
> >=20
> > the following commit causes my MPC5200 not to boot.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0commit 9402c684613163888714df0955fa1f17142b08bf=
 =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0Author: Benjamin Herrenschmidt <benh@kernel.c=
rashing.org> =20
> > =C2=A0=C2=A0=C2=A0=C2=A0Date:=C2=A0=C2=A0=C2=A0Tue Jul 5 15:03:41 2016 =
+1000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc: Factor do_feat=
ure_fixup calls
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032 and 64-bit do a simi=
lar set of calls early on, we move it all to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a single common functio=
n to make the boot code more readable.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Benjamin=
 Herrenschmidt <benh@kernel.crashing.org> =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Michae=
l Ellerman <mpe@ellerman.id.au> =20
> >=20
> > I suspect that the cause will be similar as described in commit
> > 1cd03890ea64795e53f17a94928cca22495acb2a. Unfortunately, I don't have
> > much time to debug this, but I can easily test patches. =20
>=20
> Are you sure of your bisection ? Did you verify that reverting that one
> patch fixes it ? Because all this does is move code to a function,
> the code is functionally the same and called in the same place...

+	struct cpu_spec *spec =3D *PTRRELOC(&cur_cpu_spec);
+
+	/*
+	 * Apply the CPU-specific and firmware specific fixups to kernel text
+	 * (nop out sections not relevant to this CPU or this firmware).
+	 */
+	do_feature_fixups(spec->cpu_features,
+			  PTRRELOC(&__start___ftr_fixup),
+			  PTRRELOC(&__stop___ftr_fixup));

Shouldn't these be PTRRELOC(spec)->cpu_features ? You are relocating
access to the pointer word, but not the address it contains.
identify_cpu() returns the relocated pointer which is what 32-bit used
to use.

Thanks,
Nick
