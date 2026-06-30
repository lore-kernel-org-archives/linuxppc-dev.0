Return-Path: <linuxppc-dev+bounces-23229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F95CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 19:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqXnY2Vghz2yQL;
	Wed, 01 Jul 2026 05:11:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782846705;
	cv=pass; b=nytWbA7RM/VgY01vA5LU/ZHoQ7HzQhK+u+qPHbYl9JQj61tMp4Ed3Ti85VEukdf1+8wLnmXoXXhq8kKxuU8WyDp6yZuLHro9RLUKMjZRuwG5ycLVACTIQXw+RY0Z2JekrvU13fDoXpRR3uGMhITn3bsrKaobCzK0y4n7epJnGZEClZBKdcbGn7e/OWuSAsCcuXD0uIVXqtqnYhyHVMt2W4DKRmnkTPvwrvGpdJzhmgBh8hRK5WIia6UpUOBMZEazr65YAIGAYRwfXuSPFaImh/dHnrKwNRNsX81n4MeBqB0NWWQfJlcYWuP/FxcR7WmWBMGxmxbumGwfwLBAAzPy4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782846705; c=relaxed/relaxed;
	bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJyPPJGn1GXUCEeoPlklUK1Gr0LdC04M9QyMWdqICEJkfEPXSDU0Yn2UoMqP3jl4DPlCbH5KX1VvS/4cQj/f2eRPMQlB2RSq717H+AF3RxT0Za0CgV8PPcckHLL2TLiKKupTbct/taLqbJJOUdbwu1lf6UqCxZW4adbcBO5GlWb7t6HWLnEYfqQsiOnrAve+fVuDdQTP2MkDJcjSqtUQaL4lNzMG4ZcrHBa7Wm/UMbcE3hdsYeFzNsOeWhbojJBbqTrwDbMa+BYGp1/8/4syephAA+gF4FSfkV9nnt/JVAuKQr2ZmKFfgjLSURBXF+KSfN33qxvQPnmv+GmJpuiRIg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L57zxT2M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L57zxT2M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqXnW15Xhz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 05:11:41 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c9254669d0cso2951873a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 12:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782846698; cv=none;
        d=google.com; s=arc-20260327;
        b=SSSGtRi9m9UG0KlylBO+UdbCUdy9gJzPlyz1EOtdKVv/ZPtJlS/fQ0QuRJoteGF9Us
         Dl8woZefh44j7ZLx9TJO1+5aOR2nvnTE2OzcU8epQcUv2LneuIHG9oNNJDyPXf8cK9po
         xMyb+IufkpqwI5cIHvuSWeldcazMb+G371gElvU4cxiivMYa/JKMu2gR1IbsTmnpHxvI
         ACqew5jWRFAjCIBV8dSW0XAPBFScW483+wd/pvufhvQ1WFy/WJbaYPkmIB56mhQKUNZP
         rrLhULUBcgcYEAliVAq3Ydc5vVunJ00NAYK+SpqkcwRQA8NYPTElkRZQh3C5//TL9TB1
         btgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
        fh=19bHijMnQcX0CwjqacHK2Nuylszw7EikCte6JGY+miY=;
        b=NvNqJ7heXNbArcOx8vuZDcM2yZYBT8i76qeHJXlD/yY2UuzQz1Lglm8R3IHY/WxtBA
         ldEPrBOxtvzwmUoSRzseG6J5RvSYjdJ0epmWQttQiuCiz19j6tXV54Ijl7Ws4nkbvEt2
         Jv13IwKkAGh8yeWCdlMQrRTIxqo/S5wtcUnFupzc5qbDDSRNOaCGaUS1ZM7I4UQPVSwj
         5GKBBf31M63Dsbync/pXnA0vNcEUoa+kk+EW9UV13SV4UPb7Qru08FzJBd9IgwgcX+Wy
         Ymab9V06fbAhFizpIwnbyiB6b/mODJTHlV4hMiaRbeWntYzrRiz0LA+V0LNNXleHLila
         687A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782846698; x=1783451498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
        b=L57zxT2MVlhPDNlLcM9xTGWuqE+zj/HqcsNZtvH+CzfWJheQlgMNiL0ISFgSF9L1X+
         mIDZwcAdUcKa4BeLsOVRwHctGDJHXpgQ2oSVdPaZBV7kiQUo4D3Yc1aIF0D+3HpAywq/
         FmEJKXaATlwFu6hLrsUO+hrjw4r1q3lNYsZ1XvB7g9/tdUt79ZRWjOMbkY8BucRjrH3C
         8+bBycE5xfy/s+i49JeHpfdpg1zIzwHzjtT7vifqI05mdHWKuXg1aG6AQe9C5rwrmymU
         +bU+McvQKSPgRNUiubOl7kqGHXMFQQVhRQWEleQsO1Aeaph358vGmhRVh+1yEFF9rTrM
         /Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846698; x=1783451498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
        b=OpLP9z+YM6UMCZRi3WMe02Xd6HHsEGLKm9gvvJdjZbei+VE6E2lQAhCcmnn/OK6KbA
         3kqoSblfG3RkRKX+a8SEPS4i9lkw76OArpEzVdxVbA8uy0eUrLF31bKVk6WHGgIes6n8
         OaBe+Z4QAI9YUbL9y2xYoEnrAfl/D3Tv3MKvReiGeWWNJZX0hXU9WoV23d5X4z27WA+3
         iONjgsmQsE6uB1jO7CIcwuHmWlGBdM38inbs4a6XWDHRuEI4JDTBsEQWHuItRCUkBCDi
         TmeNnxM0kL/gHEr+fLuEAfsInFMiIh8ehS/QS1dr5XJ+XqIeV/9qcHZkVqQZsSl1Y5mR
         d/4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9XiVIVeIlWv+vtV6sZ0NZ9D27rFnkQIX8S0VFRuAmlGsFm1ZfPnjvzb0EnNNsY5DLNMhomBV1xaB/TEIQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFn+WJl1NZnsGAoDg+WgVBRjHNXEus2+dFIoMeC5TKKkC9gPRr
	o4XMQH2GxCkMjqD01co3pKLI8VkzkAQ+X204CuxM4baBq84j/znmO6gVqLDeQuh2yosypAe7YkK
	WQdWH5uy/J7jfsp5cFY/iKMZ3cd90hj3CPIEOhfcQ
