Return-Path: <jinzhengxiong@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 99F2AB6FC8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Dec 2011 17:43:43 +1100 (EST)
Received: by wibhm4 with SMTP id hm4so7778827wib.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Dec 2011 22:43:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1325263910-14057-83-git-send-email-Jason.jin@freescale.com>
References: <1325263910-14057-1-git-send-email-Jason.jin@freescale.com>
 <1325263910-14057-83-git-send-email-Jason.jin@freescale.com>
Date: Sat, 31 Dec 2011 14:43:38 +0800
Message-ID: <CAOwjui1g26ScD9=YAz-iqoJXk-SPZy0O5WjebXAEFKRqnht89Q@mail.gmail.com>
Subject: Re: [PATCH 82/94] USB: ehci-fsl: Fix 'have_sysif_regs' detection
From: Jason Jin <jinzhengxiong@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=f46d04428cf4603fe504b55dabd2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04428cf4603fe504b55dabd2
Content-Type: text/plain; charset=ISO-8859-1

Please ignore this mail, It's wrongly sent out. Thanks.

On Sat, Dec 31, 2011 at 12:51 AM, Jason Jin <Jason.jin@freescale.com> wrote:

> From: Pan Jiafei <Jiafei.Pan@freescale.com>
>
> extract from vendor drop QorIQ-DPAA-SDK-20111026-systembuilder.iso
>
> Previously a check was done on an ID register at the base of a CPU's
> internal USB registers to determine if system interface regsiters were
> present.  The check looked for an ID register that had the format
> ID[0:5] == ~ID[8:13] as described in the MPC5121 User's Manual to
> determine if a MPC5121 or MPC83xx/85xx was being used.
>
> There are two issues with this method:
> - The ID register is not defined on the MPC83xx/85xx CPUs, so its
>  unclear what is being checked on them.
> - Newer CPUs such as the P4080 also don't document the ID register, but
>  do share the same format as the MPC5121.  Thus the previous code did
>  not set 'have_sysif_regs' properly which results in the P4080 not
>  properly initializing its USB ports.
>
> Using the device tree 'compatible' node is a cleaner way to determine if
> 'have_sysif_regs' should be set and resolves the USB initialization issue
> seen on the P4080.
>
> Tested on a P4080-based system and compile tested on mpc512x_defconfig
> with Freescale EHCI driver enabled.
>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Integrated-by: Pan Jiafei <Jiafei.Pan@freescale.com>
> ---
>  drivers/usb/host/ehci-fsl.c      |   13 -------------
>  drivers/usb/host/ehci-fsl.h      |    3 ---
>  drivers/usb/host/fsl-mph-dr-of.c |   11 ++++++++---
>  3 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index ac5f38d..22baaec 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -52,7 +52,6 @@ static int usb_hcd_fsl_probe(const struct hc_driver
> *driver,
>        struct resource *res;
>        int irq;
>        int retval;
> -       unsigned int temp;
>
>        pr_debug("initializing FSL-SOC USB Controller\n");
>
> @@ -126,18 +125,6 @@ static int usb_hcd_fsl_probe(const struct hc_driver
> *driver,
>                goto err3;
>        }
>
> -       /*
> -        * Check if it is MPC5121 SoC, otherwise set pdata->have_sysif_regs
> -        * flag for 83xx or 8536 system interface registers.
> -        */
> -       if (pdata->big_endian_mmio)
> -               temp = in_be32(hcd->regs + FSL_SOC_USB_ID);
> -       else
> -               temp = in_le32(hcd->regs + FSL_SOC_USB_ID);
> -
> -       if ((temp & ID_MSK) != (~((temp & NID_MSK) >> 8) & ID_MSK))
> -               pdata->have_sysif_regs = 1;
> -
>        /* Enable USB controller, 83xx or 8536 */
>        if (pdata->have_sysif_regs)
>                setbits32(hcd->regs + FSL_SOC_USB_CTRL, 0x4);
> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index 2c83537..3fabed3 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -19,9 +19,6 @@
>  #define _EHCI_FSL_H
>
>  /* offsets for the non-ehci registers in the FSL SOC USB controller */
> -#define FSL_SOC_USB_ID         0x0
> -#define ID_MSK                 0x3f
> -#define NID_MSK                        0x3f00
>  #define FSL_SOC_USB_ULPIVP     0x170
>  #define FSL_SOC_USB_PORTSC1    0x184
>  #define PORT_PTS_MSK           (3<<30)
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c
> b/drivers/usb/host/fsl-mph-dr-of.c
> index 574b99e..79a66d6 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -262,19 +262,24 @@ static void fsl_usb2_mpc5121_exit(struct
> platform_device *pdev)
>        }
>  }
>
> -struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
> +static struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
>        .big_endian_desc = 1,
>        .big_endian_mmio = 1,
>        .es = 1,
> +       .have_sysif_regs = 0,
>        .le_setup_buf = 1,
>        .init = fsl_usb2_mpc5121_init,
>        .exit = fsl_usb2_mpc5121_exit,
>  };
>  #endif /* CONFIG_PPC_MPC512x */
>
> +static struct fsl_usb2_platform_data fsl_usb2_mpc8xxx_pd = {
> +       .have_sysif_regs = 1,
> +};
> +
>  static const struct of_device_id fsl_usb2_mph_dr_of_match[] = {
> -       { .compatible = "fsl-usb2-mph", },
> -       { .compatible = "fsl-usb2-dr", },
> +       { .compatible = "fsl-usb2-mph", .data = &fsl_usb2_mpc8xxx_pd, },
> +       { .compatible = "fsl-usb2-dr", .data = &fsl_usb2_mpc8xxx_pd, },
>  #ifdef CONFIG_PPC_MPC512x
>        { .compatible = "fsl,mpc5121-usb2-dr", .data =
> &fsl_usb2_mpc5121_pd, },
>  #endif
> --
> 1.7.5.1
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Best Regards,
Zhengxiong Jin

--f46d04428cf4603fe504b55dabd2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Please ignore this mail, It&#39;s wrongly sent out. Thanks.=A0<br><br><div =
class=3D"gmail_quote">On Sat, Dec 31, 2011 at 12:51 AM, Jason Jin <span dir=
=3D"ltr">&lt;<a href=3D"mailto:Jason.jin@freescale.com">Jason.jin@freescale=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: Pan Jiafei &lt;<a href=3D"mailto:Jiafe=
i.Pan@freescale.com">Jiafei.Pan@freescale.com</a>&gt;<br>
<br>
extract from vendor drop QorIQ-DPAA-SDK-20111026-systembuilder.iso<br>
<br>
Previously a check was done on an ID register at the base of a CPU&#39;s<br=
>
internal USB registers to determine if system interface regsiters were<br>
present. =A0The check looked for an ID register that had the format<br>
ID[0:5] =3D=3D ~ID[8:13] as described in the MPC5121 User&#39;s Manual to<b=
r>
determine if a MPC5121 or MPC83xx/85xx was being used.<br>
<br>
There are two issues with this method:<br>
- The ID register is not defined on the MPC83xx/85xx CPUs, so its<br>
 =A0unclear what is being checked on them.<br>
- Newer CPUs such as the P4080 also don&#39;t document the ID register, but=
<br>
 =A0do share the same format as the MPC5121. =A0Thus the previous code did<=
br>
 =A0not set &#39;have_sysif_regs&#39; properly which results in the P4080 n=
ot<br>
 =A0properly initializing its USB ports.<br>
<br>
Using the device tree &#39;compatible&#39; node is a cleaner way to determi=
ne if<br>
&#39;have_sysif_regs&#39; should be set and resolves the USB initialization=
 issue<br>
seen on the P4080.<br>
<br>
Tested on a P4080-based system and compile tested on mpc512x_defconfig<br>
with Freescale EHCI driver enabled.<br>
<br>
Cc: Anatolij Gustschin &lt;<a href=3D"mailto:agust@denx.de">agust@denx.de</=
a>&gt;<br>
Cc: David Brownell &lt;<a href=3D"mailto:dbrownell@users.sourceforge.net">d=
brownell@users.sourceforge.net</a>&gt;<br>
Cc: Kumar Gala &lt;<a href=3D"mailto:galak@kernel.crashing.org">galak@kerne=
l.crashing.org</a>&gt;<br>
Cc: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozl=
abs.org</a><br>
Signed-off-by: Peter Tyser &lt;<a href=3D"mailto:ptyser@xes-inc.com">ptyser=
@xes-inc.com</a>&gt;<br>
Signed-off-by: Greg Kroah-Hartman &lt;<a href=3D"mailto:gregkh@suse.de">gre=
gkh@suse.de</a>&gt;<br>
Integrated-by: Pan Jiafei &lt;<a href=3D"mailto:Jiafei.Pan@freescale.com">J=
iafei.Pan@freescale.com</a>&gt;<br>
---<br>
=A0drivers/usb/host/ehci-fsl.c =A0 =A0 =A0| =A0 13 -------------<br>
=A0drivers/usb/host/ehci-fsl.h =A0 =A0 =A0| =A0 =A03 ---<br>
=A0drivers/usb/host/fsl-mph-dr-of.c | =A0 11 ++++++++---<br>
=A03 files changed, 8 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c<br>
index ac5f38d..22baaec 100644<br>
--- a/drivers/usb/host/ehci-fsl.c<br>
+++ b/drivers/usb/host/ehci-fsl.c<br>
@@ -52,7 +52,6 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driv=
er,<br>
 =A0 =A0 =A0 =A0struct resource *res;<br>
 =A0 =A0 =A0 =A0int irq;<br>
 =A0 =A0 =A0 =A0int retval;<br>
- =A0 =A0 =A0 unsigned int temp;<br>
<br>
 =A0 =A0 =A0 =A0pr_debug(&quot;initializing FSL-SOC USB Controller\n&quot;)=
;<br>
<br>
@@ -126,18 +125,6 @@ static int usb_hcd_fsl_probe(const struct hc_driver *d=
river,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err3;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 /*<br>
- =A0 =A0 =A0 =A0* Check if it is MPC5121 SoC, otherwise set pdata-&gt;have=
_sysif_regs<br>
- =A0 =A0 =A0 =A0* flag for 83xx or 8536 system interface registers.<br>
- =A0 =A0 =A0 =A0*/<br>
- =A0 =A0 =A0 if (pdata-&gt;big_endian_mmio)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_be32(hcd-&gt;regs + FSL_SOC_USB_I=
D);<br>
- =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_le32(hcd-&gt;regs + FSL_SOC_USB_I=
D);<br>
-<br>
- =A0 =A0 =A0 if ((temp &amp; ID_MSK) !=3D (~((temp &amp; NID_MSK) &gt;&gt;=
 8) &amp; ID_MSK))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata-&gt;have_sysif_regs =3D 1;<br>
-<br>
 =A0 =A0 =A0 =A0/* Enable USB controller, 83xx or 8536 */<br>
 =A0 =A0 =A0 =A0if (pdata-&gt;have_sysif_regs)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setbits32(hcd-&gt;regs + FSL_SOC_USB_CTRL, =
0x4);<br>
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h<br>
index 2c83537..3fabed3 100644<br>
--- a/drivers/usb/host/ehci-fsl.h<br>
+++ b/drivers/usb/host/ehci-fsl.h<br>
@@ -19,9 +19,6 @@<br>
=A0#define _EHCI_FSL_H<br>
<br>
=A0/* offsets for the non-ehci registers in the FSL SOC USB controller */<b=
r>
-#define FSL_SOC_USB_ID =A0 =A0 =A0 =A0 0x0<br>
-#define ID_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3f<br>
-#define NID_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3f00<br>
=A0#define FSL_SOC_USB_ULPIVP =A0 =A0 0x170<br>
=A0#define FSL_SOC_USB_PORTSC1 =A0 =A00x184<br>
=A0#define PORT_PTS_MSK =A0 =A0 =A0 =A0 =A0 (3&lt;&lt;30)<br>
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c<br>
index 574b99e..79a66d6 100644<br>
--- a/drivers/usb/host/fsl-mph-dr-of.c<br>
+++ b/drivers/usb/host/fsl-mph-dr-of.c<br>
@@ -262,19 +262,24 @@ static void fsl_usb2_mpc5121_exit(struct platform_dev=
ice *pdev)<br>
 =A0 =A0 =A0 =A0}<br>
=A0}<br>
<br>
-struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd =3D {<br>
+static struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd =3D {<br>
 =A0 =A0 =A0 =A0.big_endian_desc =3D 1,<br>
 =A0 =A0 =A0 =A0.big_endian_mmio =3D 1,<br>
 =A0 =A0 =A0 =A0.es =3D 1,<br>
+ =A0 =A0 =A0 .have_sysif_regs =3D 0,<br>
 =A0 =A0 =A0 =A0.le_setup_buf =3D 1,<br>
 =A0 =A0 =A0 =A0.init =3D fsl_usb2_mpc5121_init,<br>
 =A0 =A0 =A0 =A0.exit =3D fsl_usb2_mpc5121_exit,<br>
=A0};<br>
=A0#endif /* CONFIG_PPC_MPC512x */<br>
<br>
+static struct fsl_usb2_platform_data fsl_usb2_mpc8xxx_pd =3D {<br>
+ =A0 =A0 =A0 .have_sysif_regs =3D 1,<br>
+};<br>
+<br>
=A0static const struct of_device_id fsl_usb2_mph_dr_of_match[] =3D {<br>
- =A0 =A0 =A0 { .compatible =3D &quot;fsl-usb2-mph&quot;, },<br>
- =A0 =A0 =A0 { .compatible =3D &quot;fsl-usb2-dr&quot;, },<br>
+ =A0 =A0 =A0 { .compatible =3D &quot;fsl-usb2-mph&quot;, .data =3D &amp;fs=
l_usb2_mpc8xxx_pd, },<br>
+ =A0 =A0 =A0 { .compatible =3D &quot;fsl-usb2-dr&quot;, .data =3D &amp;fsl=
_usb2_mpc8xxx_pd, },<br>
=A0#ifdef CONFIG_PPC_MPC512x<br>
 =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-usb2-dr&quot;, .data =
=3D &amp;fsl_usb2_mpc5121_pd, },<br>
=A0#endif<br>
<font color=3D"#888888">--<br>
1.7.5.1<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Best =
Regards,<br>Zhengxiong Jin<br>

--f46d04428cf4603fe504b55dabd2--
