Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 7CC51DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 19:54:29 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 24 Jan 2007 09:54:20 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
Message-ID: <20070124085420.GA19810@iram.es>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>>
	<1169620444.18754.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169620444.18754.66.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 05:34:04PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2006-12-13 at 13:38 +0100, Johannes Berg wrote:
> > plain text document attachment (time-resume.patch)
> > This patch converts the time restore code from a PMU notifier to a regular
> > sys device so I can profit from it even when I don't suspend through the
> > PMU, i.e. suspend to disk.
> > 
> > Also another step towards dropping pmu_sleep_notifier completely.
> 
> I'd rather do it differently: On suspend, read the RTC and save the
> value. On resume, read it again, diff the values, and add that to the
> current time.
> 

Isn't there a way to obtain a better resolution? 

The RTC has a resolution on 1 second AFAIR. This means that there will
be an error of up to 1 second after resume. If you run NTP, it will
ultimately be corrected (I believe) but it may take a fairly long time
given the loop bandwidth of NTP, which will also probably write for a
while crap values into its drift file (/var/lib/ntp/ntp.drift on Debian 
but location varies with distribution).

	Regards,
	Gabriel
