Return-Path: <dedekind1@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68859B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 05:24:22 +1000 (EST)
Received: by eyg5 with SMTP id 5so216780eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Apr 2011 12:24:16 -0700 (PDT)
Subject: Re: [PATCH 00/34] Make kernel build deterministic
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20110405154918.GA31337@suse.de>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<20110405154918.GA31337@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 22:24:07 +0300
Message-ID: <1302031447.2608.41.camel@koala>
Mime-Version: 1.0
Cc: anil_ravindranath@pmc-sierra.com, mchehab@redhat.com, mac@melware.de,
	aacraid@adaptec.com, linux-mtd@lists.infradead.org,
	allan.stephens@windriver.com, hpa@zytor.com,
	t.sailer@alumni.ethz.ch, gwingerde@gmail.com, x86@kernel.org,
	elf@buici.com, cluster-devel@redhat.com, ccaulfie@redhat.com,
	mingo@redhat.com, dougthompson@xmission.com, dwmw2@infradead.org,
	linux-media@vger.kernel.org, jon.maloy@ericsson.com,
	arnaud.giersch@free.fr, linux-kbuild@vger.kernel.org,
	IvDoorn@gmail.com, teigland@redhat.com,
	tony.olech@elandigitalsystems.com, apw@canonical.com,
	linux-hams@vger.kernel.org, tglx@linutronix.de,
	swhiteho@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
	linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	James.Bottomley@suse.de, tipc-discussion@lists.sourceforge.net,
	chuanxiao.dong@intel.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	bluesmoke-devel@lists.sourceforge.net
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-05 at 08:49 -0700, Greg KH wrote:
> On Tue, Apr 05, 2011 at 04:58:47PM +0200, Michal Marek wrote:
> > 
> > Hi,
> > 
> > this series makes it possible to build bit-identical kernel image and
> > modules from identical sources. Of course the build is already
> > deterministic in terms of behavior of the code, but the various
> > timestamps embedded in the object files make it hard to compare two
> > builds, for instance to verify that a makefile cleanup didn't
> > accidentally change something. A prime example is /proc/config.gz, which
> > has both a timestamp in the gzip header and a timestamp in the payload
> > data. With this series applied, a script like this will produce
> > identical kernels each time:
> 
> Very nice stuff.  Do you want to take the individual patches through one
> of your trees, or do you mind if the subsystem maintainers take them
> through theirs?

But unfortunately, it is very easy to break this and for sure it'll be
broken very soon.

So additionally, I'd suggest:
1. Instrument checkpatch.pl and make it err or warn on timestamps.
2. Probably instrument linux-next to rise a warning when people break
   this.

-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)
