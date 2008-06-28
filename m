Return-Path: <emunson@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1C30DDF02
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 10:08:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5S08dI0007178
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 20:08:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5S08dRl097720
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 18:08:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5S08dwm021758
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 18:08:39 -0600
Date: Fri, 27 Jun 2008 17:08:13 -0700
From: Eric B Munson <ebmunson@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] Keep 3 high personality bytes across exec
Message-ID: <20080628000813.GA19960@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently when a 32 bit process is exec'd on a powerpc 64 bit host the value
in the top three bytes of the personality is clobbered.  This patch adds a
check in the SET_PERSONALITY macro that will carry all the values in the top
three bytes across the exec.

These three bytes currently carry flags to disable address randomisation,
limit the address space, force zeroing of an mmapped page, etc.  Should an
application set any of these bits they will be maintained and honoured on
homogeneous environment but discarded and ignored on a heterogeneous
environment.  So if an application requires all mmapped pages to be initial=
ised
to zero and a wrapper is used to setup the personality and exec the target,
these flags will remain set on an all 32 or all 64 bit envrionment, but they
will be lost in the exec on a mixed 32/64 bit environment.  Losing these bi=
ts
means that the same application would behave differently in different
environments.  Tested on a POWER5+ machine with 64bit kernel and a mixed
64/32 bit user space.

Signed-off-by: Eric B Munson <ebmunson@us.ibm.com>

---
V2

Changes from V1:
Updated changelog with a better description of why this change is useful

Based on 2.6.26-rc6

 include/asm-powerpc/elf.h   |    3 ++-
 include/linux/personality.h |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 9080d85..2f11a0e 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -257,7 +257,8 @@ do {								\
 	else							\
 		clear_thread_flag(TIF_ABI_PENDING);		\
 	if (personality(current->personality) !=3D PER_LINUX32)	\
-		set_personality(PER_LINUX);			\
+		set_personality(PER_LINUX |			\
+			(current->personality & PER_INHERIT));	\
 } while (0)
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
diff --git a/include/linux/personality.h b/include/linux/personality.h
index a84e9ff..362eb90 100644
--- a/include/linux/personality.h
+++ b/include/linux/personality.h
@@ -36,6 +36,12 @@ enum {
 	ADDR_LIMIT_3GB =3D 	0x8000000,
 };
=20
+/* Mask for the above personality values */
+#define PER_INHERIT (ADDR_NO_RANDOMIZE|FDPIC_FUNCPTRS|MMAP_PAGE_ZERO| \
+			ADDR_COMPAT_LAYOUT|READ_IMPLIES_EXEC|ADDR_LIMIT_32BIT| \
+			SHORT_INODE|WHOLE_SECONDS|STICKY_TIMEOUTS| \
+			ADDR_LIMIT_3GB)
+
 /*
  * Security-relevant compatibility flags that must be
  * cleared upon setuid or setgid exec:


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZYDtsnv9E83jkzoRAu98AKDB62YlUFX951qoC8PItG1iOu0akACgijgX
5HmGq6MTB19tIiQGbCJOfjU=
=BpRd
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
