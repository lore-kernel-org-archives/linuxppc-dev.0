Date: Sat, 20 Sep 2003 08:59:00 -0700
From: Dale Harris <rodmur@maybe.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: problems with 2.4.23-pre4-ben0
Message-ID: <20030920155900.GB26953@maybe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There is couple of compile problem I have with the kernel at
source.mvista.com::linuxppc_2_4_benh

Missing a comma in /usr/src/linuxppc_2_4_benh/include/linux/agp_backend.h

--- agp_backend.h.orig  2003-09-17 19:02:27.000000000 -0400
+++ agp_backend.h       2003-09-20 11:25:15.000000000 -0400
@@ -99,7 +99,7 @@
        ATI_RS300_100,
        ATI_RS300_133,
        ATI_RS300_166,
-       ATI_RS300_200
+       ATI_RS300_200,
        APPLE_UNINORTH
 };


gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linuxppc_2_4_benh/include -I/usr/src/linuxppc_2_4_benh/arch/ppc -D__BOOTER__   -c -o ../common/util.o ../common/util.S
../common/util.S: Assembler messages:
../common/util.S:207: Warning: setting incorrect section attributes for .relocate_code
../common/util.o: File truncated
../common/util.S:268: FATAL: Can't write ../common/util.o: File truncated
make[3]: *** [../common/util.o] Error 1


Looks like is from:

.section ".relocate_code","xa"

Which I have no idea what the proper setting is supposed to be.

--
Dale Harris
rodmur@maybe.org
/.-)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
