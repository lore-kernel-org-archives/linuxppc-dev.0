Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x233.google.com (mail-pg0-x233.google.com
 [IPv6:2607:f8b0:400e:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2cMf1v2SzF0B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:21:17 +1100 (AEDT)
Received: by mail-pg0-x233.google.com with SMTP id w7so13410895pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 08:21:17 -0800 (PST)
Date: Thu, 21 Dec 2017 08:21:10 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Caleb Crome <caleb@crome.org>
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>,
 Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name,
 lukma@denx.de, Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
Message-ID: <20171221162109.GA12284@Asurada>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
 <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
 <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
 <20171218230220.GA16161@Asurada-Nvidia>
 <CAG5mAdzPuUo8SkJ_AqrgrouLWash4tge4YG7EMrdCTv9=K5FOQ@mail.gmail.com>
 <4c727cc2-2338-4e99-df09-a088a72cfd61@invoxia.com>
 <CAG5mAdwC8BjL9QmzoeqOLg8r9osJbbZBxb_oe6kJ2jy1wc6j3w@mail.gmail.com>
 <CAG5mAdzZU34WX88fJgFAWXh+e3m9Ogc4PJs9UDNGCa7H3Dtvog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG5mAdzZU34WX88fJgFAWXh+e3m9Ogc4PJs9UDNGCa7H3Dtvog@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 21, 2017 at 08:10:07AM -0800, Caleb Crome wrote:

> >>> the mainline tree, I would like to treat this mail as a separate
> >>>
> >>> bug report and fix it with a separate patch.

> >>>> warn:   11a0 11a1 1160 11a3 11a4 11a5 11a6 11a7
> >>>>
> >>>> warn: Valid frame after 1 invalid frames
> >>>>
> >>>> warn:   11c0 11c1 11c2 11c3 11c4 11c5 11c6 11c7
> >>>>
> >>>> warn: first invalid frame while expecting frame 0x00a0
> >>>>
> >>>> warn:   13e7 1400 1401 1402 1403 1404 1405 1404
> >>>>
> >>>> warn:   1407 1420 1421 1422 1423 1424 1425 1426
> >>>>
> >>>> warn:   1427 1440 1441 1442 1443 1444 1445 1484
> >>>>
> >>>> warn:   1447 1460 1461 1462 1463 1464 1465 1466
> >>>>
> >>>>
> >>>> Those last 4 lines are the channel slips -- the least significant
> >>>>
> >>>> nibble should be the channel number:  i.e. should go 0, 1, 2, 3, 4, 5,
> >>>>
> >>>> 6, 7.
> >>>>
> >>>>
> >>>> Ugh, so it's basically quite broken again -- before these patches.

> Okay, operator error on my part.  There was an old clock setting in my
> ssi3 dtsi file that (falsely) modified the ssi baud clock frequency.
> Nicolin's patch
> 
>     ASoC: fsl_ssi: Caculate bit clock rate using slot number and width
> 
> now properly computes the master clock, and the old dtsi settings that
> were necessary to fake things into the right speed are now obsolete.
> 
> So... basically, everything is back to working properly.  it wasn't
> broken at all -- just my oversight on a ssi clock setting in the dtb.

Well, that's a good news :) Thanks for the efforts during these days
to track back every corner.

Happy holiday.
Nicolin
