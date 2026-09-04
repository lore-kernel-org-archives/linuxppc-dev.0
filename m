Return-Path: <linuxppc-dev+bounces-26516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B95C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 02:59:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbh5015rJz2xlJ;
	Fri, 04 Sep 2026 12:59:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788490756;
	cv=none; b=mHEuvAee7qGlNs/MTqKfdqWxh3HXhVat1mNqQlrPQn7S3PUIXAZIW2nOdOZtia6JzkbuqaymGk5UNPudm1pvAcjbae14EaJAA1kCMlD7sdnxIGGG5C6emNFKJkvFmDqffFNrad4KAAX5j/BpQZM1SqmHqBsuOR2gyqQAW1/1/dx7CVVW2slc7fIB+IuM0FAYb/+NgGxANVSrbxM+qkkiYjSfSUDDlS8n03FEsVt6ykUGG9OUsnno/9qSlEBPJOOp8MShr/aA2UTMvkeFFhgfEcG4dgqOSKhux+SHfYzORRgpDA8fCR+WlmumoPyV+YLgbMZzuwIR37VZ67TDfYis+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788490756; c=relaxed/relaxed;
	bh=P3KGJqvLDVQEGw1qKiFatH8JZpCFUTHLvw8aN5u+gYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IOhOL0qkbz2kXEm7XsZB4RHPWHKtu7iLqCD952SAKp5P8RUBQ4JrimcsAP2riHWSWKIxPpiyPNgzAHQHdt7oeUowDOfc9lcqKr1/fxPD7G1jnRJLjSTug+Bq9NLIJiTvRFb6T1LbGDgE523b54whZQlWseZ1KX8qusDQuPxIX8belMLPCxHHSynzuiwyvtONi28VoFV8HuJaIfxuNOP5PKQrvTkVicYUhOzZW7Gnguc9v4/14P/CC1lW9/Kn7K/Gy3XXR6iSWT5b62XfUTRYVgR8g8AYs9WZedR5qpKFFBLwNz6wmpyM8FPYcLknM3CgSTNagnt+4EJMGSir3w4P/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MACppIAH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3_zoaag0kdcwzibpwlxzqgivsowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MACppIAH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3_zoaag0kdcwzibpwlxzqgivsowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbh4y3fRHz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:59:13 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so776387a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788490752; x=1789095552; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3KGJqvLDVQEGw1qKiFatH8JZpCFUTHLvw8aN5u+gYM=;
        b=MACppIAH41MDDZ6ROn29PKKErZFKYk7G1tyQEOaK+derXSFGL4pC19kP81nmOtkPAB
         xRhNZTAZkcdz7Dlx3iHvTUniyAIsufigb9KOCmnL0Bum6DrGhcoOYlmoYOB0IZH2CzG4
         Bc0O3N+XaI6KhWhpbMwGLUD7fKB1EN/NZXregAFd1E9p9ZPUaDqMN9e2C5cT4lO7ZBKe
         5/PD1hUIlzCbGP7DiQ/PC5lJqC2TG+br89QBJYVqcF3PJHk15yI2+i9Ua+Xip9dEyg6v
         XVddE2QUX5EqbEiFrrKUtbTqZYUOOT9EpfcS0Rn+4Sm9wpCrn8v8LEbYtV9p83XLUNJA
         BreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490752; x=1789095552;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3KGJqvLDVQEGw1qKiFatH8JZpCFUTHLvw8aN5u+gYM=;
        b=K4O7pwySb5ZexQ7iX27SeZ8DmbetZ4J5+0CEl5eyiJtvrnVNJwxFzKn7uv0RGqa6Y4
         UkHE7WfvQV3t9ovXd5zeuAeEzJS9N34w0RVZaTgGGltJZwAoeCSK+2OQkOtY0l7/LbVa
         Q3l38Vt7qMPkHyhZM3xVisexcAv9ejUBCTTmW2U9cqeQ6RsS+gXyIqVT2uyZy7vbtUwj
         2VURyqXBRsPSczjiVOFOlN40+odq6KBLIXwRwMeEIrGAPghPUrVJY/S098M7wkjXeott
         RlaaF8hMymRyveLtXTmOTpG+SnAPX0BMXAwBKDWrBCk0Kj+Eek/VWRJkd0gRCeKl1yWs
         fgOg==
X-Gm-Message-State: AFuF++mdWMfwRrimd3XBMbiv+LA4ShxqtDETzbTKSyi1ZrT/C7i9181l
	jAXgVjz8eg78LQqys1O53jDUzkjTuA7ssyuL6N9Ebut0Ewgnr8w+HvyM/45ByrBZ53zLDEGnVL8
	wu8EDQ9U2RADs7QZ2DgeL4RbJKYHChQo56A==
X-Received: from pgbm1-n1.prod.google.com ([2002:a05:6a02:6181:10b0:c85:6deb:ee45])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6708:b0:3cc:eea9:f757 with SMTP id adf61e73a8af0-3da3a00565emr4270762637.16.1788490751460;
 Thu, 03 Sep 2026 19:59:11 -0700 (PDT)
Date: Fri,  4 Sep 2026 02:59:11 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904025911.3960034-1-rathodpriyank@google.com>
Subject: Re: [PATCH v2 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn, Mahesh, Oliver,

Gentle ping on this 2-patch series fixing two memory leaks in PCIe AER error
handling (ghes_estatus_pool exhaustion on kfifo overflow and when pci_dev
is missing).

The series has been reviewed clean by Sashiko AI and compiles with W=1
(0 errors, 0 warnings). Could you please take a look when you have a chance?

Patchwork: https://patchwork.kernel.org/project/linux-pci/list/?series=1139683

Thanks,
Priyank

