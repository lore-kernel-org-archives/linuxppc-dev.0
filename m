Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYszL65wTzDsW3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 17:06:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>
Subject: Re: [PATCH v14 00/15] selftests/powerpc: Add ptrace tests for ppc
 registers
In-Reply-To: <1473826155.2554.6.camel@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473745750.15800.1.camel@gmail.com>
 <20160912170105.GA17588@simonLocalRHEL7.x64>
 <1473826155.2554.6.camel@gmail.com>
Date: Wed, 14 Sep 2016 17:06:35 +1000
Message-ID: <87poo7neo4.fsf@concordia.ellerman.id.au>
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

Cyril Bur <cyrilbur@gmail.com> writes:
> Its messy but I think the accepted solution for kselftests is to do:
>
> #include "../../../../../usr/include/linux/elf.h"
>
> which I believe will get the headers generated for the target by `make
> headers_install` and therefore should match that for which the
> kselftests are being compiled.

Don't put the path in the include line though, add it to CFLAGS.

See eg. tools/testing/selftests/powerpc/tm/Makefile:

tm-syscall: CFLAGS += -I../../../../../usr/include


cheers
