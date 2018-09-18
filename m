Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DsL91bzpzDqCh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:41:21 +1000 (AEST)
Message-ID: <10da0fdc641b05ea288890a23aa01ad33f2d6987.camel@neuling.org>
Subject: Re: [RFC PATCH 09/11] powerpc/tm: Do not restore default DSCR
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
Date: Tue, 18 Sep 2018 15:41:20 +1000
In-Reply-To: <1536781219-13938-10-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-10-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> In the previous TM code, trecheckpoint was being executed in the middle o=
f
> an exception, thus, DSCR was being restored to default kernel DSCR value
> after trecheckpoint was done.
>=20
> With this current patchset, trecheckpoint is executed just before getting
> to userspace, at ret_from_except_lite, for example. Thus, we do not need =
to
> set default kernel DSCR value anymore, as we are leaving kernel space.  I=
t
> is OK to keep the checkpointed DSCR value into the live SPR, mainly becau=
se
> the transaction is doomed and it will fail soon (after RFID),=20

What if we are going back to a suspended transaction?  It will remain live =
until
userspace does a tresume

> so,
> continuing with the pre-checkpointed DSCR value is what seems correct.

Reading this description suggests this patch isn't really needed. Right?

Mikey

> That said, we must set the DSCR value that will be used in userspace now.
> Current trecheckpoint() function sets it to the pre-checkpointed value
> prior to lines being changed in this patch, so, removing these lines woul=
d
> keep the pre-checkpointed values.
>=20
> Important to say that we do not need to do the same thing with tm_reclaim=
,
> since it already set the DSCR to the default value, after TRECLAIM is
> called, in the following lines:
>=20
>         /* Load CPU's default DSCR */
>         ld      r0, PACA_DSCR_DEFAULT(r13)
>         mtspr   SPRN_DSCR, r0
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/tm.S | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index 6bffbc5affe7..5427eda69846 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -493,10 +493,6 @@ restore_gprs:
>  	mtlr	r0
>  	ld	r2, STK_GOT(r1)
> =20
> -	/* Load CPU's default DSCR */
> -	ld	r0, PACA_DSCR_DEFAULT(r13)
> -	mtspr	SPRN_DSCR, r0
> -
>  	blr
> =20
>  	/* ****************************************************************** *=
/
