Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7DC0650E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:17:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C00204EC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C00204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hnc86BXjzDqQy
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 11:17:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hnZN1TmVzDqPk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2019 11:15:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45hnZJ0R8Jz9sN4;
 Mon,  8 Jul 2019 11:15:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>,
 Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 10/10] selftests: add openat2(2) selftests
In-Reply-To: <20190706145737.5299-11-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-11-cyphar@cyphar.com>
Date: Mon, 08 Jul 2019 11:15:35 +1000
Message-ID: <878st9iax4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Tycho Andersen <tycho@tycho.ws>, Aleksa Sarai <asarai@suse.de>,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, linuxppc-dev@lists.ozlabs.org,
 Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>,
 David Drysdale <drysdale@google.com>, Christian Brauner <christian@brauner.io>,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-api@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 containers@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Aleksa,

A few minor comments below.

Aleksa Sarai <cyphar@cyphar.com> writes:
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> new file mode 100644
> index 000000000000..8235a49928f6
> --- /dev/null
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -Wall -O2 -g
> +TEST_GEN_PROGS := linkmode_test resolve_test rename_attack_test
> +
> +include ../lib.mk
> +
> +$(OUTPUT)/linkmode_test: linkmode_test.c helpers.o
> +$(OUTPUT)/rename_attack_test: rename_attack_test.c helpers.o
> +$(OUTPUT)/resolve_test: resolve_test.c helpers.o

You don't need to tell make that foo depends on foo.c.

Also if you make the dependency be on helpers.c then you won't get an
intermediate helpers.o, and then you don't need to clean it.

So the above three lines could just be:

$(TEST_GEN_PROGS): helpers.c

> +EXTRA_CLEAN = helpers.o $(wildcard /tmp/ksft-openat2-*)

If you follow my advice above you don't need helpers.o in there.

Deleting things from /tmp is also a bit fishy on shared machines, ie. it
will error if those files happen to be owned by another user.

cheers
