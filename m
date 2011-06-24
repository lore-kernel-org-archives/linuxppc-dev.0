Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42FE5B6F8E
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 12:39:02 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Date: Fri, 24 Jun 2011 02:38:58 +0000
Message-ID: <4E03F8C1.60706@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop>
	<4DF814A37aeb6b66@schlenkerla.am.freescale.net>
	<59f786bfaced051a14e2bb75d3d1ce77@kernel.crashing.org>
In-Reply-To: <59f786bfaced051a14e2bb75d3d1ce77@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>
> v2.06 III-E 9.2.1:
> "Writing the Time Base is hypervisor privileged."
>
> v2.06 III-E 2.1:
> "If a hypervisor-privileged register is accessed in the guest supervisor
> state (MSR[GS PR] =3D 0b10), an Embedded Hypervisor Privilege exception
> occurs."
>
> (v2.06 III-E 5.4.1, the big SPR table, also shows the TB regs (for writin=
g,
> i.e. 284 and 285) to be hypervisor privileged.  Consistency, hurray :-) )

To me, all this means that a guest cannot write to the actual timebase=20
register.  I'm not interpreting this to mean that a hypervisor can't=20
virtualize the timebase and allow a guest to read/write a virtual timebase=
=20
register, so that it thinks it's writing to the real hardware timebase regi=
ster.

--=20
Timur Tabi
Linux kernel developer at Freescale=
