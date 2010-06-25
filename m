Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C61F8B6EDF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jun 2010 00:55:33 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Subject: HWCAP for fsqrt vs PPC64
Date: Fri, 25 Jun 2010 09:51:42 -0500
Message-Id: <A147B597-35D6-47A4-A2A2-33954C37E332@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>, Paul Mackerras <paulus@samba.org>,
	Wienskoski Edmar-RA8797 <RA8797@freescale.com>,
	Stewart Katherine-RA4863 <ra4863@freescale.com>,
	"Joseph S. Myers" <joseph@codesourcery.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	libc-alpha@sourceware.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys,

We seem to be using the PPC_FEATURE_64 HWCAP to imply fsqrt support.  =
However, the new e5500 core from Freescale that is 64-bit does NOT =
implement fsqrt so this assumption is wrong:

sysdeps/powerpc/fpu/math_private.h

# if __WORDSIZE =3D=3D 64 || defined _ARCH_PWR4
#  define __CPU_HAS_FSQRT 1
# else
#  define __CPU_HAS_FSQRT ((GLRO(dl_hwcap) & PPC_FEATURE_64) !=3D 0)
# endif

Open to suggestions on how to fix this as its a kernel/libc interaction =
point.

- k=
