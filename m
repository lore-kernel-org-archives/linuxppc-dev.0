Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D4606A8BD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BmNjmGLE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQbSt4hCfz2yD8;
	Fri, 13 Nov 2026 10:00:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794492558;
	cv=none; b=aaSEfvDlw2FUwVVbZT4yxo9SNtTYB8d99k/eX++EVlWg+Py97NA8sDYcuZtJILdiBjDlawA6bCc4xjkeaHQJADA+aDnne/GgPtBW7AP8ee5HDT0YI0LPXo7TAYT2Nem0lIMDucNIv+6NWdByrUDq6cJQrVNPbinirNJvm+W9kVl5eq3jT0iRplKMcX01Zgeb6GCSmJ/7X/uo8qW85iRM4QQ2alMM/bWGOCxQVC7yZwLSztvbZ9UohCIXfwglAThVCyQVn/1I+aW1gf75u8AF4vZS4nMQgyktf4XAkpcnfJ08rh1foxUQcDSOFtTHusKi4OXpCXxPpwqTKXl7Q5oyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794492558; c=relaxed/relaxed;
	bh=4eTucFZNSL9MZwK8+YG2mr7BhDfI+QpIeohJvthNO/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPiFuyoGhDFLt4i0licbHtMODauodEYkQlotkbj79jCU6mBW3QDaAHQ78NCoV8395EOA4A/MsbnpI+nCEUcJkxjFFsTgTRdm9nR5XH2ybBBZdNGixQsfDapYw7DU3mBIoBsaX1GFGZ9qdtAr7iIR+9zj/0Y/3BMJf4n/WpTu+OLWAkiN7klQDbRmixZhDUeZFcj6uOHwXVhNfmJ0oMRR5TcyiV5K2mcslprF4jPvhm6vkdFxNGW43Pw9cPrA4QbueOsUkS8554+XVzK/BmvZidYCQH0LFZl9vC6TJpZWuWfEgnZlZF5gOk64TS7MKXJ9JBj/PdcfTmQDvy394l69fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=igalia.com; dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BmNjmGLE; dkim-atps=neutral; spf=pass (client-ip=213.97.179.56; helo=fanzine2.igalia.com; envelope-from=luis@igalia.com; receiver=lists.ozlabs.org) smtp.mailfrom=igalia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BmNjmGLE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=igalia.com (client-ip=213.97.179.56; helo=fanzine2.igalia.com; envelope-from=luis@igalia.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2058 seconds by postgrey-1.37 at boromir; Fri, 13 Nov 2026 01:09:16 AEDT
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQMhD10rkz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:09:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=4eTucFZNSL9MZwK8+YG2mr7BhDfI+QpIeohJvthNO/w=; t=1794492556; x=2109852556; 
	b=BmNjmGLEn8LwqIPepxiNnEJFw/quGg1Tk4poLxUF5ozEa7oB9abTgc/8us6yy3432x4dXm7KOQK
	wl2zSsV9d4iyWCYByRzpW1scNLQnTHaCz79FFFEm3gMlOpVqL+c2rnsPKW22l2fBbD8e73NWXLI5G
	6S+N20Z+6D+/8tadQlTXOV6TD3isuCI1GtanZkYh4nY1hQMNf4mDBa7SHcoRMyXvyvXa3NNiibbH3
	LASILYGO5CWUxeTjgIzt5Bl3HzLmSWCShfUuY1qHXJBmlnnsIKkAa2CXCXMiZ/axp+zGKTaaYGX39
	3vCVHCtOYkYYbJhhPJsTqV7evLqv+3VgcUdQ==;
Received: from bl16-24-61.dsl.telepac.pt ([188.81.24.61] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xRUwt-009YpT-Vp; Thu, 12 Nov 2026 14:34:44 +0100
From: Luis Henriques <luis@igalia.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: mszeredi@redhat.com,  Shuah Khan <shuah@kernel.org>,
  amir73il@gmail.com,  linux-fsdevel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>,
  linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,  nandinih@linux.ibm.com,
 fuse-devel@lists.linux.dev
Subject: Re: [BUG / BUILD FAILURE] selftests/fuse: build failure with
 libfuse < 3.17.0 (RHEL 10 / fuse3-3.16.2)
In-Reply-To: <bc84cb05-55fe-43e7-9a6e-e6bbf2f5a9ff@linux.ibm.com>
References: <bc84cb05-55fe-43e7-9a6e-e6bbf2f5a9ff@linux.ibm.com>
Date: Thu, 12 Nov 2026 13:36:27 +0000
Message-ID: <87ld6yxjc4.fsf@igalia.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Venkat,

[ CC'ing the fuse mailing-list ]

On Thu, Nov 12 2026, Venkat Rao Bagalkote wrote:

> Hi Miklos, Luis,
>
>
> IBM CI has reported a build failure, while building selftests/fuse, due to
> missing definitions in libfuse3 headers.
>
> Environment:
>
> OS: RHEL 10 (ppc64le)
> Kernel: upstream (linux-next / mainline)
> libfuse package: fuse3-devel-3.16.2-5.el10.ppc64le (pkg-config --modversi=
on
> fuse3 -> 3.16.2)
>
> Build Errors:
>
> In fuse_acl_cache_test.c & fuse_symlink_cache_test.c:
>
> fuse_acl_cache_test.c: In function =E2=80=98fs_init=E2=80=99:
> fuse_acl_cache_test.c:105:17: error: implicit declaration of function
> =E2=80=98fuse_set_feature_flag=E2=80=99 [-Wimplicit-function-declaration]
> =C2=A0 105 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fuse_set_feature_flag(conn, FUSE_CAP_POSIX_ACL);
> =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~
> make: *** [../../lib.mk:226:
> /home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_acl_=
cache_test]
> Error 1
>
> In fuse_mnt.c:
>
> fuse_mnt.c: In function =E2=80=98test_readdir=E2=80=99:
> fuse_mnt.c:51:35: error: =E2=80=98FUSE_FILL_DIR_DEFAULTS=E2=80=99 undecla=
red (first use in this
> function); did you mean =E2=80=98FUSE_FILL_DIR_PLUS=E2=80=99?
> =C2=A0 =C2=A051 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filler(buf, ".", NULL,=
 0, FUSE_FILL_DIR_DEFAULTS);
> =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~~~~~~~~~~~~~~~~~
> =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FUSE_FILL_DIR_PLUS
> make: *** [../../lib.mk:226:
> /home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_mnt]=
 Error
> 1

Thank you for your report.

This issue was already identified and fixed by Sasha[1].  Looks like there
was some problem when my patchest[2] was applied to the git tree:
commit 3e14f079d7a0 ("selftests/fuse: add fuse symlink caching test")
dropped the actual test code that was present in the patch.

I believe Sasha's fix wasn't yet applied, but I guess that will eventually
happen.

[1] https://lore.kernel.org/all/20261026194008.274349-1-sashal@kernel.org/
[2] https://lore.kernel.org/all/20261001164916.15311-1-luis@igalia.com

Cheers,
--=20
Lu=C3=ADs

