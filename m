Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C327B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 14:45:12 +1000 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 5/9] blackfin: A couple of task->mm handling fixes
Date: Fri, 1 Jun 2012 00:36:35 -0400
References: <20120423070641.GA27702@lizard> <20120423070901.GE30752@lizard>
In-Reply-To: <20120423070901.GE30752@lizard>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4094434.0m95qSk5yE";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <201206010036.40468.vapier@gentoo.org>
Cc: linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 patches@linaro.org, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Richard Weinberger <richard@nod.at>, uclinux-dist-devel@blackfin.uclinux.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart4094434.0m95qSk5yE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 23 April 2012 03:09:01 Anton Vorontsov wrote:
> 1. Working with task->mm w/o getting mm or grabing the task lock is
>    dangerous as ->mm might disappear (exit_mm() assigns NULL under
>    task_lock(), so tasklist lock is not enough).

that isn't a problem for this code as it specifically checks if it's in an=
=20
atomic section.  if it is, then task->mm can't go away on us.

>    We can't use get_task_mm()/mmput() pair as mmput() might sleep,
>    so we have to take the task lock while handle its mm.

if we're not in an atomic section, then sleeping is fine.

> 2. Checking for process->mm is not enough because process' main
>    thread may exit or detach its mm via use_mm(), but other threads
>    may still have a valid mm.

i don't think it matters for this code (per the reasons above).

>    To catch this we use find_lock_task_mm(), which walks up all
>    threads and returns an appropriate task (with task lock held).

certainly fine for the non-atomic code path.  i guess we'll notice in crash=
es=20
if it causes a problem in atomic code paths as well.
=2Dmike

--nextPart4094434.0m95qSk5yE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPyEbYAAoJEEFjO5/oN/WBjkMP/jWhBHloIwNx3O8WdCb7Jkeb
oKrprqZwAeiXIZdZz4ENCnxaVidCjzIhkmuRyCyqTGK89Qwz2EDP7mwmIstn88eQ
XZn77Psp8Qa4F8ZmycV2u+rhqrZK+zybSNNuk05V7K5NrSXPDBSFCYnN0K0svApX
bG4nRGqPE7gOfHDh62h+r7MIfdCavXgp66xm3cUJ8gDzWCsN8+epSJK/Oh/J8L9b
FESfd6zyN25ij8+j6K8pY1n0HFBsSCgWFKgz41DDALeNxAspC9Fsn4fjeA8NnpQ6
6K1COIvAcaQ6zcZlzjcn1igjGCpvkLoXT1nLGuN9cFr/H2JJ5kxxGhQ25I25Voxx
cPiGjGqTAsl5+PavwNlt6q+dUHT04hdKcJmFad3LJneDmKVw9D/UGY21WWzu7vTP
ZLotT0ntVjr/Cuqt0J3iBMxUdq2tncWrpXD4cr/TJvvALKXgLQTaO6iVMiptDYVq
HtSnThyOfplo8vu/l7kYiYPzlGO/uccOrw5kk6lOCokzzzwGZwV+urrDffvH2iWz
+OimgpLcSg8qoqDBQqb3qg5elIbroAcbSfHRDMs6c4Ld9iUcyNyjxJPQDvdU9Hyl
qJve50YbbUEgcxGQTsVKuzWkrajjeCCQCabGiiHIlLPOSr5nK10WTGTXQVUTivt2
bZv1rSS6aLk4w6YM4TVm
=GWQm
-----END PGP SIGNATURE-----

--nextPart4094434.0m95qSk5yE--
