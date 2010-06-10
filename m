Return-Path: <crichton@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 83C25B7D80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 23:50:33 +1000 (EST)
Received: by yxd5 with SMTP id 5so1427253yxd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 06:50:31 -0700 (PDT)
Message-ID: <4C10EDA2.2080303@gmail.com>
Date: Thu, 10 Jun 2010 09:50:26 -0400
From: Mark Crichton <crichton@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Mac Mini suspend issues - misidentified model
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've dug up and revived my old Mac Mini (PPC) and been trying to get it
to work again. I was looking at getting the system to suspend to ram,
but it didn't seem to be working. So, I tried to trace down the problem.

I took a look at the kernel code, and I think I may have found the
issue. According to /proc/cpuinfo, my model is a "PowerMac10,2". Looking
at platforms/powermac/feature.c, I only see an entry for "PowerMac10,1".
- From my understanding of the code, this means my machine doesn't get
PMAC_MB_MAY_SLEEP set, hence no suspend to ram.

I can easily get a patch together to just copy the PowerMac10,1 entry in
pmac_mb_defs, for the PowerMac10,2, but I also was wondering if there's
some issues I may run into. However, from what I see in the code, this
seems to be a pretty risk-free operation.

Am I on the right track for this one?

Thanks,
Mark Crichton
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkwQ7aIACgkQOfj2Ja/u/oBxYACeOX5jUQOJ5XloojtoZJXneZL/
734An1mP41QPuLg/RtVllmgQjgdBxdBJ
=LLH3
-----END PGP SIGNATURE-----
