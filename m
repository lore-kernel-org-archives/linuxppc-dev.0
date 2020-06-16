Return-Path: <SRS0=a/z+=75=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951C0C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 19:55:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD33206D8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 19:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="auHBa5AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD33206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mf7p3YcgzDqyg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 05:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=zx2c4.com (client-ip=192.95.5.64; helo=mail.zx2c4.com;
 envelope-from=jason@zx2c4.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha1
 header.s=mail header.b=auHBa5AE; dkim-atps=neutral
X-Greylist: delayed 398 seconds by postgrey-1.36 at bilbo;
 Wed, 17 Jun 2020 05:53:44 AEST
Received: from mail.zx2c4.com (mail.zx2c4.com [192.95.5.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mf5h3lYWzDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2020 05:53:44 +1000 (AEST)
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fc2a523d
 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 16 Jun 2020 19:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type; s=mail; bh=7vGnD2Fc5hFa6zE6l8I/6fYFWTE=; b=auHBa5
 AEe5pm5r80dgWM49RbxNg2b1wePIyReSMQ0Rz/3L8Yx5mFtqdklxmmgnU69XYlJN
 hUBaHFgVJALywQiz6/SIkttoZgX1tGyz+Zg+VQcgVldFachBs52tuPslyyMFQ0LX
 thiKjEu3HP7G7pjaS6Q85sWuiJrjwSZZouMci0xDSFLn39VuLeRw1x/kWL7uYtnC
 q9lJ9u4WEJkyqJPlHNMFgYZ8GQhbEM4aqhZNPWgxeSvHzabhX4d1A2W++bIgoNgb
 5POprpu6DVgEzddWZ80fiiLd2tnSpz4DTk3KcXvzj6IQwWQeVy1VhdN6Y6LpuXnz
 67qrTsLtz03/PXLw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 05793598
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 16 Jun 2020 19:28:59 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id t9so2940282ioj.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 12:46:58 -0700 (PDT)
X-Gm-Message-State: AOAM530gwDyThjEHCtoQzKFp7dbfHoDfld4wWj2UwccH/4z2ylwgSRso
 bAqTuNL0wZn6KPMHY+gQj7qLBQtnV0zhhRNdphw=
X-Google-Smtp-Source: ABdhPJxC2pRunaModJX8LCWHauaz4Ko5hXWZ58PHme1+4UYNCmQGIC+iarFUNAqn+rNJyw3DywT6LsxlwSFMRJ3z3pU=
X-Received: by 2002:a6b:6705:: with SMTP id b5mr4346341ioc.29.1592336817452;
 Tue, 16 Jun 2020 12:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200616015718.7812-1-longman@redhat.com>
 <fe3b9a437be4aeab3bac68f04193cb6daaa5bee4.camel@perches.com>
In-Reply-To: <fe3b9a437be4aeab3bac68f04193cb6daaa5bee4.camel@perches.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 16 Jun 2020 13:46:46 -0600
X-Gmail-Original-Message-ID: <CAHmME9rCD1KJNguthAhZ+OAVZTpBwEvGRLRV0tvQjBaEYG1bHQ@mail.gmail.com>
Message-ID: <CAHmME9rCD1KJNguthAhZ+OAVZTpBwEvGRLRV0tvQjBaEYG1bHQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm, treewide: Rename kzfree() to kfree_sensitive()
To: Joe Perches <joe@perches.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-btrfs@vger.kernel.org,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 David Sterba <dsterba@suse.cz>, David Howells <dhowells@redhat.com>,
 Linux-MM <linux-mm@kvack.org>, linux-sctp@vger.kernel.org,
 keyrings@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org,
 linux-cifs@vger.kernel.org, linux-scsi@vger.kernel.org,
 James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>,
 linux-wpan@vger.kernel.org, David Rientjes <rientjes@google.com>,
 Waiman Long <longman@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Steffen Klassert <steffen.klassert@secunet.com>, linux-pm@vger.kernel.org,
 ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
 linux-nfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 linux-bluetooth@vger.kernel.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Netdev <netdev@vger.kernel.org>,
 WireGuard mailing list <wireguard@lists.zx2c4.com>, linux-ppp@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 16, 2020 at 12:54 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-06-15 at 21:57 -0400, Waiman Long wrote:
> >  v4:
> >   - Break out the memzero_explicit() change as suggested by Dan Carpenter
> >     so that it can be backported to stable.
> >   - Drop the "crypto: Remove unnecessary memzero_explicit()" patch for
> >     now as there can be a bit more discussion on what is best. It will be
> >     introduced as a separate patch later on after this one is merged.
>
> To this larger audience and last week without reply:
> https://lore.kernel.org/lkml/573b3fbd5927c643920e1364230c296b23e7584d.camel@perches.com/
>
> Are there _any_ fastpath uses of kfree or vfree?

The networking stack has various places where there will be a quick
kmalloc followed by a kfree for an incoming or outgoing packet. One
place that comes to mind would be esp_alloc_tmp, which does a quick
allocation of some temporary kmalloc memory, processes some packet
things inside of that, and then frees it, sometimes in the same
function, and sometimes later in an async callback. I don't know how
"fastpath" you consider this, but usually packet processing is
something people want to do with minimal overhead, considering how
fast NICs are these days.
