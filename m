Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E56541A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 20:11:58 +1000 (EST)
Message-ID: <1400839918.28224.11.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 0/6] Implement split core for POWER8
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Date: Fri, 23 May 2014 20:11:58 +1000
In-Reply-To: <537F1D59.5090909@suse.de>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
 <537F1A8D.9000704@suse.de> <1400839224.28224.5.camel@ale.ozlabs.ibm.com>
 <537F1D59.5090909@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> Also, is there any performance penalty associated with split core mode=
?
> >> If not, could we just always default to split-by-4 on POWER8 bare meta=
l?
> > Yeah, there is a performance hit .  When you are split (ie
> > subcores_per_core =3D 2 or 4), the core is stuck in SMT8 mode.  So if y=
ou
> > only have 1 thread active (others napped), you won't get the benefit of
> > ST mode in the core (more register renames per HW thread, more FXUs,
> > more FPUs etc).
>=20
> Ok, imagine I have 1 core with SMT8. I have one process running at 100%=
=20
> occupying one thread, the other 7 threads are idle.
>=20
> Do I get performance benefits from having the other threads idle? Or do=
=20
> I have to configure the system into SMT1 mode to get my ST benefits?

You automatically get the performance benefit when they are idle.  When
threads enter nap, the core is able to reduce it's SMT mode
automatically.=20

> If it's the latter, we could just have ppc64_cpu --smt=3Dx also set the=
=20
> subcore amount in parallel to the thread count.

FWIW on powernv we just nap the threads on hotplug.

> The reason I'm bringing this up is that I'm not quite sure who would be=
=20
> the instance doing these performance tweaks. So I'd guess the majority=
=20
> of users will simply miss out on them.

Everyone, it's automatic on idle... except for split core mode
unfortunately.

Mikey
