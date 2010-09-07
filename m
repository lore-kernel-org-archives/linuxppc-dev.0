Return-Path: <dcb314@hotmail.com>
Received: from blu0-omc3-s33.blu0.hotmail.com (blu0-omc3-s33.blu0.hotmail.com
	[65.55.116.108]) by ozlabs.org (Postfix) with ESMTP id E0D5EB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Sep 2010 05:00:48 +1000 (EST)
Message-ID: <BLU108-W2623DC5A7393DA1E1E4B079C710@phx.gbl>
From: d binderman <dcb314@hotmail.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>
Subject: linux-2.6.36-rc3 bug report
Date: Tue, 7 Sep 2010 19:00:44 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Hello there=2C

I just tried out cppcheck-1.44 on the linux-2.6.36-rc3 source code.

It said

Checking arch/powerpc/kernel/ppc970-pmu.c...
[arch/powerpc/kernel/ppc970-pmu.c:171]: (style) Redundant assignment of "ma=
sk" in switch

The source code is

=A0=A0=A0=A0=A0=A0=A0 case PM_VPU:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask =3D 0x4c=3B=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /* byte 0 bits 2=2C3=2C6 */
=A0=A0=A0=A0=A0=A0=A0 case PM_LSU0:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* byte 2 bits 0=2C2=2C3=2C4=
=2C6=3B all of byte 1 */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask =3D 0x085dff00=3B
=A0=A0=A0=A0=A0=A0=A0 case PM_LSU1L:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask =3D 0x50 << 24=3B=A0=A0=
=A0=A0=A0 /* byte 3 bits 4=2C6 */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break=3B

It looks to me like a missing break on the first and second cases.
Suggest code rework.

Regards

David Binderman

 		 	   		  =
