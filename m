Return-Path: <brking@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 443EF67DFF
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 02:24:07 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAAFO229009534
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 10:24:02 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAAFO2w0358416
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:24:02 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAAFO1cV001212
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:24:02 -0700
Message-ID: <45549962.108@us.ibm.com>
Date: Fri, 10 Nov 2006 09:23:14 -0600
From: Brian King <brking@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: ipr SATA support is causing problems
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
In-Reply-To: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	James Bottomley <jejb@mulgrave.il.steeleye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Brian,
> 
> Today I compiled up a kernel from Linus' git tree and tried it on a
> POWER6 partition.  First I found that my config no longer had the ipr
> driver, because I didn't have CONFIG_ATA and ipr now depends on
> CONFIG_ATA.  So I enabled CONFIG_ATA without enabling any of the ATA
> chip drivers, which seems a little weird, and re-enabled ipr.

I'm not sure what the best way to fix this one is... The ideal way is to
change ipr to select CONFIG_ATA, but kconfig currently doesn't handle
that and complains about recursive dependencies since IPR depends on
CONFIG_SCSI and CONFIG_ATA selects CONFIG_SCSI. I'm guessing the
libsas SATA usage has similar problems. Right now we both use a depends
CONFIG_ATA statement. Ideally, kconfig should be fixed to handle this.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
