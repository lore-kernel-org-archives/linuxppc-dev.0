Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26B9D67E09
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 22:47:42 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAABleaa003462
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 06:47:40 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAABldZE223826
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 04:47:39 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAABldhT013848
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 04:47:39 -0700
Subject: Re: ipr SATA support is causing problems
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 05:48:46 -0600
Message-Id: <1163159326.19697.23.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
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

On Fri, 2006-11-10 at 22:37 +1100, Paul Mackerras wrote:
> Brian,
> 
> Today I compiled up a kernel from Linus' git tree and tried it on a
> POWER6 partition.  First I found that my config no longer had the ipr
> driver, because I didn't have CONFIG_ATA and ipr now depends on
> CONFIG_ATA.  So I enabled CONFIG_ATA without enabling any of the ATA
> chip drivers, which seems a little weird, and re-enabled ipr.
> 
> However, the kernel crashed on boot with a null pointer dereference in
> the ata code called from the ipr driver (see stack trace below).
> Other people have also reported such a crash.  I then reverted commit
> 35a39691e4, and the resulting kernel booted without crashing.

John Rose reported this a few days ago.  Brian responded with this:

http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2

josh
