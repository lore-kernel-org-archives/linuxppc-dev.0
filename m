Return-Path: <SRS0=Jq0w=TK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2868C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 10:22:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D57420850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 10:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D57420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450mVR6HvVzDqTY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 20:22:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450mSx2vK1zDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 20:21:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 450mSt2tmqz9sD4;
 Fri, 10 May 2019 20:21:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>, 'Michal =?utf-8?Q?Such=C3=A1ne?=
 =?utf-8?Q?k'?= <msuchanek@suse.de>, Petr Mladek <pmladek@suse.com>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
In-Reply-To: <8ad8bb83b7034f7e92df12040fb8c2c2@AcuMS.aculab.com>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190509153829.06319d0c@kitsune.suse.cz>
 <8ad8bb83b7034f7e92df12040fb8c2c2@AcuMS.aculab.com>
Date: Fri, 10 May 2019 20:21:02 +1000
Message-ID: <87ef56vcdt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.cz>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Stephen Rothwell <sfr@ozlabs.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

David Laight <David.Laight@ACULAB.COM> writes:
> From: Michal Such=C3=A1nek
>> Sent: 09 May 2019 14:38
> ...
>> > The problem is the combination of some new code called via printk(),
>> > check_pointer() which calls probe_kernel_read(). That then calls
>> > allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too ear=
ly
>> > (before we've patched features).
>>=20
>> There is early_mmu_has_feature for this case. mmu_has_feature does not
>> work before patching so parts of kernel that can run before patching
>> must use the early_ variant which actually runs code reading the
>> feature bitmap to determine the answer.
>
> Does the early_ variant get patched so the it is reasonably
> efficient after the 'patching' is done?

No they don't get patched ever. The name is a bit misleading I guess.

> Or should there be a third version which gets patched across?

For a case like this it's entirely safe to just skip the code early in
boot, so if it was a static_key_false everything would just work.

Unfortunately the way the code is currently written we would have to
change all MMU features to static_key_false and that risks breaking
something else.

We have a long standing TODO to rework all our feature logic and unify
CPU/MMU/firmware/etc. features. Possibly as part of that we can come up
with a scheme where the default value is per-feature bit.

Having said all that, in this case the overhead of the test and branch
is small compared to the cost of writing to the SPR which controls user
access and then doing an isync, so it's all somewhat premature
optimisation.

cheers
