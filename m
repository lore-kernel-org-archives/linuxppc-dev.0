Return-Path: <jcrigby@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id D512DDDF82
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 12:09:28 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so922764wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 19:09:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241641262-5202-6-git-send-email-wd@denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
Date: Thu, 7 May 2009 20:09:26 -0600
Message-ID: <4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
From: John Rigby <jcrigby@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: multipart/alternative; boundary=001636e90eea2e6f4704695d1e5b
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636e90eea2e6f4704695d1e5b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I think the fec's parent clock is the ipb clock not the ppc core clock.
Could that be the problem?

On Wed, May 6, 2009 at 2:21 PM, Wolfgang Denk <wd@denx.de> wrote:

> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> This patch is NOT intended for inclusion into mainline, but rather a
> request for help. For some reason which I don't understand yet, the
> Ethernet interface on the ARIA board does not work in the default
> configuration, because MII probing fails.
>
> What I'm seeing is this; the problem is with this part of code in
> "drivers/net/fs_enet/mii-fec.c":
>
> 156         fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
> ...
> 163         out_be32(&fec->fecp->fec_mii_speed, fec->mii_speed);
>
> I added some debug messages, and this is what I see:
>
> On the ADS5121, we have the CPU clocked at 400 MHz.  I get:
> ...
> ## ppc_proc_freq = 399999996, fec->mii_speed = 160
> FEC MII Bus: probed
> ...
> It works fine.
>
> According to the Ref. Man.:
>        A value of 0 in this field turns off the MDC and leaves it in
>        a low-voltage state. Any non-zero value results in the MDC
>        frequency of 1/(mii_speed*2) of the system clock frequency.
> that means we have a MDC frequency of
>        400 MHz / (2 * 160) = 1.25 MHz
> which is obviously within the 2.5 MHz limit.
>
> Now ARIA is currently running at 316.8 MHz, and this is what I get:
> ...
> ## ppc_proc_freq = 316800000, fec->mii_speed = 128
> fsl-fec-mdio: probe of 80002800.mdio failed with error -5
> ...
> It fails. MDC frequency is
>        316.8 MHz / (2 * 128) = 1.24 MHz
> which should be fine.
>
> However, If I change the code to
>
> fec->mii_speed = (((ppc_proc_freq / 1000000) / 30) + 1) << 1;
>
> then I get:
> ...
> ## ppc_proc_freq = 316800000, fec->mii_speed = 22
> FEC MII Bus: probed
> ... and it's working!!! However, I compute MDC frequency as
>        316.8 MHz / (2 * 22) = 7.2 MHz
> which is far above the maximum allowed clock of 2.5 MHz ???
>
> Has anybody any idea what might be going on here?
>
>
>  drivers/net/fs_enet/mii-fec.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
> index 9d8bd97..a51dd83 100644
> --- a/drivers/net/fs_enet/mii-fec.c
> +++ b/drivers/net/fs_enet/mii-fec.c
> @@ -153,8 +153,12 @@ static int __devinit fs_enet_mdio_probe(struct
> of_device *ofdev,
>        if (!fec->fecp)
>                goto out_fec;
>
> +#if 0
>        fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
> -
> +#else
> +       fec->mii_speed = (((ppc_proc_freq / 1000000) / 30) + 1) << 1;
> +       printk("## ppc_proc_freq = %d, fec->mii_speed = %d\n",
> ppc_proc_freq, fec->mii_speed);
> +#endif
>        setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
>        setbits32(&fec->fecp->fec_ecntrl, FEC_ECNTRL_PINMUX |
>                                          FEC_ECNTRL_ETHER_EN);
> --
> 1.6.0.6
>
>

--001636e90eea2e6f4704695d1e5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think the fec&#39;s parent clock is the ipb clock not the ppc core clock.=
=A0 Could that be the problem?<br><br><div class=3D"gmail_quote">On Wed, Ma=
y 6, 2009 at 2:21 PM, Wolfgang Denk <span dir=3D"ltr">&lt;<a href=3D"mailto=
:wd@denx.de">wd@denx.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Signed-off-by: Wo=
lfgang Denk &lt;<a href=3D"mailto:wd@denx.de">wd@denx.de</a>&gt;<br>
Cc: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca">grant.lik=
ely@secretlab.ca</a>&gt;<br>
Cc: John Rigby &lt;<a href=3D"mailto:jcrigby@gmail.com">jcrigby@gmail.com</=
a>&gt;<br>
---<br>
This patch is NOT intended for inclusion into mainline, but rather a<br>
request for help. For some reason which I don&#39;t understand yet, the<br>
Ethernet interface on the ARIA board does not work in the default<br>
configuration, because MII probing fails.<br>
<br>
What I&#39;m seeing is this; the problem is with this part of code in<br>
&quot;drivers/net/fs_enet/mii-fec.c&quot;:<br>
<br>
156 =A0 =A0 =A0 =A0 fec-&gt;mii_speed =3D ((ppc_proc_freq + 4999999) / 5000=
000) &lt;&lt; 1;<br>
...<br>
163 =A0 =A0 =A0 =A0 out_be32(&amp;fec-&gt;fecp-&gt;fec_mii_speed, fec-&gt;m=
ii_speed);<br>
<br>
I added some debug messages, and this is what I see:<br>
<br>
On the ADS5121, we have the CPU clocked at 400 MHz. =A0I get:<br>
...<br>
## ppc_proc_freq =3D 399999996, fec-&gt;mii_speed =3D 160<br>
FEC MII Bus: probed<br>
...<br>
It works fine.<br>
<br>
According to the Ref. Man.:<br>
 =A0 =A0 =A0 =A0A value of 0 in this field turns off the MDC and leaves it =
in<br>
 =A0 =A0 =A0 =A0a low-voltage state. Any non-zero value results in the MDC<=
br>
 =A0 =A0 =A0 =A0frequency of 1/(mii_speed*2) of the system clock frequency.=
<br>
that means we have a MDC frequency of<br>
 =A0 =A0 =A0 =A0400 MHz / (2 * 160) =3D 1.25 MHz<br>
which is obviously within the 2.5 MHz limit.<br>
<br>
Now ARIA is currently running at 316.8 MHz, and this is what I get:<br>
...<br>
## ppc_proc_freq =3D 316800000, fec-&gt;mii_speed =3D 128<br>
fsl-fec-mdio: probe of 80002800.mdio failed with error -5<br>
...<br>
It fails. MDC frequency is<br>
 =A0 =A0 =A0 =A0316.8 MHz / (2 * 128) =3D 1.24 MHz<br>
which should be fine.<br>
<br>
However, If I change the code to<br>
<br>
fec-&gt;mii_speed =3D (((ppc_proc_freq / 1000000) / 30) + 1) &lt;&lt; 1;<br=
>
<br>
then I get:<br>
...<br>
## ppc_proc_freq =3D 316800000, fec-&gt;mii_speed =3D 22<br>
FEC MII Bus: probed<br>
... and it&#39;s working!!! However, I compute MDC frequency as<br>
 =A0 =A0 =A0 =A0316.8 MHz / (2 * 22) =3D 7.2 MHz<br>
which is far above the maximum allowed clock of 2.5 MHz ???<br>
<br>
Has anybody any idea what might be going on here?<br>
<br>
<br>
=A0drivers/net/fs_enet/mii-fec.c | =A0 =A06 +++++-<br>
=A01 files changed, 5 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c<=
br>
index 9d8bd97..a51dd83 100644<br>
--- a/drivers/net/fs_enet/mii-fec.c<br>
+++ b/drivers/net/fs_enet/mii-fec.c<br>
@@ -153,8 +153,12 @@ static int __devinit fs_enet_mdio_probe(struct of_devi=
ce *ofdev,<br>
 =A0 =A0 =A0 =A0if (!fec-&gt;fecp)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_fec;<br>
<br>
+#if 0<br>
 =A0 =A0 =A0 =A0fec-&gt;mii_speed =3D ((ppc_proc_freq + 4999999) / 5000000)=
 &lt;&lt; 1;<br>
-<br>
+#else<br>
+ =A0 =A0 =A0 fec-&gt;mii_speed =3D (((ppc_proc_freq / 1000000) / 30) + 1) =
&lt;&lt; 1;<br>
+ =A0 =A0 =A0 printk(&quot;## ppc_proc_freq =3D %d, fec-&gt;mii_speed =3D %=
d\n&quot;, ppc_proc_freq, fec-&gt;mii_speed);<br>
+#endif<br>
 =A0 =A0 =A0 =A0setbits32(&amp;fec-&gt;fecp-&gt;fec_r_cntrl, FEC_RCNTRL_MII=
_MODE);<br>
 =A0 =A0 =A0 =A0setbits32(&amp;fec-&gt;fecp-&gt;fec_ecntrl, FEC_ECNTRL_PINM=
UX |<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0FEC_ECNTRL_ETHER_EN);<br>
<font color=3D"#888888">--<br>
1.6.0.6<br>
<br>
</font></blockquote></div><br>

--001636e90eea2e6f4704695d1e5b--
