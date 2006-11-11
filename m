Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D613967FAD
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:51:04 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Date: Sat, 11 Nov 2006 12:50:58 +0100
References: <4554DACB.8060809@am.sony.com>
In-Reply-To: <4554DACB.8060809@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611111250.59279.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 21:02, Geoff Levand wrote:
> @@ -876,7 +885,7 @@
> =A0=A0=A0=A0=A0=A0=A0=A0bool "PCI support" if 40x || CPM2 || PPC_83xx || =
PPC_85xx || PPC_86xx \
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|| PPC_MPC52xx || (EMBEDD=
ED && PPC_ISERIES) || MPC7448HPC2
> =A0=A0=A0=A0=A0=A0=A0=A0default y if !40x && !CPM2 && !8xx && !APUS && !P=
PC_83xx \
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&& !PPC_85xx && !PPC_86xx
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&& !PPC_85xx && !PPC_86xx &=
& !PS3PF
> =A0=A0=A0=A0=A0=A0=A0=A0default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && =
APUS
> =A0=A0=A0=A0=A0=A0=A0=A0default PCI_QSPAN if !4xx && !CPM2 && 8xx
> =A0=A0=A0=A0=A0=A0=A0=A0help

This change causes trouble when trying to build a multiplatform kernel
that includes PS3PF and others at the same time, because PCI gets
disabled unconditionally when PS3PF is selected. As a short-term
fix, I'd change this to do

        bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86=
xx \
=2D               || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2
+               || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 \
+               || PS3PF
        default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
               && !PPC_85xx && !PPC_86xx

Which makes PCI support optional when PS3PF is selected. However, this still
means that you can choose broken configurations (e.g. PSERIES=3Dy, PS3PF=3D=
y,
PCI=3Dn).

The real fix should be to get rid of the long conditional for CONFIG_PCI,
and have PCI selected by the platforms themselves:

config PPC_PSERIES
	select PCI

	Arnd <><
