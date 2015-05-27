Return-Path: <stripathi@apm.com>
Received: from mail-wg0-f51.google.com (exprod5og109.obsmtp.com [64.18.0.188])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D9AA1A066D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 00:17:03 +1000 (AEST)
Received: by wgez8 with SMTP id z8so10953899wge.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 07:16:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
 <1432197817-22110-3-git-send-email-stripathi@apm.com>
 <CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
Date: Wed, 27 May 2015 19:46:59 +0530
Message-ID: <CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
From: Suman Tripathi <stripathi@apm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Michal Simek <michal.simek@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Don Dutile <ddutile@redhat.com>,
 Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>,
 patches <patches@apm.com>
Content-Type: multipart/alternative; boundary=047d7ba97f1a656728051710e5e3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7ba97f1a656728051710e5e3
Content-Type: text/plain; charset=UTF-8

On Tue, May 26, 2015 at 6:06 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 21 May 2015 at 10:43, Suman Tripathi <stripathi@apm.com> wrote:
> > The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
> > This patch adds the support to disable SDR104/SDR50/DDR50 based on
> > reading the capability register 0.
> >
> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
> > ---
> > ---
> >  drivers/mmc/host/sdhci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 58c1770..a3d9b8a 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)
> >                 }
> >         }
> >
> > -       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> > +       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
> > +           !(caps[0] & SDHCI_CAN_VDD_180))
> >                 caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> >                        SDHCI_SUPPORT_DDR50);
> >
> > --
> > 1.8.2.1
> >
>
> I have no problem with this patch, except that it would be nice to get
> a few "tested by" to make sure it doesn't break UHS support for some
> SoCs.
>
> Kind regards
> Uffe
>

Can anyone test this in some other SoC ? Appreciate your help ..


-- 
Thanks,
with regards,
Suman Tripathi

--047d7ba97f1a656728051710e5e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, May 26, 2015 at 6:06 PM, Ulf Hansson <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:ulf.hansson@linaro.org" target=3D"_blank">ulf.hansson@linaro.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"H=
OEnZb"><div class=3D"h5">On 21 May 2015 at 10:43, Suman Tripathi &lt;<a hre=
f=3D"mailto:stripathi@apm.com">stripathi@apm.com</a>&gt; wrote:<br>
&gt; The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.<b=
r>
&gt; This patch adds the support to disable SDR104/SDR50/DDR50 based on<br>
&gt; reading the capability register 0.<br>
&gt;<br>
&gt; Signed-off-by: Suman Tripathi &lt;<a href=3D"mailto:stripathi@apm.com"=
>stripathi@apm.com</a>&gt;<br>
&gt; ---<br>
&gt; ---<br>
&gt;=C2=A0 drivers/mmc/host/sdhci.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c<br>
&gt; index 58c1770..a3d9b8a 100644<br>
&gt; --- a/drivers/mmc/host/sdhci.c<br>
&gt; +++ b/drivers/mmc/host/sdhci.c<br>
&gt; @@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;quirks2 &amp; SDHCI_QUIRK2_NO=
_1_8_V)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;quirks2 &amp; SDHCI_QUIRK2_NO=
_1_8_V ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(caps[0] &amp; SDHCI_CAN_VD=
D_180))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0caps[1] &=
amp;=3D ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SDHCI_SUPPORT_DDR50);<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.2.1<br>
&gt;<br>
<br>
</div></div>I have no problem with this patch, except that it would be nice=
 to get<br>
a few &quot;tested by&quot; to make sure it doesn&#39;t break UHS support f=
or some<br>
SoCs.<br>
<br>
Kind regards<br>
Uffe<br>
</blockquote></div><div class=3D"gmail_extra"><br></div>Can anyone test thi=
s in some other SoC ? Appreciate your help ..<br><br clear=3D"all"><div><br=
></div>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,<=
/div><div>with regards,</div>Suman Tripathi</div></div>
</div></div>

--047d7ba97f1a656728051710e5e3--
