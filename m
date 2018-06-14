Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4161zk3mgVzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 21:46:26 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id c22-v6so3125853pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 04:46:26 -0700 (PDT)
Date: Thu, 14 Jun 2018 21:46:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: stacktrace.c:(.text+0x1b0): undefined reference to
 `.smp_send_safe_nmi_ipi'
Message-ID: <20180614214617.60f55beb@roar.ozlabs.ibm.com>
In-Reply-To: <62c0b560-5211-4844-1210-6dcd9e2c5526@c-s.fr>
References: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
 <20180614202546.24d40e51@roar.ozlabs.ibm.com>
 <62c0b560-5211-4844-1210-6dcd9e2c5526@c-s.fr>
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

On Thu, 14 Jun 2018 12:51:28 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 14/06/2018 =C3=A0 12:25, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Thu, 14 Jun 2018 12:06:51 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> See http://kisskb.ellerman.id.au/kisskb/buildresult/13395345/ for deta=
ils
> >>
> >> Seems like that function only exists when CONFIG_NMI_IPI is defined.
> >>
> >> Problem introduced by commit 5cc05910f26e6fd6da15f052f86f6150e4b91664
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co=
mmit/arch/powerpc/kernel/stacktrace.c?h=3Dnext-20180614&id=3D5cc05910f26e6f=
d6da15f052f86f6150e4b91664
> >>
> >>
> >> What do you recommend to fix that ? =20
> >=20
> > We could just do smp_call_function in the case we have no NMI_IPI? =20
>=20
> ???
>=20
> Can you detail what you have in mind ? Do smp_call_function() to call=20
> what ? Instead of the call to smp_send_safe_nmi_ipi() ?

Yes I was thinking that but now I take a better look there's places that
call it with irqs off so that might be a bit risky. I guess just making
it depend on NMI_IPI for now is the minimum fix.

Thanks,
Nick
