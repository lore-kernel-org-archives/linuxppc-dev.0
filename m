Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C449607F2B1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gNcvq8MK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKc6Q0N4Dz2y89;
	Thu, 05 Nov 2026 07:11:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793823117;
	cv=none; b=Dk3fGebOLgVW9p0uVQauT7rxWieKWHDMSTC0q9AvRp/N7PvFUioFOFThZYRglc1hKHELKt+2AY1dfsRUsnkNubJSeGfDP5hwtA7vXUV3uup5KszzGsSiodD+mBKNCEA5vJNIy38Jsi1fu42rk4TsD8/Q4pj80cXakCrqNToKKTGxszXnfb78ALYTeAgWFaOQfDZTsW6czpqjAq6cfecCmeC9hWQoNRd+0csw9dq4yUB360FEKggIMyaEy9lNDKu32wr+Y85CtA8YrqevJTBW4AN7QnZn8OM8tf1Vhrmhtx4CL1fyrvZ6vi9IQj5dUF465Q5PSaeErPPjczRtYyOLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793823117; c=relaxed/relaxed;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djc8mqMZCHiWlmVQFIiPixFeJWXOeKG3ZGa+w+kuzVGUq+ttVp0Q4fEmU9ovVQKJJxIwclpb9WMe7E4U5pyxD5v9SWgkkJ83eyjvnJk4t2wQgU9fNC1q4Ve+O8o6kVUeVl7G6Z+OVHCReEuU1rOko3P0Jvj6V375gLeSlCFykh+T3f/ysjVfxOVuzsNPwSSC4YdJ/8Ok8tMwEJ00PiAfByLJoQC+fQikB/EU9nVjn6iXKvAqmSO7vYC4iqtQ3yK/3o6smDyOnowUjTCUGOjbQs2O50qKVFsaxCyV7wPQvd8zgy7UDTo0nE2xSRIy4euOBrAr2JuFaXRkjxdb+XTiwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gNcvq8MK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gNcvq8MK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKc6N34rsz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 07:11:55 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c4550d8ab15so176882166b.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823110; x=1794427910; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=gNcvq8MK1xAcXxBpWHiMBjWToIPRPI1qsI4K6wR0e7MLskkWf0kxKJR+FETJZKDYDa
         qMR3HhjBAYvb7z3U3RmfNJZxQd15pXsH2eHqw9dYcSjyddOAMl/DdUjxkpQMzBsjvFFh
         kp6ynfTL8dT4awG7a9jOFiLvhZs2brAPBWof0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823110; x=1794427910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=QOrOCY2gSQaamoXXX+minOMztA+7VW3lvtXGGSR41ZOmgZ81qOi+++mWEpiAEsrShp
         s1XD6MB1x3j1CNL/iCg3ZzPU4ZBFrfb0BwOSjrzp1uWBTVY6pMjsZuOeJPFb5+9XsrR1
         hXD1oGJvRsMEfWtdVtf+e/uKX1FDwar8JFGhy63qBxIVLnTVixQ/5dofxW7syhSOBQ4n
         l7WLcCvUitlNkSkKnAke2NhdO2AC+SLwxDwcm0TJ+PD1+FZ1QUOATTlxfWJysWl+1+c9
         7M4/R1wuA4HdxCwDshQYUKT2+p30Aqp1UvqnwjnYf4sWA3W36QlVILxt70CLAG+Y1QRj
         6J9Q==
X-Forwarded-Encrypted: i=1; AKwUvByUcKT+op5rip4Wn3dojUn61nmKvsJUWv796uBPHqmLe3ITgdWPRsed3HnUhW76o3OSnfw3oVfB3esJIqk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/hwMymC39Yq9aeqUeXw8YhlzisXRGcBb7NGrSnqcA9lrMQe7Cy
	y0zCbUC1Hi4byWOhKa46U+4C3PdloAy1P0tgFelvx0etDQsvbHv/rbgls99Y5OWZjQgSECpKM4S
	kvxxeBoRgcQ==
X-Gm-Gg: AYBFou37NDZhia/pSkfiXHUEV1cTw2radl8PTpXrjima1duc/lbO7yK1YzPWV4dWKX3
	Uv7+urtSwjr7Op7giwyGkPVVa3odBMOZWqMxD3J0qMvcxbiQXFMbgBeQmMB/06/1YpIcFwHLuoy
	MXiRxT84tPthovL1UGtpfcJscNAJJDthbo6x3XqqQcaZhTCRrnzq+yFMKikRJqWsoqUlTg+nmm6
	2vnBCy70tVlc7lOxiprzC957WJbR9WOXATIhznsEJNL7GGXkkNeKfVrQJSSZnPh44Wnptsugz6l
	xfoVlgiDrYvd/Fmf58Ovabwe/xf/DuQoR2T8z3AMs5Z7YnMyYFd8V+9ZhxA2P5YugD3Z29MbbkT
	LTcY9F1CMuxuwz4NscdsjAzvmzqGHjybM1i/3DGDHFxAk4SwiszjcjMd6P6vK+PDvOxdOaRBnj2
	KzTpc4TmILriVuFG+lCCWoD+CCM9gA2595tVr4lSGtFI5eHdl3ZDqWfCgSqnTRTcArTBUy00QOW
	nMdgIthXtcIHvIIltduILH9sEnOz8GIyugXtr5l4Vy8V96dEXmPOQHnej9k082F38nxJ4DMB4sk
	HK3YoMHZOmQECek8PlU3Ej8q8Qy8S68znrWVaBL+QKldaT/CbDxJh5fPwsBa6RwtrQ5dF+3Qavv
	wfQ==
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id a640c23a62f3a-c4ca795fa50mr1975131566b.3.1793823110245;
        Wed, 04 Nov 2026 12:11:50 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0ddcfa78sm106348566b.0.2026.11.04.12.11.50
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:11:50 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c445c95d553so164877966b.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 12:11:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw0UBM7hwKJ2lVnpLkl9bu9ZM1iZ9lzBQ8WZ3eMEzCDawKpyEYWOJECKuwSPh7JYqpRGBF1wYiYn6Hi/yc=@lists.ozlabs.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
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
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus

