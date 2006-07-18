Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 812E4679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 22:48:20 +1000 (EST)
Received: from p54b0d4e4.dip.t-dialin.net ([84.176.212.228] helo=yukito)
	by mail.genesippc.com with esmtpa (Exim 4.62 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1G2ovH-000FM7-0J
	for linuxppc-dev@ozlabs.org; Tue, 18 Jul 2006 12:43:36 +0000
From: "Matt Sealey" <matt@genesi-usa.com>
To: <linuxppc-dev@ozlabs.org>
Subject: AltiVec in the kernel
Date: Tue, 18 Jul 2006 07:48:07 -0500
Message-ID: <004c01c6aa68$6f580d00$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Once upon a time we were all told this wouldn't work for some reason,
but a lot of documentation now hints that it does actually work and
for instance there is a RAID5/6 driver (for G5) which uses AltiVec
in a kernel context.

But I didn't find any definitive documentation on how one goes about
it. The largest clue I found was in Documentation/cpu_features.txt:

	#ifdef CONFIG_ALTIVEC
	BEGIN_FTR_SECTION
		mfspr	r22,SPRN_VRSAVE		/* if G4, save vrsave register value */
		stw	r22,THREAD_VRSAVE(r23)
	END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
	#endif /* CONFIG_ALTIVEC */

So we can use AltiVec by implementing this kind of wrapper around
kernel functions which may use AltiVec?

In the code above is there ANY significance of r22 and r23 other
than that they are fairly high up and probably marked as "will
be trashed" by all the relevant ABIs and so?

Just curious, as I would like to investigate writing some docs at
least on this (in article fashion) to go with PPCZone, Libfreevec
and so on. I think there is a problem here in that simply developers
who may be interested in doing this kind of optimized code do not
know where to start (and we are thinking from a point of view of
also teaching sessions too, like we did at FTF Frankfurt 2004, so
after we teach them what AltiVec is etc. we demonstrate application
AND kernel functionality and the quirks associated with it).

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
