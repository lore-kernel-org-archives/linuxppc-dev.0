Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 866BEDE0F6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 06:10:57 +1000 (EST)
Received: by gxk20 with SMTP id 20so46400gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 13:10:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242761199-17875-3-git-send-email-timur@freescale.com>
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
	<1242761199-17875-3-git-send-email-timur@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 14:10:05 -0600
Message-ID: <fa686aa40905191310h3ed0efdfn4bd4b4f4b9ca0b7d@mail.gmail.com>
Subject: Re: [PATCH 2/2] qe: add polling timeout to qe_issue_cmd()
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 1:26 PM, Timur Tabi <timur@freescale.com> wrote:
> The qe_issue_cmd() function (Freescale PowerPC QUICC Engine library) poll=
s on
> a register until a status bit changes, but does not include a timeout to
> handle the situation if the bit never changes. =A0Change the code to use =
the new
> spin_event_timeout() macro, which simplifies polling on a register withou=
t
> a timeout.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch depends on my previous patch, "powerpc: introduce macro
> spin_event_timeout()".
>
> =A0arch/powerpc/sysdev/qe_lib/qe.c | =A0 =A09 ++++++---
> =A01 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib=
/qe.c
> index 01bce37..810e1df 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -111,6 +111,7 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol=
, u32 cmd_input)
> =A0{
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0u8 mcn_shift =3D 0, dev_shift =3D 0;
> + =A0 =A0 =A0 int ret;
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&qe_lock, flags);
> =A0 =A0 =A0 =A0if (cmd =3D=3D QE_RESET) {
> @@ -138,11 +139,13 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protoc=
ol, u32 cmd_input)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* wait for the QE_CR_FLG to clear */
> - =A0 =A0 =A0 while(in_be32(&qe_immr->cp.cecr) & QE_CR_FLG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG)=
 =3D=3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0100, 0, ret);
> + =A0 =A0 =A0 /* On timeout (e.g. failure), the expression will be false =
(ret =3D=3D 0),
> + =A0 =A0 =A0 =A0 =A0otherwise it will be true (ret =3D=3D 1). */
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&qe_lock, flags);
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return ret =3D=3D 1;

Hmmm, the ret value is backwards from what most coders would expect
(zero on success, non-zero on failure).  I'd personally recommend
reversing the polarity in the macro.

Otherwise, feel free to add my acked-by line to both patches.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
