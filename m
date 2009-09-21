Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B72CFB70B3
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 08:36:02 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8LMZxJx011651
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 15:35:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n8LMcBHP020509
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 17:38:11 -0500 (CDT)
Message-ID: <4AB7FFE9.8050206@freescale.com>
Date: Mon, 21 Sep 2009 17:36:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: NAND partition names in DTS must be named "partition"?
References: <5ee96a840909211527g45b47b3fgff907df69fe48666@mail.gmail.com>
In-Reply-To: <5ee96a840909211527g45b47b3fgff907df69fe48666@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew L. Creech wrote:
> I upgraded from 2.6.29 to 2.6.31, and the kernel no longer recognized
> the partitions embedded within my DTS file.  I had to revert this
> change:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4b08e149c0e02e97ec49c2a31d14a0d3a02f8074
> 
> in order to boot.  This code looks like it expects all partitions to
> be named "partition", otherwise they're just skipped.  Is there some
> peculiarity in my setup that makes this not work, or is it a general
> problem?  I see no major differences between my DTS file and the
> stardard "mpc8313erdb.dts".

It looks like mpc8313erdb.dts needs to be updated.

That, and Documentation/powerpc/dts-bindings/mtd-physmap.txt, which 
still says, "Each node's name represents the name of the corresponding
partition of the flash device," and has examples whose names are not 
"partition". :-P

-Scott
