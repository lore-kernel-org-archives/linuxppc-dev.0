Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from blv-smtpout-01.boeing.com (blv-smtpout-01.boeing.com
	[130.76.32.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "blv-smtpout-01.boeing.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95226B7406
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 08:07:52 +1100 (EST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 23 Feb 2011 14:54:53 -0600
Subject: mpc85xx: kexec build broken by "powerpc/kexec: Remove
	ppc_md.machine_kexec"
Message-ID: <B87A2622-0006-4FC8-893A-41DBBF0CA170@boeing.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Anton Blanchard <anton@samba.org>, "Livingston,
	John A" <john.a.livingston@boeing.com>,
	Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

I just started trying to update some patches for our P2020-based unit to th=
e latest Linus upstream, hoping to take advantage of the recent mpc85xx kex=
ec() support.

Unfortunately I'm getting a compile error:

arch/powerpc/platforms/85xx/smp.c:241: error: 'struct machdep_calls' has no=
 member named 'machine_kexec'

As far as I can tell, "machine_kexec" was removed in commit c9486878 (power=
pc/kexec: Remove ppc_md.machine_kexec) on Jan 6th, 2011, which claims that =
it was not used.

Unfortunately it looks like it *is* used by the mpc85xx kexec() support (co=
mmit f933a41e), added on Jul 21, 2010.

Cheers,
Kyle Moffett
