Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B380AC4707B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jan 2024 00:09:12 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KCW9Ph1y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TB22Z6Vm3z3d9H
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jan 2024 11:09:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KCW9Ph1y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=oohall@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TB21g2MTWz3bpM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2024 11:08:23 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so33153405ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2024 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705018101; x=1705622901; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIf4c7DFQO5nPyi8q4vtWeh5h7pOS1tPwvXmwJAqfEk=;
        b=KCW9Ph1yjmXe1pkXhEIMJ7DlhObitZfvQdJciDzJwa/3WZtVTM1+89nnw1w1kcOd0L
         DPBcXKNkBzfNISjR1Scd7Wf1WsvurN1IZDm0KpYKf1jKlkU1TG0HcQ7UFE/Ft87WE40l
         mBVgqyjSTPuifgpReIFh2xeVcyqEWgyKLnpZAsHHmphQJeq6P+ftPWJnkEJKmpPbhPfT
         lpQcJbJldeH/dWK81VxPa5CMSHXWvOzfPfKAmUpuAmjSDTIZOqYXJmM/Qd2/nbIQjftF
         HGgWTsy+6mEBYJhOAU0TWIazAU4EIg0dKvbx8QSYVJ4vZ7886bF5juXDnnfkJBSTXsBL
         tYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705018101; x=1705622901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIf4c7DFQO5nPyi8q4vtWeh5h7pOS1tPwvXmwJAqfEk=;
        b=QgcRNkKbqtEn6JuQnh0/kAMGUF+nOjez3fIDYY/gbfsWNQ0xDpT9+KzxAVyBCfA2GS
         BY84vq4GdlbUY0NWoEtbNqSO8jmbLB5mCCEEbntL0q/1Qi+1ls05XjAMI4cmozEo5HwA
         lVgqdgQxamt2QokduVd98TYeYji0ZlV6ySH1LjrS54L6o3nxEtkI6+Lu4olGtG3vEt/w
         tllH+3B7T1WuflitsIRSXDrU1uKqtXRxC/cbaPGQMUwJ29IqgBduUpzZ2+eObpaO0SZp
         jR3eWRhDgv7xM0tRmoySVh84Kxw/ZhBc+HDIeMjtEpg6KWnV7QkKnobnKPmS3tntiFr+
         FFuw==
X-Gm-Message-State: AOJu0YyJXLVF8kNPJMgyGeMcrvytCDmSfjpEANe7I1bBmrJmp5n+3Fd5
	cfeTycvfgkR4eAMeu2aWJiuXvp1b01OZmb6BYP7JsWYo6UqXlg==
X-Google-Smtp-Source: AGHT+IEILvj1pZiMSNAbHRkYyaIVOMK+M4AgQV/hr2Q0LIgu+eCye7UIPlyeYElaiH4cS4I3Fn5pbGMb0+0AvLTiD+Y=
X-Received: by 2002:a17:903:1ce:b0:1d4:c27d:8428 with SMTP id
 e14-20020a17090301ce00b001d4c27d8428mr93181plh.60.1705018100780; Thu, 11 Jan
 2024 16:08:20 -0800 (PST)
MIME-Version: 1.0
References: <674182417.2124034.1703736924982.JavaMail.zimbra@raptorengineeringinc.com>
 <1981605666.2142272.1703742465927.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1981605666.2142272.1703742465927.JavaMail.zimbra@raptorengineeringinc.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 12 Jan 2024 11:08:09 +1100
Message-ID: <CAOSf1CFwY5h5JrKjv8c0kDHtoFrkN8EQUGOzuszR0S1W_g3ojA@mail.gmail.com>
Subject: Re: PowerNV PCIe hotplug support?
To: Timothy Pearson <tpearson@raptorengineering.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 28, 2023 at 4:49=E2=80=AFPM Timothy Pearson
<tpearson@raptorengineering.com> wrote:
>
> Hrmm, potentially related, I'm getting a kernel oops when I try to hot un=
plug the entire PCIe switch from the PHB4:

IIRC there's hard to fix races in the pci core around removal of pci
slot devices. Maybe someone fixed those since I tried last, but I'd
just avoid doing that if I were you.
