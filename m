Return-Path: <SRS0=KSz9=SP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B111AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 06:03:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2636B2084D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 06:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si7fupiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2636B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44h42H1tPNzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 16:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Si7fupiu"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44h40V23PGzDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 16:02:02 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id n8so6099158plp.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 23:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Kjs0Sgk7XTdpIoJ8y6VkwjrwR1BNLIBgFjEsaDIn3as=;
 b=Si7fupiuZIg5qjFUaVEHKQ+9sil0Df1H825ZxqKV8oHokioZLo9divzNf7O1VHNrKT
 XkAOCyqdB+gcvvGxr8wfbmU5tIrNFB2McziMtnrKQNVlp/2ZVN7dZ6qT55RTPrbnO7tJ
 DgQYMI689QofBzAHAQ2bwJ8OqkPf0Wxr6tZhyZEvSNuNhuMxetJoAfusiyx3MrnpJjil
 XRbQUihwS0mPi5ysehvsBJgl1D3yPRvlTq7rbvT0mkYPc2czLQuZXIsvgQtzbHEXkg3J
 5r7qBWpGKLl/oiWjF0/7jc5twa7iRyIq2kgrqqydbHsDurLLNFfyT+YBH38Z5rG/zXVR
 m2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Kjs0Sgk7XTdpIoJ8y6VkwjrwR1BNLIBgFjEsaDIn3as=;
 b=lYVTxMOEZ1Pr1nTivlvOQMwlWe+GXgnR5PMwsYzNXas/fZlv6vAGQJxNWtHnhKNFuI
 +vhLuIGpzBvdw8KqeOHC5IFs48EESDCToSMVXmDiW9aCyqBk3R1rWwsto5OA31uMpuOb
 ZEU/EDmU1c3gC8/aZUQw9qZ9FVfQhB2CiyWJ9KxxOT8X0NdTUjUsaAlbWLXmGZQlmmjG
 zrN5H+yLGns1XQZWPGmFht7miOW8Uh2W/3ku9bvnTRgkIxnsLamXnGy/8DPWPGn3bG+5
 487r6EGV67q9ol262/sQAvl/E/vnPx1oBhk3wI/AZ5cUNGJyyvpMFdDnQDB1H7T5ja5s
 VbZQ==
X-Gm-Message-State: APjAAAXCb4iwAQHjmiJgJAKHmwK9YeYIlAcs0bm1teak5SU4uvb/blpH
 HnPqfNyYnCerSSDzC4N1BEJRnGF9
X-Google-Smtp-Source: APXvYqwBCdAE7A/kDkFjSEOOlnjW9ttQsIUUDpXFx37bpqwJIB4i9xpVPd9d4Hkkt1JeA/bN2qzxJA==
X-Received: by 2002:a17:902:8b8c:: with SMTP id
 ay12mr13162231plb.192.1555135319011; 
 Fri, 12 Apr 2019 23:01:59 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
 by smtp.gmail.com with ESMTPSA id l1sm55116337pgo.13.2019.04.12.23.01.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Apr 2019 23:01:57 -0700 (PDT)
Date: Sat, 13 Apr 2019 16:01:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v9 2/2] powerpc/64s: KVM update for reimplement book3s
 idle code in C
To: kbuild test robot <lkp@intel.com>
References: <20190412143053.18567-2-npiggin@gmail.com>
 <201904131032.tgFf8rgW%lkp@intel.com>
In-Reply-To: <201904131032.tgFf8rgW%lkp@intel.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555135200.ppqz3puh5j.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

kbuild test robot's on April 13, 2019 12:51 pm:
> Hi Nicholas,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v5.1-rc4 next-20190412]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-=
64s-reimplement-book3s-idle-code-in-C/20190413-002437
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git=
 next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Dpowerpc=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    powerpc64-linux-gnu-ld: warning: orphan section `.gnu.hash' from `link=
er stubs' being placed in section `.gnu.hash'.
>    arch/powerpc/platforms/powernv/idle.o: In function `.pnv_cpu_offline':
>>> (.text+0x1900): undefined reference to `.idle_kvm_start_guest'

Argh, it took me longer than I'd like to admit to work this out. I'm
ELFv1-illiterate. Replacing .globl with _GLOBAL seems to fix it. I'll
roll that into the next patch.

Thanks,
Nick

=
