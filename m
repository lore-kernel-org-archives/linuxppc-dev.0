Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD8242C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 02:54:35 +1000 (EST)
Date: Thu, 16 May 2013 11:54:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 v2] powerpc: restore dbcr0 on user space exit
To: Bharat Bhushan <r65777@freescale.com>
In-Reply-To: <1368682472-4268-3-git-send-email-Bharat.Bhushan@freescale.com>
 (from r65777@freescale.com on Thu May 16 00:34:32 2013)
Message-ID: <1368723257.8202.43@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, stuart.yoder@freescale.com,
 James.Yang@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2013 12:34:32 AM, Bharat Bhushan wrote:
> On BookE (Branch taken + Single Step) is as same as Branch Taken
> on BookS and in Linux we simulate BookS behavior for BookE as well.
> When doing so, in Branch taken handling we want to set DBCR0_IC but
> we update the current->thread->dbcr0 and not DBCR0.
>=20
> Now on 64bit the current->thread.dbcr0 (and other debug registers)
> is synchronized ONLY on context switch flow. But after handling
> Branch taken in debug exception if we return back to user space
> without context switch then single stepping change (DBCR0_ICMP)
> does not get written in h/w DBCR0 and Instruction Complete exception
> does not happen.
>=20
> This fixes using ptrace reliably on BookE-PowerPC
>=20
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v1->v2
>  - Subject line was not having 2/2
>=20
>  arch/powerpc/kernel/asm-offsets.c |    1 +
>  arch/powerpc/kernel/entry_64.S    |   24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/asm-offsets.c =20
> b/arch/powerpc/kernel/asm-offsets.c
> index b51a97c..1e2f450 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -103,6 +103,7 @@ int main(void)
>  #endif /* CONFIG_VSX */
>  #ifdef CONFIG_PPC64
>  	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
> +	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
>  #else /* CONFIG_PPC64 */
>  	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
>  #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> diff --git a/arch/powerpc/kernel/entry_64.S =20
> b/arch/powerpc/kernel/entry_64.S
> index 794889b..561630d 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -614,7 +614,9 @@ _GLOBAL(ret_from_except_lite)
>  	 * from the interrupt.
>  	 */
>  #ifdef CONFIG_PPC_BOOK3E
> +	ld	r3,PACACURRENT(r13)
>  	wrteei	0
> +	lwz	r10,(THREAD+THREAD_DBCR0)(r3)

I know I asked you to move these earlier, but this is probably too =20
early... wrteei has synchronization, so it will probably have to wait =20
until the ld completes, defeating the purpose of moving it earlier.

Ideal would probably be to load PACACURRENT immediately after _MSR(r1), =20
and load DBCR0 just after "beq resume_kernel".

Or, move DBCR0 to therad_info as I suggested internally.

Regardless of what you do, could you run a basic syscall benchmark =20
(e.g. from lmbench) before and after the patch?

-Scott=
