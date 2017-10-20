Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJ9FS55P2zDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 13:47:40 +1100 (AEDT)
Message-ID: <1508467660.6188.17.camel@neuling.org>
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
From: Michael Neuling <mikey@neuling.org>
To: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@ozlabs.org,  Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Date: Fri, 20 Oct 2017 13:47:40 +1100
In-Reply-To: <8760bbb6su.fsf@linux.vnet.ibm.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
 <8760bbb6su.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 11:34 -0200, Tulio Magno Quites Machado Filho wrote:
> Forwarding some comments from Adhemerval sent to libc-alpha [1]...
>=20
> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
> > Florian Weimer <fweimer@redhat.com> writes:
> >=20
> > > On 10/12/2017 12:17 PM, Michael Ellerman wrote:
> > > > +	pr_info("Enabling TM (Transactional Memory) with Suspend
> > > > Disabled\n");
> > > > +	cur_cpu_spec->cpu_features |=3D CPU_FTR_TM;
> > > > +	cur_cpu_spec->cpu_user_features2 |=3D
> > > > PPC_FEATURE2_HTM_NO_SUSPEND;
> > > > +	tm_suspend_disabled =3D true;
> > >=20
> > > This doesn't look right because if suspend is not available, you need=
 to=C2=A0
> > > clear the original PPC_FEATURE2_HTM flag because the semantics are no=
t=C2=A0
> > > right, so that applications can use fallback code.=C2=A0=C2=A0Otherwi=
se,=C2=A0
> > > applications may incorrectly select the HTM code and break if running=
 on=C2=A0
> > > a system which supports HTM, but without the suspend state.
> > >=20
> > > The new flag should say that HTM is supported, but without the suspen=
d=C2=A0
> > > state, and it should be always set if PPC_FEATURE2_HTM is set.
> >=20
> > Will it also change TEXARS with the abort information?
>=20
> It should, with a permanent error cause so that old applications entering
> suspended state can adopt another technique.
> Michael, could you clarify if this is indeed happening, please?

It will.

If we hit a tsuspend and we are in this mode, the hardware will abort us an=
d set
the Failure Persistent bit (unless there is some other exception pending at=
 the
same time which causes the abort).

Mikey
