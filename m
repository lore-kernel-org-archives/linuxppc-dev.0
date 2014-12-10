Return-Path: <ananth@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9686F1A0D67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 15:08:56 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 9 Dec 2014 21:08:54 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 80FA33E40040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:08:52 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBA49H6338535172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 21:09:17 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBA48pwO005325
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 21:08:52 -0700
Date: Wed, 10 Dec 2014 09:42:23 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/8] Fix perf probe issues on powerpc
Message-ID: <20141210041223.GB13398@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 09, 2014 at 11:03:58PM +0530, Naveen N. Rao wrote:
> This patchset fixes various issues with perf probe on powerpc
> across ABIv1 and ABIv2:
> - in the presence of DWARF debug-info,
> - in the absence of DWARF, but with the symbol table, and
> - in the absence of debug-info, but with kallsyms.
> 
> Applies cleanly on v3.18 and on -tip with minor changes to patch 6.
> Tested on ppc64 BE and LE.
> 
> - Naveen
> 
> Naveen N. Rao (8):
>   kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2
>   perf probe powerpc: Fix symbol fixup issues due to ELF type
>   perf probe: Improve detection of file/function name in the probe
>     pattern
>   perf probe powerpc: Handle powerpc dot symbols
>   perf probe powerpc: Allow matching against dot symbols
>   perf tools powerpc: Fix PPC64 ELF ABIv2 symbol decoding
>   perf probe powerpc: Use DWARF info only if necessary
>   perf probe powerpc: Fixup function entry if using kallsyms lookup
> 
>  arch/powerpc/include/asm/code-patching.h      | 26 ++++++++----
>  arch/powerpc/include/asm/kprobes.h            | 58 ++++++++++++++++++---------
>  tools/perf/arch/powerpc/Makefile              |  1 +
>  tools/perf/arch/powerpc/util/elf-sym-decode.c | 27 +++++++++++++
>  tools/perf/config/Makefile                    |  1 +
>  tools/perf/util/elf_sym.h                     | 13 ++++++
>  tools/perf/util/probe-event.c                 | 57 ++++++++++++++++++++++++--
>  tools/perf/util/symbol-elf.c                  | 11 ++++-
>  tools/perf/util/symbol.c                      |  6 +++
>  9 files changed, 170 insertions(+), 30 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/elf-sym-decode.c
>  create mode 100644 tools/perf/util/elf_sym.h

For the full patchset...

Reviewed-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