X-Gm-Gg: AfdE7ck+GNQoYj8HJEpxAnores06x7LZpm8chTXZSsYg8JLV434Q0X21GYyJ7zYBqxo
	DuKP9Ygz5JsxC68yf/QIDg3BgqfrbcXA5PJ2CAs3eApGWlwq5Vv+qb55mw6liWJJZtfrILVyH7G
	o2CIWSREh2odgpP4Dk2W+OqNPlDLXKlFa9uP93suLkLFMPwt4GaksqZiSHU27my/sqwHQ1TwraW
	N+wiLADUboLcHzglqijf/KJ5U/MLARikvl6KiEKPA2Ibk6ZLc9W0i3bXVEryAV3ph7rz+5Q
X-Received: by 2002:a05:6a21:1505:b0:3b9:545d:c006 with SMTP id
 adf61e73a8af0-3bfc50acb49mr4413477637.15.1782846698565; Tue, 30 Jun 2026
 12:11:38 -0700 (PDT)
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
MIME-Version: 1.0
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com> <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
In-Reply-To: <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 15:11:26 -0400
X-Gm-Features: AVVi8Cf1nsSKuy_9YWh2IlQC3bpng0jPtGHCEl0sgh0IF3sjPWyFNyFPXvkr2NU
Message-ID: <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	ritesh.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:42=E2=80=AFAM Madhavan Srinivasan <maddy@linux.ib=
m.com> wrote:
> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
> > On 11/03/26 12:49 am, Paul Moore wrote:
> >> On Tue, Mar 10, 2026 at 11:08=E2=80=AFAM Christophe Leroy (CS GROUP)
> >> <chleroy@kernel.org> wrote:
> >>>
> >>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>>
> >>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> >>> targets") added generic support for AUDIT but that didn't include
> >>> support for bi-arch like powerpc.
> >>>
> >>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> >>> added generic support for bi-arch.
> >>>
> >>> Convert powerpc to that bi-arch generic audit support.
> >>>
> >>> With this change generated text is similar.
> >>>
> >>> Thomas has confirmed that the previously failing filter_exclude/test
> >>> is now successful both without and with this patch, see [1]
> >>>
> >>> [1]
> >>> https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e=
6b437d0d67@linutronix.de/
> >>>
> >>> Link: https://github.com/linuxppc/issues/issues/412
> >>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> ---
> >>> Venkat, a test result with
> >>> https://github.com/linux-audit/audit-testsuite would be appreciated.
> >>
> >> Yes, I'd like to see confirmation that the audit test suite runs clean
> >> on ppc systems with this patch applied, and unfortunately without a
> >> ppc system I have no way to test this myself.
>
> My bad, this is a miss from my end.
> Venkat is already on this and will update the results here.

Do we have an update on this?  Maybe I missed it, but I don't recall
seeing any test results.

--=20
paul-moore.com

