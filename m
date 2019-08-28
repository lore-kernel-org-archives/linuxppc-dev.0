Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D8EC3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 11:01:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26148208CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 11:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPTJU0js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26148208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JN8C3LLSzDr6l
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 21:00:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EPTJU0js"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JN5z5CBzzDr2r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 20:59:03 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id gn20so1081105plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=3PfQgtmB/PeAwXzGWu3d6xyhKveRxe5sV2Su3HbU17A=;
 b=EPTJU0js8l61hptAqP3s6hKS9aCaWQCN7ibiSNdE0YlenTrKIvMaJsnL00ZDyH/1Id
 HVjpQ8BxRVeJoMR7sXd8i/JICRFB0D615CJqg0mmYhS5NFUbNLc6AOnYQZhHqvb5tsfX
 GblMVaNIspx1j8Yr2R3D7tXDwmArQhhIJac7WuPlmLoPXveMQVakQQ1YCrui6Yj8B83O
 02s7Cw7xXknEuKTxMY7nAKHpg56M2d55t1SnI14IxCd8UkjAYdcOpGUCwa53rTVmCgoC
 tp6JYtulQCexCDDiG0UY0djuW7xN6WkBA2AmAZxVD1lo6KFWXbIe3CX16vId+io8PIfK
 XKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=3PfQgtmB/PeAwXzGWu3d6xyhKveRxe5sV2Su3HbU17A=;
 b=oApjoUgZVqnheVGwCIqDb6ukkd4o8pL9jVCnpe1nrO3lHTO53Pc+94TyLZ80UXE7GW
 hop9pfeqpHjShrlnFUyqFqBQ4+C/f81Qbnany/RMYYAiwE1Imp/Tbe+PaV26sXhtzQH9
 tAAegYQ/lHgwboCuKeDPy/54HxVnFO0jGirmDsWhuNOPaHcga+5Yy1arWOXfOoeqdTPX
 1LByuXUrWUW8B65svUMixZAJ9ysSDwy/6yMPklfD4B57WcNxB6RnMByctg3aoMDkUSGj
 EaV8htsQ5Boedo9D6UmqIlgriodWVqD39wBgmV+jVDkVNJ29Se1x05xTL3qJFBrsZ4mq
 JeVw==
X-Gm-Message-State: APjAAAVaSlUxX1uNKDBy9I/g6DLnBAcK8Svq+qkKY/55erevpGV8bGED
 Rq/DTAqfFIDNz9hxzcRNZFPCoqp+
X-Google-Smtp-Source: APXvYqwGf181xs50DmlZ+yXjcA3Ha+rq4NNQ+z03UQuBiE/tZSYbrDXwgyYFSdpeT6T3QIgucQmJpg==
X-Received: by 2002:a17:902:7592:: with SMTP id
 j18mr3671462pll.186.1566989940790; 
 Wed, 28 Aug 2019 03:59:00 -0700 (PDT)
Received: from localhost (14-202-91-55.tpgi.com.au. [14.202.91.55])
 by smtp.gmail.com with ESMTPSA id g8sm1969083pgk.1.2019.08.28.03.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 03:59:00 -0700 (PDT)
Date: Wed, 28 Aug 2019 20:57:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/4] Disable compat cruft on ppc64le v2
To: linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
References: <cover.1566987936.git.msuchanek@suse.de>
In-Reply-To: <cover.1566987936.git.msuchanek@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566988993.aiyajovdx0.astroid@bobo.none>
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
Cc: David Hildenbrand <david@redhat.com>, "Dmitry V. Levin" <ldv@altlinux.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Breno Leitao <leitao@debian.org>, Michael Neuling <mikey@neuling.org>,
 Firoz Khan <firoz.khan@linaro.org>, Allison Randal <allison@lohutok.net>,
 Joel Stanley <joel@jms.id.au>, Steven Rostedt <rostedt@goodmis.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Suchanek's on August 28, 2019 8:30 pm:
> With endian switch disabled by default the ppc64le compat supports
> ppc32le only which is something next to nobody has binaries for.
>=20
> Less code means less bugs so drop the compat stuff.

Interesting patches, thanks for looking into it. I don't know much
about compat and wrong endian userspaces. I think sys_switch_endian
is enabled though, it's just a strange fast endian swap thing that
has been disabled by default.

The first patches look pretty good. Maybe for the last one it could
become a selectable option?


> I am not particularly sure about the best way to resolve the llseek
> situation. I don't see anything in the syscal tables making it
> 32bit-only so I suppose it should be available on 64bit as well.

It's for 32-bit userspace only. Can we just get rid of it, or is
there some old broken 64-bit BE userspace that tries to call it?

Thanks,
Nick

=
