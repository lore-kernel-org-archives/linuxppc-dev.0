Return-Path: <mikpe@it.uu.se>
Received: from fanny.its.uu.se (fanny.its.uu.se [130.238.4.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1037B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 20:50:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19612.33369.175358.879889@pilspetsen.it.uu.se>
Date: Fri, 24 Sep 2010 12:50:01 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
In-Reply-To: <20100924111209.3c071da3@endymion.delvare>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
	<20100923113807.4643fbbb.rdunlap@xenotime.net>
	<19611.46496.782340.466509@pilspetsen.it.uu.se>
	<20100923150559.9c67da11.rdunlap@xenotime.net>
	<20100924111209.3c071da3@endymion.delvare>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>, linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jean Delvare writes:
 > On Thu, 23 Sep 2010 15:05:59 -0700, Randy Dunlap wrote:
 > > On Thu, 23 Sep 2010 22:16:32 +0200 Mikael Pettersson wrote:
 > > > Randy Dunlap writes:
 > > >  > No kconfig warnings?
 > > > 
 > > > Not that I recall.  I can check tomorrow if necessary.
 > > 
 > > No kconfig warnings.  I checked with your .config file.
 > > 
 > > >  > Please post your full .config file.
 > > 
 > > Just a matter of module i2c-core calls of_ functions and module of_i2c calls
 > > i2c_ functions.  Hmph.  Something for Grant, Jean, and Ben to work out.
 > 
 > As far as I can see this is caused by this commit from Grant:
 > 
 > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5
 > 
 > Mikael, can you please try reverting this patch and see if it solves
 > your problem?

Yes, reverting the above commit from 2.6.36-rc5 eliminated the warnings,
and I was able to insmod the i2c-{core,dev,powermac}.ko modules.

/Mikael
