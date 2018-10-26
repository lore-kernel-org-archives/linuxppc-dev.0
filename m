Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6D2C46475
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:42:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2B020856
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Kcw8JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2B020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hzWN58flzF10b
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 22:42:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4Kcw8JC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4Kcw8JC"; 
 dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hY7K44zBzF3Hg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 05:54:05 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id w16-v6so1695033lfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YSCo8uNIuTuy167cDW74WBGLJtzms6hFrgMG3hXLnbU=;
 b=B4Kcw8JCuQokXQQ9ns6eW7NmqRYq2HoF2m4yb71AKW4ttZn67gNfOzfk8LgTEyPGt1
 qk5Mo6QUoMghVnLwwlH7Q90WohjeYB7TAH8xu9AgDaAIOIqWAepKdXhPF8/l7Oj67jYt
 KeyP4Hb5d8Fk4sNRe6xQgJK4qqdfVAugbiX35UAhz5mO3Luc1Seyey/zh7nInCUSfFXe
 baEsMjlBiCpPw7cpOnLhqckRbv+Nl8RKZ8ZpSH9S41idtbjc4oQKN383xFHx7MX27U79
 Px6CN/QcliwMLfFBt7Iu2hxGmsRnv9cbvjFN84mV/0tfOPjRp++2ROz/SLFdxYhXpL3i
 B7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YSCo8uNIuTuy167cDW74WBGLJtzms6hFrgMG3hXLnbU=;
 b=dyQZ7AX0KzfyEBhZFsVHAjXQx/G8QAUbhZgoLB+iMmNgUyX7PRu/Aku3Siwhl3gcxv
 T+olwNeuTYgblawZZKuwTIKVQmkJgM5ewFTT8136qkNB6kYiKxypu9QIn3HqiF8CYUPK
 6yHfkAPFV5nbwRJEW2P2f+ktaI/5nwaEKjnETNWUIC/rVCL+C4IKdq5iPpHAlqnogx34
 CivJjz617oX5I2BAz0JMJDKY27/qJw4f97b59UiwVnM+Tz/gtSHMKZemNVouZsOjcREF
 uGOK+MzhseXzYOMN7pcffVn/1vAy/gq5YPuiwSQL00CAUcDmenFA0tyBHCdbwkaQw20L
 RzYg==
X-Gm-Message-State: AGRZ1gIHXVkxu7z5ZKV7HKEUGhtiayxAIB+m0NBaL3e8HQMFznd6xlbx
 5ncD2r0vuBTs3SfaaOYMLFnzMfFhs0s230o5nmg=
X-Google-Smtp-Source: AJdET5cbmSHziGXKx7NzB4egJm094vKy0sh88KGamYMQTYMfJr4Hm+Ed5nZHvS1iNeydMoN40U3YWYqYK9M1Tx++5QY=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr2868444lfk.151.1540580042085; 
 Fri, 26 Oct 2018 11:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181026172549.3628-1-colin.king@canonical.com>
 <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
 <20181026184009.GV25444@bombadil.infradead.org>
In-Reply-To: <20181026184009.GV25444@bombadil.infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Oct 2018 20:53:50 +0200
Message-ID: <CANiq72m-2FU7ioqj9sqsfWk4nSp2FO9S_8kYcbnGReXNAXYM2w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 27 Oct 2018 22:38:08 +1100
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
Cc: kernel-janitors@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Dave Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 maarten.lankhorst@linux.intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
 maxime.ripard@bootlin.com, jk@ozlabs.org, colin.king@canonical.com,
 sean@poorly.run
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 8:40 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 26, 2018 at 08:20:12PM +0200, Miguel Ojeda wrote:
> > On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com> w=
rote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Trivial fix to a spelling mistake of the error access name EACCESS,
> > > rename to EACCES
> >
> > ? It is not a typo, it is the name of the error (POSIX). Same thing
> > for the rest of the patches.
>
> Are you sure?  From open(2):
>
>        EACCES The  requested access to the file is not allowed, or search=
 per=E2=80=90
>               mission is denied for one of the directories in the path  p=
refix
>               of  pathname,  or the file did not exist yet and write acce=
ss to
>               the parent directory is not  allowed.   (See  also  path_re=
solu=E2=80=90
>               tion(7).)
>
> include/uapi/asm-generic/errno-base.h:#define   EACCES          13      /=
* Permission denied */

I thought you were doing the reverse change. Never mind! :-)

(Btw, the POSIX reference is
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html#tag_1=
3_09,
in case you want to include it or are curious)

Cheers,
Miguel
