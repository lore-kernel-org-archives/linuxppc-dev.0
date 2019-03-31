Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25026C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 10:27:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E6A20872
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 10:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E6A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XBVv1M0czDqPV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 21:27:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XBT96ds0zDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 21:26:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44XBT90X7rz9sQt;
 Sun, 31 Mar 2019 21:26:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-4 tag
Date: Sun, 31 Mar 2019 21:26:08 +1100
Message-ID: <87pnq7l4qn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mahesh@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 5.1:

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-4

for you to fetch changes up to 6f845ebec2706841d15831fab3ffffcfd9e676fa:

  powerpc/pseries/mce: Fix misleading print for TLB mutlihit (2019-03-29 16:59:19 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.1 #4

Three non-regression fixes.

Our optimised memcmp could read past the end of one of the buffers and
potentially trigger a page fault leading to an oops.

Some of our code to read energy management data on PowerVM had an endian bug
leading to bogus results.

When reporting a machine check exception we incorrectly reported TLB multihits
as D-Cache multhits due to a missing entry in the array of causes.

Thanks to:
  Chandan Rajendra, Gautham R. Shenoy, Mahesh Salgaonkar, Segher Boessenkool,
  Vaidyanathan Srinivasan.

- ------------------------------------------------------------------
Gautham R. Shenoy (1):
      powerpc/pseries/energy: Use OF accessor functions to read ibm,drc-indexes

Mahesh Salgaonkar (1):
      powerpc/pseries/mce: Fix misleading print for TLB mutlihit

Michael Ellerman (1):
      powerpc/64: Fix memcmp reading past the end of src/dest


 arch/powerpc/lib/memcmp_64.S                    | 17 ++++++++++++----
 arch/powerpc/platforms/pseries/pseries_energy.c | 27 ++++++++++++++++---------
 arch/powerpc/platforms/pseries/ras.c            |  1 +
 3 files changed, 32 insertions(+), 13 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcoJWZAAoJEFHr6jzI4aWAM9sQAKzbaBFGhm+08w75Cz36I5zo
3gWG24Zzj7r2/wZfSaKIRSIKm1UvNjmhDWiQprkgVsQOScSwxfnwE9lkrGfGCFX8
eiIzNJFnCOg1ZBLfJFh/9yzWwfHiR57IqcN4lD8oAMLYVHR7JKJjA5vfTt8JxtUn
Z58im6uLgSdMnwvSJ3Wg5Oq4SX88cLsCUyQ9Mm5X0HY4LUrxboN6ofQkUj4AH55V
RG3+Z5WKoK0vQEkUrRREHpmjMB2e/fdaMULEjCLnAErU3Ip2Ku6nKZMHH3pZMC6Q
2yi2bMwXdWK9CH3lW7Q88EIGI7MYixLpLdxTedcqSI6meZaGaHAQJJEQySriPOt4
ArN5nfcfewDU9G+aT9up8JcdbBBJDvJ/ZKngPpZYQVszndwP9/O6Yv8digrckYcH
RAkd1kw8jHK1t45Z4bUU63hMhHmHuKagjlarSoorQg2s9i65y+56oCryXQbn52cc
blwI3O5/6ziLPiuJ76TpvVmUk1S4qL+KkFcDN6GOBUylZtcMfFoaq2vnDKrLwgkC
h1PfYLRqtwgAtY5Y8XKCEAkcT0W+qcr0O2jLM7CdNkm46dtV00E47GskfHzLf9Pi
1QleOgkcb/Ki9S+UsxWHedFGDmlxgv8MzIfyy8lQmdV1lz6gyliYKBSbZfAltCGu
b/zixlcVsA06NbDTPsya
=LkP1
-----END PGP SIGNATURE-----
