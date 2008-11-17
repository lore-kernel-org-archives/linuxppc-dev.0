Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og105.obsmtp.com (exprod7og105.obsmtp.com [64.18.2.163])
	by ozlabs.org (Postfix) with SMTP id D1277DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Nov 2008 05:36:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: command line partition information
Date: Mon, 17 Nov 2008 10:35:11 -0800
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B60858239D@SJEXCH03.ds.jdsu.net>
In-Reply-To: <4921A2EE.6050201@freescale.com>
References: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
	<4921A2EE.6050201@freescale.com>
From: "Joaquin Luna" <Joaquin.Luna@jdsu.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott,

Thanks for your help, I was able to get it working with the open
firmware option you suggested.  I had tried this a few days back with no
luck, but I think my problem at that time was that my label "nand0" did
not match what was in the dts file.  I didn't give open firmware much
attention because I am using the command line for the partition
information in my working 2.6.20 kernel.  After spending this much time
on it though, I'll take what I can get.

Thanks,
Joaquin Luna

PS

U-boot did not accept "ff800000.flash" as the MTD ID and could not load
the kernel image with that in the command line.

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Monday, November 17, 2008 11:59 AM
To: Joaquin Luna
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: command line partition information

Joaquin Luna wrote:
> I do not list any partitions in my dts file, though I tried and not
seen=20
> any change in the behavior.  I have enabled the option in the kernel
to=20
> parse the partition information from the kernel command line, is there

> something else I need to do to set up the mtdblockX devices?

Did you enable CONFIG_MTD_OF_PARTS for device-tree-based partitions?

>
mtdparts=3Dmtdparts=3Dnand0:2m(u-boot),3M(kernel),128K(dtb),30M(jffs2),32=
M(m
ycust),90M(myfs),90M(myfs2)

Try replacing "nand0" with "ff800000.flash".

-Scott
