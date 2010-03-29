Return-Path: <Li.Wang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ABD96B7CD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Mar 2010 18:12:26 +1100 (EST)
Message-ID: <4BB02886.2010307@windriver.com>
Date: Mon, 29 Mar 2010 12:11:50 +0800
From: "Li.Wang" <Li.Wang@windriver.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Help about Freescale p2020ds problem under cpu load test
Content-Type: multipart/mixed; boundary="------------090208080401080509050602"
Cc: Lans Zhang <jia.zhang@windriver.com>, "Xiong,
	Wei" <Wei.Xiong@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090208080401080509050602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Benjamin Herrenschmidt,

I use Freescale p2020ds board and kernel linux 2.6.33.
Under cpu load test which test case is in attachment
(#./cpu_load_multi.sh 500),
the follow issues happen after a long time:
=======================
find: md5sum terminated by signal 6

find: md5sum terminated by signal 11
=======================

If use kernel linux 2.6.27(porting p2020ds bsp to it), it's easy to 
reproduce the issue:
=======================
find: ../nptl/sysdeps/unix/sysv/linux/powerpc/../i386/../fork.c:138:
__libc_fork: Assertion `((void)(self), (((struct pthread *)
(__thread_register - 0x7000 - (sizeof (struct pthread) + ((sizeof
(tcbhead_t) + __alignof__ (struct pthread) - 1)&   ~(__alignof__ (struct
pthread) - 1))))))->tid) != ppid' failed.

find: md5sum terminated by signal 6

find: md5sum terminated by signal 11

./cpu_load.sh: line 6:  7944 Segmentation fault      find /usr -type f
-exec md5sum {} \;>    /dev/null
=======================

If turn off CONFIG_SMP, the issue disappear.

If use Freescale 8572ds board, the issue disappear, too.
I know the two board is same about cpu(e500v2), but their version have a 
little difference:
===================
fsl_8572ds:
cpu        : e500v2
revision    : 3.0 (pvr 8021 0030)

fsl_p2020ds:
cpu        : e500v2
revision    : 4.0 (pvr 8021 1040)
===================

Please help me to check the problem.
Thanks,
LiWang.

--------------090208080401080509050602
Content-Type: application/x-shellscript;
 name="cpu_load.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cpu_load.sh"

IyEvYmluL2Jhc2gKCndoaWxlIHRydWUKZG8KCQlmaW5kIC91c3IgLXR5cGUgZiAtZXhlYyBt
ZDVzdW0ge30gXDsgPiAvZGV2L251bGwKZG9uZQoK
--------------090208080401080509050602
Content-Type: application/x-shellscript;
 name="cpu_load_multi.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cpu_load_multi.sh"

IyEvYmluL2Jhc2gKCkk9JDEKd2hpbGUgWyAkSSAtZ3QgMCBdCmRvCgkJYGRpcm5hbWUgJDBg
L2NwdV9sb2FkLnNoJgoJCUk9YGV4cHIgJEkgLSAxYApkb25lCgoK
--------------090208080401080509050602--
