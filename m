Return-Path: <dgibson@ozlabs.org>
Date: Wed, 22 Aug 2007 11:20:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/20] bootwrapper: Add PlanetCore firmware support.
Message-ID: <20070822012042.GD12472@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174008.GP30562@ld0162-tx32.am.freescale.net>
	<20070821031658.GQ15469@localhost.localdomain>
	<46CB12DB.3020505@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CB12DB.3020505@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 11:29:15AM -0500, Scott Wood wrote:
> David Gibson wrote:
> >>+void planetcore_prepare_table(char *table)
> >>+{
> >>+	int last_was_newline = 0;
> >>+
> >>+	while (*table != 10 || !last_was_newline) {
> >>+		if (*table == 10) {
> >>+			*table = 0;
> >>+			last_was_newline = 1;
> >>+		} else {
> >>+			last_was_newline = 0;
> >>+		}
> >>+
> >>+		table++;
> >>+	}
> > 
> > 
> > Hrm.. this loop makes my brain hurt.  It's correct as far as I can
> > determine what it's supposed to be doing, but I think there's got to
> > be a way to make what it's doing a little more obvious.
> 
> How about something like this:
> 
> char last = 0;
> 
> while (1) {
> 	if (*table == '\n') {
> 		*table = 0;
> 
> 		if (last == *table)
> 			return;
> 	}
> 
> 	last = *table++;
> }

*thinks*

How about:

do {
	if (*table == '\n')
		*table = '\0';
	table++;
} while (*(table-1) || (*table != '\n'));
*table = '\0';

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
