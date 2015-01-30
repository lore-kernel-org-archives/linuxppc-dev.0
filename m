Return-Path: <danielle.costantino@gmail.com>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C1DA1A0DF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 22:09:51 +1100 (AEDT)
Received: by mail-ie0-f171.google.com with SMTP id tr6so2675047ieb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 03:09:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
References: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
Date: Fri, 30 Jan 2015 03:09:47 -0800
Message-ID: <CAAVjN7dxBT32gAfAKbZT4OzYSjK=Y+SDR_4=FnLk7eNj69ZnYg@mail.gmail.com>
Subject: Re: [PATCH] i2c/mpc: Fix ISR return value
From: Danielle Costantino <danielle.costantino@gmail.com>
To: Amit Tomar <Amit.Tomar@freescale.com>
Content-Type: multipart/alternative; boundary=001a11c2fa0e884e04050ddca481
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c2fa0e884e04050ddca481
Content-Type: text/plain; charset=UTF-8

I have been using the driver with this modification for the past 6 months
and it has been stable in an industrial environment.I had made a few other
changes that also improve reliability (using ppc in_8 and out_8 and eieio
barriers to ensure in-order execution. This lets you remove the unneeded
double read of the status register. I also added a more robust recovery
function to handle force of bus master-ship, and clearing the arb lost
interrupt that is generated. currently this can cause the isr to trigger
and cause superfluous interrupts. I have not posted this patch because of
the extensive changes,

I will ack this patch.

On Fri, Jan 30, 2015 at 2:24 AM, Amit Tomar <Amit.Tomar@freescale.com>
wrote:

> ISR should not return IRQ_HANDLED for not handling anything.
> This patch fixes the return value of ISR for the same case.
>
>
> Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>
> ---
> drivers/i2c/busses/i2c-mpc.c |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 0edf630..7a3136f 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>         i2c->interrupt = readb(i2c->base + MPC_I2C_SR);
>         writeb(0, i2c->base + MPC_I2C_SR);
>         wake_up(&i2c->queue);
> +       return IRQ_HANDLED;
>     }
> -  return IRQ_HANDLED;
> +  return IRQ_NONE;
> }
>
> /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
- Danielle Costantino

--001a11c2fa0e884e04050ddca481
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have been using the driver with this modification for th=
e past 6 months and it has been stable in an industrial environment.I had m=
ade a few other changes that also improve reliability (using ppc in_8 and o=
ut_8 and eieio barriers to ensure in-order execution. This lets you remove =
the unneeded double read of the status register. I also added a more robust=
 recovery function to handle force of bus master-ship, and clearing the arb=
 lost interrupt that is generated. currently this can cause the isr to trig=
ger and cause superfluous interrupts. I have not posted this patch because =
of the extensive changes,<div><br></div><div>I will ack this patch.</div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jan 3=
0, 2015 at 2:24 AM, Amit Tomar <span dir=3D"ltr">&lt;<a href=3D"mailto:Amit=
.Tomar@freescale.com" target=3D"_blank">Amit.Tomar@freescale.com</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">ISR should not return IRQ_HAN=
DLED for not handling anything.<br>
This patch fixes the return value of ISR for the same case.<br>
<br>
<br>
Signed-off-by: Amit Singh Tomar &lt;<a href=3D"mailto:amit.tomar@freescale.=
com">amit.tomar@freescale.com</a>&gt;<br>
---<br>
drivers/i2c/busses/i2c-mpc.c |=C2=A0=C2=A0=C2=A0 3 ++-<br>
1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c in=
dex 0edf630..7a3136f 100644<br>
--- a/drivers/i2c/busses/i2c-mpc.c<br>
+++ b/drivers/i2c/busses/i2c-mpc.c<br>
@@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c-&gt;interrupt =3D readb(i2c-=
&gt;base + MPC_I2C_SR);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writeb(0, i2c-&gt;base + MPC_I2C=
_SR);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up(&amp;i2c-&gt;queue);<br>
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;<br>
=C2=A0=C2=A0=C2=A0 }<br>
-=C2=A0 return IRQ_HANDLED;<br>
+ =C2=A0return IRQ_NONE;<br>
}<br>
<br>
/* Sometimes 9th clock pulse isn&#39;t generated, and slave doesn&#39;t rel=
ease<br>
--<br>
1.7.9.5<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-i2c&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div style=3D"margin-left:40px">- Danielle Costantino<=
br></div></div>
</div>

--001a11c2fa0e884e04050ddca481--
