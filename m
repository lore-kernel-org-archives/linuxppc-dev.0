Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00959606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ovp3BYRG;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oLwxUna+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZ8vd3Pbdz2xdY;
	Wed, 25 Nov 2026 17:31:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795588269;
	cv=pass; b=ahWHbRVUWIOd0wpKNwPaU4+WQfXMaB9ProybhFgHHJTNCR7iH5Aji4+irmSDx5cl+JTxjBNoHy9BYY3ChgowBVc5As90qs2eXSOHsHB/ZAihTFV5VWD8rIQ3E76PdPehxiJ8rsxIhLC2PvoeRhtNU+LHICLqWqxMebGiIvXhw0cheLL4Xdc4xaY1s/OqA1ZI3wDQe1DhTOSKllfvqqR5lRavKV5aQ6gjXvEnpGnt4fDoTLuugDul3N82bqvJCTOfQxY0kUA7aIhVqO8z0O2btQViLMaMNnaAMkFAll8YaEGk3Omyj59yC7U1HbHZp/fE6QnPCt7lTuIbf1A3C3c6pg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795588269; c=relaxed/relaxed;
	bh=o8jZajVnvf/GJfi1qlNmvvNyUIVCwi/c/PQu82rl+LI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=kaAcrQFgx46PqcuK1aM+P1fSJF3StWVRpdXT8DIftenTwW84c4O60Pr8XrQ/z18kjXlJn6UDOAibVUGzUMuUEit2ezjmK/7hI7k+sdOXPrXrvwv1xm/S1E3B8vLiEiiD4+d6FYfYbxmXseyWrgT7lEROPpbbqa0J89aH2AcBhoiJ8JRmsB3JtRZgxSJeuwv2o0d/3twQ+4D+tIJ8p2KhNaCq8/hIWLP+RlEFE4/7vEbS8eVNv/MH4AJfZH6Ta1XsV2TSvVwRFl0Ug8k05qZFgLI2TrS494V2t8VzY/86Map13TGsiC1/uAf+ldGp6FPCPgxFMh2kVo5POJf37xvTcw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ovp3BYRG; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oLwxUna+; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ovp3BYRG;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oLwxUna+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ8vX6QZgz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 17:31:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1795588256; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WSfa9Gt6vZ7LC7bZm4px7zPy31tDunwtAdJYnD2KfarBGmBugnLhQHsMvkuE6ubMPC
    DJmz5P2VLccL7v43XZsibI24cs5iq0MvKJ2JPJZ7NLR911YbZB+EjiBIHVI+i4R8Ur55
    mLYfQA3tZzpDNj5ZpFXaFmGgMRxzhCW4zJbjjBtRiQen5tqkIiSkD36ZTBrf8UXknPNA
    ECTq+EdncIA9FV8R/SaH3bGgWpjjG//mTCjIkp+H570UwHDBmGdGOWLg36TqDXYhqXEt
    jhOEy5ByDlZrq1V7hTHSw8OTNSMTcyiUCHM6Qe4UNNZJJZqG0rc0y5usPh73bPPaMbuY
    KNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795588256;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=o8jZajVnvf/GJfi1qlNmvvNyUIVCwi/c/PQu82rl+LI=;
    b=N6B/P6ZWrZO/j881vmsAyhdJIRI/5vvgNojKgIwLZd0pOdAO+AN1cvSvClNIcZwouJ
    O1O06zejNjCn85oKisfWGnaSlqoBuwcm/XuN/NpmQkKkIKSAq6ooDDLYkQ/gjXyQojlS
    N5j8j+23B97G1Eh1dKZmGhNCfpFGPJm1YH1lg+ftUHq8F7npVXcFELR/dZZGPXNK9zWO
    K6quSJeu4BNhDym1RNv+ZUhigew+bvNcvYxZ3MNoFvcrl2AfbuayU77hhPPEOM85czh1
    k94oGmDvoUvpKUqLZgB1hzGLqasudOYFt2cov0n4grVpAsUog1YMSy8zQkQHdw/mdAHO
    kIAA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795588256;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=o8jZajVnvf/GJfi1qlNmvvNyUIVCwi/c/PQu82rl+LI=;
    b=ovp3BYRGMrvszB1cB781SDBvkG/FwHK+0efSto+EH91Dv3JZfInvAufCgdZ5POSWVV
    pZLNXUvqiGOUhm6c4z0W1nypwhJXHYbPRmrBGmWP1t1Uvyi6GKnIXBx1Wp0M3RtMYRjt
    OptGFKqTEdeX0f3mXXP0hC7dBMhc8KjkViZj5zGRyMheLb6YwcgXnDet9d/LCJNWTpfy
    pyB0iPBVRvYh3vpM0VGoHC6iebQHjgzrt0dXlIncFKjuACO2UhmEDciaIjOQSPqpTFTl
    T3qE3e2cjlcyxSnf70sGmGKBro3tYNxkuCgwLgIkKLWBb73UZZqUdOOW41KvEYNtUu70
    GsEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795588256;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=o8jZajVnvf/GJfi1qlNmvvNyUIVCwi/c/PQu82rl+LI=;
    b=oLwxUna+SxJ7Pjz7FYBQtXHqIoiwhCTz+UcYHJ1+/xz0lMRrLm8bReMWLr2km9FVQ+
    1dqiy7QkCpxDiZqyO6BQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5mzs3mRC3wE2YFOCcU01WtcQwPmgG2z3vC42vs="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d92AP6Utdgj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Nov 2026 07:30:55 +0100 (CET)
