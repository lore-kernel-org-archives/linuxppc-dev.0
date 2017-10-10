Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBCY82xp7zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 21:10:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: wei.guo.simon@gmail.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: [PATCH] selftests/powerpc: fix build error in powerpc ptrace
 selftests.
In-Reply-To: <1504232234-4161-1-git-send-email-wei.guo.simon@gmail.com>
References: <1504232234-4161-1-git-send-email-wei.guo.simon@gmail.com>
Date: Tue, 10 Oct 2017 21:10:32 +1100
Message-ID: <87lgkjwbxj.fsf@concordia.ellerman.id.au>
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

wei.guo.simon@gmail.com writes:

> From: Simon Guo <wei.guo.simon@gmail.com>
>
> GCC 7 will take "r2" in clobber list as an error will it will get followi=
ng
> build errors for powerpc ptrace selftests even with -fno-pic option:
>   ptrace-tm-vsx.c: In function =E2=80=98tm_vsx=E2=80=99:
>   ptrace-tm-vsx.c:42:2: error: PIC register clobbered by =E2=80=98r2=E2=
=80=99 in =E2=80=98asm=E2=80=99
>     asm __volatile__(
>     ^~~
>   make[1]: *** [ptrace-tm-vsx] Error 1
>   ptrace-tm-spd-vsx.c: In function =E2=80=98tm_spd_vsx=E2=80=99:
>   ptrace-tm-spd-vsx.c:55:2: error: PIC register clobbered by =E2=80=98r2=
=E2=80=99 in =E2=80=98asm=E2=80=99
>     asm __volatile__(
>     ^~~
>   make[1]: *** [ptrace-tm-spd-vsx] Error 1
>   ptrace-tm-spr.c: In function =E2=80=98tm_spr=E2=80=99:
>   ptrace-tm-spr.c:46:2: error: PIC register clobbered by =E2=80=98r2=E2=
=80=99 in =E2=80=98asm=E2=80=99
>     asm __volatile__(
>     ^~~
>
> This patch fix the build error by removing "r2" out of clobber list.

But do any of the blocks clobber r2? If so then it should be in the
clobber list.

cheers
