Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB8606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PCwdJ/Gz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMwyn5bGvz2xwM;
	Mon, 09 Nov 2026 01:58:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794149905;
	cv=none; b=EPWUNmpGF6zIAfNranruTueR2FsR8SmylIuMUGPhDnfdBK6A5aZExhko9j155Uvnoqmkub96eOlp/CIBhhrE4Q2Ht/y61Xq9tjcvxOevp8l2k2O4xAdawoBPHI6vSj5NFVdP6JR/S6Om7FJqv1SwpX53a7dTWAk16YjwxSQwKmUD+hJqDdunq+De8SCcXBZx8QunAi7ZtBVun8PLiCQO4vSmwPmRR85ySK33ULp6i4zCr3SyCMbjI+OGgBtt+8Krg6qA/6l+DjgdsUvt2QRP1dwVoKfh0Ujsg4chvsn2xvAiOU2wKVS3k94jD0pvoI1OI0W6PddJTIr5CpCIKeYmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794149905; c=relaxed/relaxed;
	bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EGrGH0EOQy5DU2EikTLdF4y08PbpFjpKFdjec7wRR06ctov3OhXBS3mK7eSDeqjh37eWtYkC1tPmHs2DU90boU6IRZL/G5jQS2vZqIL+vdx/f0BkSo3EKJtybFks0sYAForQ2rUToWIcZbpS2MAI9c4gxIr54G+oDyMlwAEXexaNxvl5PSd+xOIY1ZtGHRlAIcQHPA8ibXIyLsCrwyCWpxfylox3Lu21C8T227V9B2RMlpLFsC/yDbCGYdV3udFmJQIAue9qP79CIMhhbvhumByvFNl1N0Q0jwCDvdA0mi3z0+FzOIOf5c8QMAH7iyAvflq5q+ZAKUri0MECJwwNWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; dkim=pass (2048-bit key; secure) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PCwdJ/Gz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com; envelope-from=pasha.tatashin@soleen.com; receiver=lists.ozlabs.org) smtp.mailfrom=soleen.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PCwdJ/Gz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=soleen.com (client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com; envelope-from=pasha.tatashin@soleen.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMwyj22WKz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 01:58:20 +1100 (AEDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso27559137.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 06:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794149897; x=1794754697; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
        b=PCwdJ/GzE/DLxPyYpyXB+/M2CDemmnHwmSguG3hpu0cEJHDw8W/L0JvvR3Dv4I9Tbi
         pCZw27ow+pGbCISEmbsX5A2yDpAG5DXARnVRx5UkIF5PUQTKpTPuEogH/1AiAxcuwcog
         /Hemp28zKmlm7+I+ExxHLp0E4a7vSx8H7EgTj+jLkuSCmfLXbqhrePpx9YvWCC3S98gL
         /q6qlJS6ItyeF9ox/MfVpJnd+2BK0EsT6ohT0QiK9XrANryuBx1aDQd6ZS+KstqwTvY8
         8Tt9ldMSBeidwQ/esV67i/nVq9FA8KEaYOd0+hu85nqaH2BywAgh4LggkKqkd+2VU6wZ
         J4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149897; x=1794754697;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
        b=XQ6aHCO0nguNxl0IxYrG2CPTteqr6GyrYYEheg6m3/YacgrpIEegYlXkEDh+mzRBCc
         1In1I3KtG+b/9NfsDiHaAfTAuFMPpgUzcrtckjrj4zXtHMieDtGhS/9JGdFvR5dXsupn
         F+Bl4BGc/FXZISUToV2LJ5KoSY1XbV3y/PnoO5KVcO3pGyAautTcYEQ7z6I0BrOxYA7M
         U++mX923Ga0xYvK65tdoax4HR+xL8zEXZRJs9jXO8q4Bs4Xr64bgiYz8u3crTtVzPhlh
         0/HOUz370Tfa3AqLBA7ikmvb3ueM+9yxG0zkgJVSEkbE5ycawgbOS5vxBVcg59+qIEPH
         gUoA==
X-Forwarded-Encrypted: i=1; AL+hErHybGQLbptFpKNYUN2sXA00eXMgkeQzn6TQRuygbdQUjofKRbt8VhnLUQJgpO9we/ZZKOwLRJMzEKxS/VQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Tdn85Cq8FNV6tXiWtF2CPIXg0iGXzMt7NrXNZrM/8ihHkEroz
	JMTFZ371KsSF/UqzaZvQ3YknkDb12TZZZIcDO+AzOc6AGxFWRXudrCDbw6ECSKoDr7s=
X-Gm-Gg: AYBFou1JeqVLo+2Wsfbn/HBzbEBR7nWL4NvBmD+WKnHTiQegUGikT6lnxARZJuzR1/1
	AL+0Fd2W2lDg0P7fwBFhpyXYMN0hML+OK5X/VMuUzNf+8saLfnC3BJo/UaL0dhljyU6rD6fPYF7
	ZHw+49at0UlmX+dp0nhZPHQm+te5Rq9J7znvooJ+xDTWCg7GcfsD6Gfy3drurleNpgbaRhACBbu
	Kdmhqb2xhArpsVOGh46zeVYsuRd6bgEToxdyiEfSlOzJWJdbJv8dIJmAycSEU/Dwe6xPuYoSPvl
	01zneVoJnXsSUzBrxbKI4sQWqeb4wgzS/cUGOYOIWQDjcPibDnlHa6l15crJvjR2xgQhdMqBwVG
	s8xNXvAExxmA72ykMtnYgstGRZmJSGC5luTgBXFxoQs00O3elAkNsfMNl9luCbyT828VJb8i+hF
	cn4SEpHQmABiQs4LO1rLZ3IqqCbjpu8bKWUVMm40OZMWvasR7bwDcQUiEtzWZbHe/4ZdqBdO3Lw
	jbV0cCGFt1drFZdQf3EKlTvTl2C7YiX+qYmchGCOH7Y4ABGsfUKXkyJcNQzKFelD3sAOimAyyoh
	tekq8gjkdGgFh80vKFdpjHr0sfQ2OZuvKtEjZxsNsNwGw2g7eLdyRpYiDXrzCDwnYRSYIj5jfpA
	k0tvoGiOfyYg4riDx9YarrgMwrE+Hf7Q=
X-Received: by 2002:a05:6102:511e:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d2db193714mr282127137.21.1794149897376;
        Sun, 08 Nov 2026 06:58:17 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a108d6sm1838855241.7.2026.11.08.06.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 06:58:16 -0800 (PST)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 09:58:14 -0500
Message-Id: <DMPX235ZQEHC.379KOADR3QVFU@soleen.com>
Cc: "Alexander Graf" <graf@amazon.com>, "Alex Williamson"
 <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Mahesh J
 Salgaonkar" <mahesh@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>,
 "Oliver O'Halloran" <oohall@gmail.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [PATCH v2 00/17] PCI: Index saved capability state by
 configuration space offset
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "David Matlack" <dmatlack@google.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261106004218.604799-1-dmatlack@google.com>
 <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
In-Reply-To: <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 5, 2026 at 7:46 PM EST, David Matlack wrote:
> On Thu, Nov 5, 2026 at 4:42=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
>> Merge Plan
>> ----------
>>
>> This series applies on top of v10 of the PCI core support for Live
>> Update series [2], which is targeting Linux 7.5. This series is
>> targeting Linux 7.5 as well.
>>
>> Both series will be merged through liveupdate.git, matching the
>> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.
>
> Apologies, an update I made here got lost. The PCI core support for
> Live Update is targeting 7.5, via liveupdate.git. _This_ series should
> probably target 7.6. I doubt we can get reviews in time for 7.5. And
> as for which tree, I am not sure. This series is mostly PCI core
> changes, so I lean towards merging through the PCI tree. Only the last
> commit touches drivers/pci/liveupdate.c.

I looked through this series. Even though it is motivated by Live=20
Update, it is primarily a refactoring of how the PCI core saves and=20
restores capability state (to make struct pci_saved_state compatible=20
with Live Update), so it should go through the PCI tree rather than=20
liveupdate.git. Only two patches (12 and 17) touch=20
drivers/pci/liveupdate.c, and we can Ack those.

Let's get the current v10 PCI core LU series landed in first; after=20
that, this series can apply against 7.X-rc1 so the PCI tree can cleanly=20
pick it up.

--=20
Pasha


