Return-Path: <mlcreech@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EFFBB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 01:30:50 +1000 (EST)
Received: by vws20 with SMTP id 20so3114104vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jul 2011 08:30:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPBSBxqRywJjCfk_iuDLxn1HbuqPjJRJS=SkRQ3-Ge7SinbSBg@mail.gmail.com>
References: <BANLkTikyKObukzVw+c10HyDz+Q=PH4jozA@mail.gmail.com>
	<20110617163442.204348a0@schlenkerla.am.freescale.net>
	<CAPBSBxqRywJjCfk_iuDLxn1HbuqPjJRJS=SkRQ3-Ge7SinbSBg@mail.gmail.com>
Date: Mon, 11 Jul 2011 11:30:44 -0400
Message-ID: <CAPBSBxoOkWTAr3ry6xU4kuNdyuff8WTr7X14y2g7QVx_TtXsMA@mail.gmail.com>
Subject: Re: NAND BBT corruption on MPC83xx
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	rick22@wi.rr.com, Mike Hench <mhench@elutions.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 5, 2011 at 3:58 PM, Matthew L. Creech <mlcreech@gmail.com> wrot=
e:
>
> Separately, I set up 2 test devices to run while I was away last week.
> =A0One of them contained 2 patches:
>
> - Mike Hench's patch which eliminates this block of code in fsl_elbc_nand=
.c
> - Adam Thomson's patch
> (http://lists.infradead.org/pipermail/linux-mtd/2011-June/036427.html)
> which initializes oob_poi correctly
>
> Upon my return, the device with these patches saw no problems at all,
> and had no additional bad blocks. =A0The device without these patches
> had some 200+ blocks which had been newly marked as bad in the BBT
> over the course of 10 days. =A0After rebooting, this latter device then
> failed to boot, as shown here:
>
> http://mcreech.com/work/bbt-ecc-error4.txt
>
> I'm currently running another test to verify which of the two patches
> actually fixed this problem (which might take a few days), but it
> seems like removing that block of code in fsl_elbc_nand.c is a good
> idea.
>

Just an update: my tests confirmed that the patch to fsl_elbc_nand.c
(http://lists.infradead.org/pipermail/linux-mtd/2011-July/036893.html)
seems to have fixed these BBT corruption problems.

I ran a torture test on 2 devices for several days: the one which had
only that patch had no further issues, while the one which didn't have
it (but did have the other oob_poi patch from Adam) experienced BBT
corruption.

Thanks everyone

--=20
Matthew L. Creech
