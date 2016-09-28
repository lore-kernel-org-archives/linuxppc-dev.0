Return-Path: <fw@deneb.enyo.de>
Received: from albireo.enyo.de (albireo.enyo.de [5.158.152.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skdZn0fmpzDrPm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 23:19:13 +1000 (AEST)
From: Florian Weimer <fw@deneb.enyo.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Florian Weimer <fweimer@redhat.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Kees Cook <keescook@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5] powerpc: Do not make the entire heap executable
References: <20160822185105.29600-1-dvlasenk@redhat.com>
 <87d1jo7qbw.fsf@concordia.ellerman.id.au>
 <20160928025544.GA24199@obsidianresearch.com>
Date: Wed, 28 Sep 2016 15:12:57 +0200
In-Reply-To: <20160928025544.GA24199@obsidianresearch.com> (Jason Gunthorpe's
 message of "Tue, 27 Sep 2016 20:55:44 -0600")
Message-ID: <87k2dwgobq.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Jason Gunthorpe:

> Eg that 32 bit powerpc currently unconditionally injects writable,
> executable pages into a user space process.
>
> This critically undermines all the W^X security work that has been
> done in the tool chain and user space by the PPC community.

Exactly, this is how we found it.  I have pretty extensive execmod
tests, and I'm going to put them into glibc eventually.  It would be
nice to cut down the number of architectures where it will fail.
(Even if you don't believe in security hardening.)
