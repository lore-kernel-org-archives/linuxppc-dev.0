Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 63C82DDF32
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 21:36:26 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 24 Jan 2007 11:36:21 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
Message-ID: <20070124103621.GA22579@iram.es>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169631177.18754.82.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 08:32:57PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2007-01-24 at 09:54 +0100, Gabriel Paubert wrote:
> 
> > Isn't there a way to obtain a better resolution? 
> 
> Not that I know.
> 
> > The RTC has a resolution on 1 second AFAIR. This means that there will
> > be an error of up to 1 second after resume. If you run NTP, it will
> > ultimately be corrected (I believe) but it may take a fairly long time
> > given the loop bandwidth of NTP, which will also probably write for a
> > while crap values into its drift file (/var/lib/ntp/ntp.drift on Debian 
> > but location varies with distribution).
> 
> But then, people suspending/resuming laptops know what to (or not to)
> expect I suppose :-)
> 

I believed that the patch also worked on desktops. Of course, one
solution is to try to reset time from an NTP server on resume if you
are connected (if you are not, then an error of a fraction of a second
is less serious).

The best solution may require informing the user space ntp code of
such events. This requires very likely modifications to ntp itself
(I may be wrong, I've not looked at NTP code for 5 years or so).

	Gabriel
