Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3F23B6F97
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 03:22:16 +1000 (EST)
Date: Thu, 23 Jun 2011 12:22:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Message-ID: <20110623122210.06ee9f55@schlenkerla.am.freescale.net>
In-Reply-To: <4E020268.2020809@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop> <4DF814A3.7070209@freescale.com>
	<1308105196.2635.16.camel@pasglop>
	<083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
	<4E020268.2020809@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Jun 2011 09:55:36 -0500
Timur Tabi <timur@freescale.com> wrote:

> Kumar Gala wrote:
> >> >=20
> >> > Well, not exactly. Paul wants to break that up since we're adding so=
me
> >> > primitive support for 201 HV mode too (for 970's). Last we discussed,
> >> > the plan was to go for a generic HV mode bit and a separate bit for =
the
> >> > version.
> >> >=20
> >> > Cheers,
> >> > Ben.
>=20
> > Any ETA on Paul's intro of the FTR bit?  If not I'll pull this into my =
'next' tree and we can clean up later.
>=20
> Just FYI, this particular patch is because of a limitation in the Freesca=
le
> hypervisor.  It's not because we're running in guest mode.  If the hyperv=
isor
> provided full emulation of the timebase register, then we wouldn't need t=
his
> patch.  The same can be said of KVM or any other hypervisor.

=46rom Power ISA 2.06B, book III-E, section 9.2.1:

Virtualized Implementation Note:

In virtualized implementations, TBU and TBL are
read-only.

> So a generic HV mode bit is not going to help me, unless there's also a b=
it
> that's specific to our hypervisor.  And even then, we would need some way=
 to
> differentiate among different versions of our hypervisor, in case some fu=
ture
> version adds timebase support.=20

That's very unlikely to happen.

Ideally we would avoid doing this sync even when not running under a
hypervisor, as long as firmware has done the sync, and kexec hasn't messed
it up.  Besides being a waste of boot time, the firmware's sync is
probably tighter since it can use a platform-specific mechanism to start all
the timebases at once.

-Scott
