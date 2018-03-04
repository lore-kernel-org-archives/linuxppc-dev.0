Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvKff1LKPzF0Ph
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 21:54:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 15/21] powerpc: Add missing prototype for MMU_setup
In-Reply-To: <20180225172236.29650-16-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-16-malat@debian.org>
Date: Sun, 04 Mar 2018 21:54:16 +1100
Message-ID: <87o9k4glgn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:
> Add a function declaration for MMU_setup at the beginning of the file to
> fix a warning (treated as error in W=3D1):
>
>   CC      kernel/sys.o
> arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for =E2=80=
=98MMU_setup=E2=80=99 [-Werror=3Dmissing-prototypes]
>  void __init MMU_setup(void)
>              ^~~~~~~~~
> cc1: all warnings being treated as errors

Can't it be static instead?

  $ git grep -n MMU_setup
  arch/powerpc/mm/init_32.c:102:void __init MMU_setup(void)
  arch/powerpc/mm/init_32.c:135:  MMU_setup();

cheers
