Return-Path: <slightlyunconventional@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 445C4DE207
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 06:51:44 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so297239ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:51:43 -0800 (PST)
Message-ID: <fb412d760901141151g63d9e888o9437afe6f8e1313a@mail.gmail.com>
Date: Wed, 14 Jan 2009 13:51:42 -0600
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: Unify opcode definitions and support
In-Reply-To: <1231884862-10693-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1231884862-10693-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 4:14 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> Create a new header that becomes a single location for defining PowerPC
> opcodes used by code that is either generationg instructions
> at runtime (fixups, debug, etc.), emulating instructions, or just
> compiling instructions old assemblers don't know about.
>
> We currently don't handle the floating point emulation or alignment decode
> as both are better handled by the specific decode support they already
> have.
>
> Added support for the new dcbzl, dcbal, msgsnd, tlbilx, & wait instructions
> since older assemblers don't know about them.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Added PPC_ prefixes to everything to ensure namespace
> * removed defines from traps.c
>
>  arch/powerpc/include/asm/code-patching.h |    4 +-
>  arch/powerpc/include/asm/ppc-opcode.h    |   68 ++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/ppc_asm.h       |    6 +--
>  arch/powerpc/kernel/crash_dump.c         |    2 +-
>  arch/powerpc/kernel/entry_32.S           |    8 ++--
>  arch/powerpc/kernel/ftrace.c             |    8 ++--
>  arch/powerpc/kernel/head_booke.h         |    2 +-
>  arch/powerpc/kernel/module_64.c          |    2 +-
>  arch/powerpc/kernel/traps.c              |   58 ++++++++-----------------
>  arch/powerpc/lib/feature-fixups.c        |    4 +-
>  10 files changed, 101 insertions(+), 61 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/ppc-opcode.h

Shouldn't arch/powerpc/include/asm/disassemble.h be integrated with this?

-Hollis
