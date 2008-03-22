Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id ACDE3DDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 01:39:36 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so431640anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 07:39:27 -0700 (PDT)
Message-ID: <fa686aa40803220739u6db84a84j167f4c31cf2f579d@mail.gmail.com>
Date: Sat, 22 Mar 2008 08:39:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anatolij Gustschin" <agust@denx.de>, "Paul Mackerras" <paulus@samba.org>
Subject: Re: Oops with TQM5200 on TQM5200
In-Reply-To: <47E4E421.8060806@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<47E28E15.2070809@semihalf.com>
	<fa686aa40803201427r2a756fd9v54f88b6e95a20aab@mail.gmail.com>
	<47E4E421.8060806@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 22, 2008 at 4:49 AM, Anatolij Gustschin <agust@denx.de> wrote:
>  Checking bcom_eng pointer for NULL before referencing data pointed
>  by it prevents oopsing, but fec driver still doesn't work (because
>  of the lost bestcomm match and resulted task allocation failure).
>  Actually the compatible property exists and should match and so
>  the fec driver shoud work.
>
>  I suggest removing .type = "dma-controller" from the bestcomm driver's
>  mpc52xx_bcom_of_match table to solve the problem.
>
>  What do you think?

Yes, I agree.  .compatible is completely sufficient to match the
device so .type is superfluous in this case.  Removing it is
appropriate.

I've already sent a patch to fix the null pointer deref.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Paul, here's one more bug fix to pick up for .25.  (I think we're done now)

Cheers,
g.

>
>  Signed-off-by: Anatolij Gustschin <agust@denx.de>
>  ---
>  diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
>  index f589999..137d830 100644
>  --- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
>  +++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
>  @@ -484,8 +484,8 @@ mpc52xx_bcom_remove(struct of_device *op)
>   }
>
>   static struct of_device_id mpc52xx_bcom_of_match[] = {
>  -       { .type = "dma-controller", .compatible = "fsl,mpc5200-bestcomm", },
>  -       { .type = "dma-controller", .compatible = "mpc5200-bestcomm", },
>  +       { .compatible = "fsl,mpc5200-bestcomm", },
>  +       { .compatible = "mpc5200-bestcomm", },
>         {},
>   };
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
