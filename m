Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5SzB2lwpzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 23:56:54 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so20200794pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 06:56:54 -0700 (PDT)
Date: Fri, 5 Aug 2016 23:56:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas
 Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Message-ID: <20160805235644.366a68ec@roar.ozlabs.ibm.com>
In-Reply-To: <1470399123-8455-4-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-4-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  5 Aug 2016 22:12:01 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Add an option for architectures to pass over modules after they are
> linked. powerpc will use this to fix up alternate instruction patch
> relocations.

For that matter, now I think about it, I'd like to have this generic
postmod pass for the vmlinux as well. And it would be  to call into
the arch Makefile rather than just supply a tool.

Currently powerpc deals with it by adding dependencies on its zImage
target, but it would be really nice to be able to fix that while we're
here too. Is that going to work?

Thanks,
Nick
