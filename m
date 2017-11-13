Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb7955Z7szDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 22:05:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michal Suchanek <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootwrapper: mspsc.c: fix pointer-to-int-cast warnings
In-Reply-To: <20171005112854.28115-1-msuchanek@suse.de>
References: <20171005112854.28115-1-msuchanek@suse.de>
Date: Mon, 13 Nov 2017 22:05:44 +1100
Message-ID: <87o9o6wi9j.fsf@concordia.ellerman.id.au>
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

Hi Michal,

Thanks for trying to fix this.

Michal Suchanek <msuchanek@suse.de> writes:
> I get these warnings:
>
> ../arch/powerpc/boot/mpsc.c: In function 'mpsc_get_virtreg_of_phandle':
> ../arch/powerpc/boot/mpsc.c:113:35: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>
> ../arch/powerpc/boot/mpsc.c: In function 'mpsc_console_init':
> ../arch/powerpc/boot/mpsc.c:147:12: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>
> Presumably the patch below fixes these, and presumably the DT defines
> that pointes and integers have the same size in the DT so this is fine

Actually no it doesn't. A device tree doesn't contain pointers, and it
doesn't say anything about the size of a pointer on a platform that uses
that device tree.

phandles are not pointers, they are handles, and they are always 32-bit.
So this code is just wrong on 64-bit, you can't safely cast from a
64-bit pointer to a phandle.

But I think this warning has actually been fixed differently by commit:

  866bfc75f40e ("powerpc: conditionally compile platform-specific serial drivers")

If you're still seeing the warning let me know.

cheers
