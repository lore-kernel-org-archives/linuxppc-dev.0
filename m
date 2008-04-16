Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 4E3A4DE178
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:00:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so941083uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:00:50 -0700 (PDT)
Date: Thu, 17 Apr 2008 01:00:42 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080416210042.GA3579@zarina>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<20080416184442.GA12179@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080416184442.GA12179@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 01:44:42PM -0500, Scott Wood wrote:
> On Wed, Apr 16, 2008 at 10:39:04PM +0400, Anton Vorontsov wrote:
> > +/**
> > + * gtm_reset_utimer16 - reset 16 bits timer
> > + * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
> > + * @usec:	timer interval in microseconds
> > + * @free_run:	free run flag
> > + *
> > + * This function (re)sets GTM timer so it counts up to the interval value and
> > + * fires the interrupt when the value is reached. If free_run flag was set,
> > + * timer will also reset itself upon reference value, otherwise it continues to
> > + * increment.
> > + */
> > +int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool free_run)
> 
> A maximal timeout of ~65 ms is a little low...  For use as a wakeup from
> sleep mode, I'd like to be able to request timeouts as large as the
> hardware allows.

That is about precision. You just need to implement gtm_reset_stimer()
is you want precision with a seconds, this will run a timer at 1 Hz.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
