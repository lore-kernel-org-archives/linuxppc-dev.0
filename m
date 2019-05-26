Return-Path: <SRS0=FRR+=T2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9726CC282E3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 May 2019 16:22:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D916420657
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 May 2019 16:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9kOov7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D916420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45BlkF1ccXzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 02:22:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9kOov7C"; 
 dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Blhq4SlmzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 02:20:56 +1000 (AEST)
Received: by mail-lf1-x142.google.com with SMTP id l26so10340238lfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 May 2019 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=01nMFHopGBCZI/oY5AFsKMqNsMt7+AjmjgP0ZjkgZD0=;
 b=H9kOov7CMbdB+pTxe0jciE/0X9oGCvFwZWDK1QndljD3nCAkXWhPqQrhRAkQi59WA+
 d1eMVPPgA648vZfajLaltDW4PpoUB4pt83MyTL8K46y+UiuRDyXY5HNuTOJif87Lqecv
 kL+pn979wtoM5zsiZjVxsKyorZ5fDMvXc5EYdLwfb29E7UMtLbbi6SY6+B9EjVK9V9N9
 jppYbzw6fnq8W4DKmTORjKAQGOTgjdVW0TITDNwUDfmzZIQ2GHdOG9eZLBAnZ2U1JIpK
 oZea98ME0YjW6/g1Ch8EirFC6vsAF2YeXFVxSa5XzAQMHPBzbwOOEGdLWTiIgXY9fDAt
 gF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=01nMFHopGBCZI/oY5AFsKMqNsMt7+AjmjgP0ZjkgZD0=;
 b=RcwfnARkMtjtXAPOk3gu7lS9EGloSxBgY0naN9H7ejEThV3IQN0qzrAXomAWRuzsQD
 W+TP6tj1n6kDMb6sG0ZtNPsWxqvf1cZhiqafyxEouNYbUG7DpPPIhdTGk2P1ZYPlpYkY
 jYGdLJMplzv/GZcrIkZQ+K1Ts2fkUytLeJlQt4OD5Ur6bxJ8RGy3QQZfByR2Rpkb+2fX
 uKv7ilRxwJWy+rVcr+OKo/zhhxGRR63W10NGixEiEm8Eo0RmpTi9mQXDSoQ15vFM0hCJ
 rmtECIKb01do5Vfu6rUri6PpcIvVdfyOXzUWeHe8qLV+rdVeUunFr1smQaSrZgGHJcf3
 XdsA==
X-Gm-Message-State: APjAAAXHcgCdydnFx5zWesZ34N7YhFHoe8DglC+NYFhm6QNnTHwLHMQ+
 OaFwBxacYxdT9cpWD8L8BnBJkwYrPgr3oODtD1I=
X-Google-Smtp-Source: APXvYqwxMEk0IUeAy9UBTsg3h8S+c0X1iydUjhxKYRUIOzNVGYIXzMI1MwgnfY73XGd4ekjkgDqWVxxMzKH40Taah+c=
X-Received: by 2002:ac2:4213:: with SMTP id y19mr4505084lfh.66.1558887650127; 
 Sun, 26 May 2019 09:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190524234933.5133-1-joel@joelfernandes.org>
 <20190524234933.5133-5-joel@joelfernandes.org>
In-Reply-To: <20190524234933.5133-5-joel@joelfernandes.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 May 2019 18:20:39 +0200
Message-ID: <CANiq72noLXGXo7iarC1vCYX3X5L4fXq1DASK9gMtD_25-VEuHA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] rculist: Remove hlist_for_each_entry_rcu_notrace
 since no users
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: rcu@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 Josh Triplett <josh@joshtriplett.org>, Ingo Molnar <mingo@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 25, 2019 at 1:50 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The series removes all users of the API and with this patch, the API
> itself.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .clang-format           |  1 -

Ack for clang-format, and thanks for removing it there too! :-)

Cheers,
Miguel
