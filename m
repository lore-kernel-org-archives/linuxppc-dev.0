Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 596E6DDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 19:51:46 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1169628412.3061.11.camel@johannes.berg>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.386891000@sipsolutions.net> >
	<1169620444.18754.66.camel@localhost.localdomain>
	<1169628412.3061.11.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 19:51:40 +1100
Message-Id: <1169628700.18754.77.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-24 at 09:46 +0100, Johannes Berg wrote:
> On Wed, 2007-01-24 at 17:34 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2006-12-13 at 13:38 +0100, Johannes Berg wrote:
> > > plain text document attachment (time-resume.patch)
> > > This patch converts the time restore code from a PMU notifier to a regular
> > > sys device so I can profit from it even when I don't suspend through the
> > > PMU, i.e. suspend to disk.
> > > 
> > > Also another step towards dropping pmu_sleep_notifier completely.
> > 
> > I'd rather do it differently: On suspend, read the RTC and save the
> > value. On resume, read it again, diff the values, and add that to the
> > current time.
> 
> Alright, I can do that too, this simply shuffled the old code around.
> Will have a look at it.

Ok. I just don't like the pmac_get_boot_time() calls around all over the
place :-) That stuff is a hack I'd like to only call once at boot.

Ben.
