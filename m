Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1D4Z1wRYzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 11:01:34 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id zy2so10952764pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 18:01:34 -0700 (PDT)
Subject: Re: [PATCH 2/2] powerpc: Update of_remove_property() call sites to
 remove null checking
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
 <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
 <57292702.5070507@linux.vnet.ibm.com>
 <1462431031.12473.3.camel@ellerman.id.au>
Cc: grant.likely@linaro.org, frowand.list@gmail.com, robh+dt@kernel.org,
 paulus@samba.org
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <572BECE6.1080303@gmail.com>
Date: Fri, 6 May 2016 11:01:26 +1000
MIME-Version: 1.0
In-Reply-To: <1462431031.12473.3.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------050905060000030904040301"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050905060000030904040301
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/05/16 16:50, Michael Ellerman wrote:
> On Tue, 2016-05-03 at 15:32 -0700, Tyrel Datwyler wrote: >> On 04/27/20=
16 10:34 PM, Suraj Jitindar Singh wrote: >>> diff --git a/arch/powerpc/pl=
atforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c >>=
> index ceb18d3..a560a98 100644 >>> --- a/arch/powerpc/platforms/pseries/=
mobility.c >>> +++ b/arch/powerpc/platforms/pseries/mobility.c >>> @@ -19=
1,8 +191,8 @@ static int update_dt_node(__be32 phandle, s32 scope) >>>   =
               break; >>>  >>>              case 0x80000000: >>> -       =
         prop =3D of_find_property(dn, prop_name, NULL); >>> -           =
     of_remove_property(dn, prop); >>> +                of_remove_propert=
y(dn, of_find_property(dn, >>> +                            prop_name, NU=
LL)); >>>                  prop =3D NULL; >>>                  break; >>>=
 >> >> You haven't removed a NULL check here, as suggested by the changel=
og, >> but instead made a cosmetic change to the code that still leaves b=
ehind >> a now unnecessary "prop =3D NULL;" to bit rot. > > Yeah I think =
you're right. Though it's not
very clear how prop is used in that > function. > > Please one of you sen=
d me an incremental to remove the prop =3D NULL; > > cheers >

I didn't delete the prop =3D NULL; initially as I didn't fully understand=

how it was used in the rest of the function and the effect of deleting
it.


--------------050905060000030904040301
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    On 05/05/16 16:50, Michael Ellerman wrote:<br>
    <span style="white-space: pre;">&gt; On Tue, 2016-05-03 at 15:32 -0700, Tyrel Datwyler wrote:
&gt;&gt; On 04/27/2016 10:34 PM, Suraj Jitindar Singh wrote:
&gt;&gt;&gt; diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
&gt;&gt;&gt; index ceb18d3..a560a98 100644
&gt;&gt;&gt; --- a/arch/powerpc/platforms/pseries/mobility.c
&gt;&gt;&gt; +++ b/arch/powerpc/platforms/pseries/mobility.c
&gt;&gt;&gt; @@ -191,8 +191,8 @@ static int update_dt_node(__be32 phandle, s32 scope)
&gt;&gt;&gt;                  break;
&gt;&gt;&gt;  
&gt;&gt;&gt;              case 0x80000000:
&gt;&gt;&gt; -                prop = of_find_property(dn, prop_name, NULL);
&gt;&gt;&gt; -                of_remove_property(dn, prop);
&gt;&gt;&gt; +                of_remove_property(dn, of_find_property(dn,
&gt;&gt;&gt; +                            prop_name, NULL));
&gt;&gt;&gt;                  prop = NULL;
&gt;&gt;&gt;                  break;
&gt;&gt;&gt;
&gt;&gt;
&gt;&gt; You haven't removed a NULL check here, as suggested by the changelog,
&gt;&gt; but instead made a cosmetic change to the code that still leaves behind
&gt;&gt; a now unnecessary "prop = NULL;" to bit rot.
&gt;
&gt; Yeah I think you're right. Though it's not very clear how prop is used in that
&gt; function.
&gt;
&gt; Please one of you send me an incremental to remove the prop = NULL;
&gt;
&gt; cheers
&gt;</span><br>
    <br>
    I didn't delete the prop = NULL; initially as I didn't fully
    understand<br>
    how it was used in the rest of the function and the effect of
    deleting<br>
    it.<br>
    <br>
  </body>
</html>

--------------050905060000030904040301--
