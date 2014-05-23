Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55F041A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 20:00:25 +1000 (EST)
Message-ID: <1400839224.28224.5.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 0/6] Implement split core for POWER8
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Date: Fri, 23 May 2014 20:00:24 +1000
In-Reply-To: <537F1A8D.9000704@suse.de>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
 <537F1A8D.9000704@suse.de>
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

On Fri, 2014-05-23 at 11:53 +0200, Alexander Graf wrote:
> On 23.05.14 10:15, Michael Neuling wrote:
> > This patch series implements split core mode on POWER8.  This enables u=
p to 4
> > subcores per core which can each independently run guests (per guest SP=
Rs like
> > SDR1, LPIDR etc are replicated per subcore).  Lots more documentation o=
n this
> > feature in the code and commit messages.
> >
> > Most of this code is in the powernv platform but there's a couple of KV=
M
> > specific patches too.
> >
> > Patch series authored by mpe and me with a few bug fixes from others.
> >
> > v2:
> >    There are some minor updates based on comments and I've added the Ac=
ks by
> >    Paulus and Alex for the KVM code.
>=20
> I don't see changelogs inside the individual patches. Please make sure=
=20
> to always mention what changed from one version to the next in a=20
> particular patch, so that I have the chance to check whether that change=
=20
> was good :).

Sure, that was a bit sloppy

Only the last patch was the only one that changed.  I changed the sysfs
file from 600 permissions to 644 so that users can read it more easily
as requested by Joel.

The other change was to fix the possibility of a race when coming out of
nap and checking if we need to split.  This fix was form paulus' (worked
offline).

> Also, is there any performance penalty associated with split core mode?=
=20
> If not, could we just always default to split-by-4 on POWER8 bare metal?

Yeah, there is a performance hit .  When you are split (ie
subcores_per_core =3D 2 or 4), the core is stuck in SMT8 mode.  So if you
only have 1 thread active (others napped), you won't get the benefit of
ST mode in the core (more register renames per HW thread, more FXUs,
more FPUs etc).

Mikey
