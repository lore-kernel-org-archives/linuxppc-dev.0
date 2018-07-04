Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41LSnT22lvzF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:35:39 +1000 (AEST)
Date: Wed, 4 Jul 2018 18:36:15 +0100
From: Will Deacon <will.deacon@arm.com>
To: Laura Abbott <labbott@redhat.com>
Cc: mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
 Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 4/4] arm64: Add build salt to the vDSO
Message-ID: <20180704173615.GC9668@arm.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180703233430.14416-5-labbott@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 03, 2018 at 04:34:30PM -0700, Laura Abbott wrote:
> 
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I was previously focused on x86 only but since powerpc gave a patch,
> I figured I would do arm64 since the changes were also fairly simple.
> ---
>  arch/arm64/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)

If you drop the trailing semicolon, then:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
> index b82c85e5d972..2c429dfd3f45 100644
> --- a/arch/arm64/kernel/vdso/note.S
> +++ b/arch/arm64/kernel/vdso/note.S
> @@ -22,7 +22,10 @@
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> +#include <linux/build-salt.h>
>  
>  ELFNOTE_START(Linux, 0, "a")
>  	.long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT;
> -- 
> 2.17.1
> 
