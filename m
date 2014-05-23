Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 598EE1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 20:50:35 +1000 (EST)
Message-ID: <1400842234.28224.28.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 0/6] Implement split core for POWER8
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Date: Fri, 23 May 2014 20:50:34 +1000
In-Reply-To: <537F228B.1030308@suse.de>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
 <537F1A8D.9000704@suse.de> <1400839224.28224.5.camel@ale.ozlabs.ibm.com>
 <537F1D59.5090909@suse.de> <1400839918.28224.11.camel@ale.ozlabs.ibm.com>
 <537F228B.1030308@suse.de>
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

Alex,

> >> If it's the latter, we could just have ppc64_cpu --smt=3Dx also set th=
e
> >> subcore amount in parallel to the thread count.
> > FWIW on powernv we just nap the threads on hotplug.
> >
> >> The reason I'm bringing this up is that I'm not quite sure who would b=
e
> >> the instance doing these performance tweaks. So I'd guess the majority
> >> of users will simply miss out on them.
> > Everyone, it's automatic on idle... except for split core mode
> > unfortunately.
>=20
> Oh I meant when you want to use a POWER system as VM host, you have to=
=20
> know about split core mode and configure it accordingly. That's=20
> something someone needs to do. And it's different from x86 which means=
=20
> people may miss out on it for their performance benchmarks.

It depends on what's running.  If you have 1 guest per core, then
running unsplit is probably best as you can nap threads as needed and
improve performance. =20

If you have more than two guests per core, then running split core can
hugely improve performance as they may be able to run at the same time
without context switching.  4 guests with 2 threads per core can run at
the same time on a single physical core.

One thing to note here is guest doorbell IRQs (new in POWER8).  They
can't cross a core or subcore boundary and there is no way for the
hypervisor to virtualise them.  Hence if you run split 4 on an SMT8
POWER8, you can only run guests up to 2 threads per core (rather than 8
threads per core).

> But if we impose a general performance penalty for everyone with it, I=
=20
> don't think split core mode should be enabled by default.

FWIW we'd like to make this dynamic eventually, so that each core is run
in whatever mode is currently best based on the running guests.

Mikey
