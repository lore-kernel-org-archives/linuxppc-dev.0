Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 63B9FDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 22:09:57 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 25 Jan 2007 12:09:51 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
Message-ID: <20070125110951.GA31911@iram.es>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
	<2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 03:23:47PM +0100, Segher Boessenkool wrote:
> >I believed that the patch also worked on desktops. Of course, one
> >solution is to try to reset time from an NTP server on resume if you
> >are connected (if you are not, then an error of a fraction of a second
> >is less serious).
> 
> A fraction of a second is *never* serious, except with
> broken apps ;-)
> 

You've obviously never met people doing VLBI (Very Long Baseline 
Interferometry) ;-) 

Seriously, here we have a bunch of machines doing data acquisition
which are synchronized through timestamps taken at interrupt time.
They need an accuracy ot 5-10ms, which NTP easily provides (we have
our own redundant NTP servers connected to reference clocks: GPS
receivers and high precision clocks including an hydrogen maser).
Fortunately they never perform a suspend/resume cycle, because this
precision is not achievable even when trying to synchronize with the
second transition from the RTC.

If we did suspend the machines to save power, the only solution 
would be to tell NTP to synchronize with the master clock by 
stepping the time (not slewing) at resume time.

	Gabriel
