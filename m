Return-Path: <fabio.estevam@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0053.outbound.protection.outlook.com [104.47.2.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlXjg1jmyzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 22:44:22 +1000 (AEST)
From: Fabio Estevam <fabio.estevam@nxp.com>
To: Lukasz Majewski <lukma@denx.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com"
 <festevam@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Date: Sun, 3 Sep 2017 12:44:17 +0000
Message-ID: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
In-Reply-To: <1504436701-20700-1-git-send-email-lukma@denx.de>
Content-Type: multipart/alternative;
 boundary="_000_AM5PR0401MB262706674539BFE651706CC6E3900AM5PR0401MB2627_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_AM5PR0401MB262706674539BFE651706CC6E3900AM5PR0401MB2627_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Sorry for the top-posting]


The driver currently has:


/*
* Hardware limitation: The bclk rate must be
* never greater than 1/5 IPG clock rate
*/
if (freq * 5 > clk_get_rate(ssi_private->clk)) {
dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
return -EINVAL;
}


Isn't this properly taking care of the clock restriction?

________________________________
From: Lukasz Majewski <lukma@denx.de>
Sent: Sunday, September 3, 2017 8:05:01 AM
To: Timur Tabi; Nicolin Chen; Xiubo Li; Fabio Estevam; Liam Girdwood; Mark =
Brown; Jaroslav Kysela; Takashi Iwai
Cc: alsa-devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org; linux-kerne=
l@vger.kernel.org; Lukasz Majewski
Subject: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal to=
 system freq

The problem is visible in the following setup (on the imx6q):
"simple-audio-card" -> ssi2 -> I2S + I2C -> codec

The function call log (simple-card probe -> CONFIG_SND_SIMPLE_CARD):

asoc_simple_card_init_dai() @ sound/soc/generic/simple-card-utils.c
snd_soc_dai_set_sysclk()
fsl_ssi_set_dai_sysclk() @ sound/soc/fsl/fsl_ssi.c

The last call is changing the bit clock (BCLK) frequency to SSI's IP
block clock (ipg =3D 66 MHz) [1].
This is wrong, since IMX SSI block requires the I2S BCLK to be less
than 1/5 of [1].

As a result the driver initialization passes without any errors, but the
speaker-test test case breaks.

This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
not equal to [1].

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 173cb84..1186fa9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -809,6 +809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *c=
pu_dai,
                 int clk_id, unsigned int freq, int dir)
 {
         struct fsl_ssi_private *ssi_private =3D snd_soc_dai_get_drvdata(cp=
u_dai);
+       if (clk_get_rate(ssi_private->clk) =3D=3D freq)
+               return 0;

         ssi_private->bitclk_freq =3D freq;

--
2.1.4


--_000_AM5PR0401MB262706674539BFE651706CC6E3900AM5PR0401MB2627_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>[Sorry for the top-posting]</p>
<p><br>
</p>
<p>The driver currently has:</p>
<p><br>
</p>
<p></p>
<div><span style=3D"white-space:pre"></span>/*</div>
<div><span style=3D"white-space:pre"></span>* Hardware limitation: The bclk=
 rate must be</div>
<div><span style=3D"white-space:pre"></span>* never greater than 1/5 IPG cl=
ock rate</div>
<div><span style=3D"white-space:pre"></span>*/</div>
<div><span style=3D"white-space:pre"></span>if (freq * 5 &gt; clk_get_rate(=
ssi_private-&gt;clk)) {</div>
<div><span style=3D"white-space:pre"></span>dev_err(cpu_dai-&gt;dev, &quot;=
bitclk &gt; ipgclk/5\n&quot;);</div>
<div><span style=3D"white-space:pre"></span>return -EINVAL;</div>
<div><span style=3D"white-space:pre"></span>}</div>
<br>
<p></p>
<p>Isn't this properly taking care of the clock restriction?</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lukasz Majewski &lt=
;lukma@denx.de&gt;<br>
<b>Sent:</b> Sunday, September 3, 2017 8:05:01 AM<br>
<b>To:</b> Timur Tabi; Nicolin Chen; Xiubo Li; Fabio Estevam; Liam Girdwood=
; Mark Brown; Jaroslav Kysela; Takashi Iwai<br>
<b>Cc:</b> alsa-devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org; linu=
x-kernel@vger.kernel.org; Lukasz Majewski<br>
<b>Subject:</b> [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is e=
qual to system freq</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">The problem is visible in the following setup (on =
the imx6q):<br>
&quot;simple-audio-card&quot; -&gt; ssi2 -&gt; I2S &#43; I2C -&gt; codec<br=
>
<br>
The function call log (simple-card probe -&gt; CONFIG_SND_SIMPLE_CARD):<br>
<br>
asoc_simple_card_init_dai() @ sound/soc/generic/simple-card-utils.c<br>
snd_soc_dai_set_sysclk()<br>
fsl_ssi_set_dai_sysclk() @ sound/soc/fsl/fsl_ssi.c<br>
<br>
The last call is changing the bit clock (BCLK) frequency to SSI's IP<br>
block clock (ipg =3D 66 MHz) [1].<br>
This is wrong, since IMX SSI block requires the I2S BCLK to be less<br>
than 1/5 of [1].<br>
<br>
As a result the driver initialization passes without any errors, but the<br=
>
speaker-test test case breaks.<br>
<br>
This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is<br>
not equal to [1].<br>
<br>
Signed-off-by: Lukasz Majewski &lt;lukma@denx.de&gt;<br>
---<br>
&nbsp;sound/soc/fsl/fsl_ssi.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c<br>
index 173cb84..1186fa9 100644<br>
--- a/sound/soc/fsl/fsl_ssi.c<br>
&#43;&#43;&#43; b/sound/soc/fsl/fsl_ssi.c<br>
@@ -809,6 &#43;809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_da=
i *cpu_dai,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int clk_id, unsigned int freq, int dir)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fsl_ssi_private *ss=
i_private =3D snd_soc_dai_get_drvdata(cpu_dai);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_get_rate(ssi_private-&gt;=
clk) =3D=3D freq)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssi_private-&gt;bitclk_fre=
q =3D freq;<br>
&nbsp;<br>
-- <br>
2.1.4<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_AM5PR0401MB262706674539BFE651706CC6E3900AM5PR0401MB2627_--