Content-Type: multipart/alternative; boundary=Apple-Mail-BF0521A1-9488-499E-A24D-32DD6E69B3A9
Content-Transfer-Encoding: 7bit
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PREEMPT] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
Date: Wed, 25 Nov 2026 07:30:44 +0100
Message-Id: <D0ECD6B8-7F15-48C8-87A4-DFE5F35A42D8@xenosoft.de>
References: <c7636032-b541-4ae9-b3b6-e3bf6fcec143@xenosoft.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de,
 harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
 venkat88@linux.ibm.com, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <c7636032-b541-4ae9-b3b6-e3bf6fcec143@xenosoft.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: iPhone Mail (24B156)
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	UNWANTED_DEVICE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Apple-Mail-BF0521A1-9488-499E-A24D-32DD6E69B3A9
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On 06 November 2026 at 07:09 am, Shrikanth Hegde wrote:

Hi Christian.

We had one known issue which michal had brought up.
Do you have tracing enabled or running a bpf/bcc program?

- - -

Yes, we have BPF and Tracing activated in the kernel config.

Nemo kernel config: https://github.com/chzigotzky/kernels/blob/main/configs/=
x1000_defconfig=

--Apple-Mail-BF0521A1-9488-499E-A24D-32DD6E69B3A9
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html class=3D"apple-mail-supports-explicit-dark-mode"><head><meta http-equi=
v=3D"content-type" content=3D"text/html; charset=3Dutf-8"></head><body dir=3D=
"auto"><div dir=3D"ltr"><div id=3D"AppleMailSignature" dir=3D"ltr"><div id=3D=
"AppleMailSignature" dir=3D"ltr">On 06 November 2026 at 07:09 am, Shrikanth H=
egde wrote:</div><div id=3D"AppleMailSignature" dir=3D"ltr"><br></div><div i=
d=3D"AppleMailSignature" dir=3D"ltr">Hi Christian.</div><div id=3D"AppleMail=
Signature" dir=3D"ltr"><br></div><div id=3D"AppleMailSignature" dir=3D"ltr">=
We had one known issue which michal had brought up.</div><div id=3D"AppleMai=
lSignature" dir=3D"ltr">Do you have tracing enabled or running a bpf/bcc pro=
gram?</div><div id=3D"AppleMailSignature" dir=3D"ltr"><br></div><div id=3D"A=
ppleMailSignature" dir=3D"ltr">- - -</div><div id=3D"AppleMailSignature" dir=
=3D"ltr"><br></div><div id=3D"AppleMailSignature" dir=3D"ltr">Yes, we have B=
PF and Tracing activated in the kernel config.</div><div id=3D"AppleMailSign=
ature" dir=3D"ltr"><br></div><div id=3D"AppleMailSignature" dir=3D"ltr">Nemo=
 kernel config: https://github.com/chzigotzky/kernels/blob/main/configs/x100=
0_defconfig</div></div></div></body></html>=

--Apple-Mail-BF0521A1-9488-499E-A24D-32DD6E69B3A9--

