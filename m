Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id D5A46B711C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 22:29:57 +1100 (EST)
Received: by wwb24 with SMTP id 24so96442wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 03:29:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1289707863-1768-2-git-send-email-shan.hai@windriver.com>
References: <1289707863-1768-1-git-send-email-shan.hai@windriver.com>
	<1289707863-1768-2-git-send-email-shan.hai@windriver.com>
Date: Tue, 16 Nov 2010 06:29:53 -0500
Message-ID: <AANLkTi=SDjsDgzP=oLduB_Mo6BJCwEPe0q_VZva2VB1a@mail.gmail.com>
Subject: Re: [PATCH] Fix float to unsigned conversion failure with SPE enabled
From: Josh Boyer <jwboyer@gmail.com>
To: Hai Shan <haishan.bai@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Hai Shan <shan.hai@windriver.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 13, 2010 at 11:11 PM, Hai Shan <haishan.bai@gmail.com> wrote:
> Fixed the failure on converting minus float to unsigned int with SPE enab=
led
>
> Signed-off-by: Hai Shan <shan.hai@windriver.com>

You should make sure to send PowerPC patches to linuxppc-dev.

josh

> ---
> =A0arch/powerpc/math-emu/math_efp.c | =A0 17 +++++++++++++----
> =A01 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/mat=
h_efp.c
> index 41f4ef3..338a128 100644
> --- a/arch/powerpc/math-emu/math_efp.c
> +++ b/arch/powerpc/math-emu/math_efp.c
> @@ -320,7 +320,9 @@ int do_spe_mathemu(struct pt_regs *regs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_FP_ROUND_=
ZERO(1, SB);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_S(vc.wp[1], SB, 3=
2, ((func & 0x3) !=3D 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SB_s: convert from minus=
 float to unsigned int */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_S(vc.wp[1], SB, 3=
2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((func & 0x3) !=3D 0) || SB_s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto update_regs;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> @@ -458,7 +460,11 @@ cmp_s:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_FP_ROUND_=
ZERO(2, DB);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_D(vc.wp[1], DB, 3=
2, ((func & 0x3) !=3D 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DB_s: convert from minus=
 long double to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* unsigned long long
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_D(vc.wp[1], DB, 3=
2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((func & 0x3) !=3D 0) || DB_s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto update_regs;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> @@ -589,8 +595,11 @@ cmp_d:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_FP_ROUND_=
ZERO(1, SB0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_FP_ROUND_=
ZERO(1, SB1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_S(vc.wp[0], SB0, =
32, ((func & 0x3) !=3D 0));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_S(vc.wp[1], SB1, =
32, ((func & 0x3) !=3D 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SB*_s: convert from minu=
s float to unsigned int */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_S(vc.wp[0], SB0, =
32,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((func & 0x3) !=3D 0) || SB0_s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FP_TO_INT_S(vc.wp[1], SB1, =
32,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((func & 0x3) !=3D 0) || SB1_s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto update_regs;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
