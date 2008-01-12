Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-106-saturday.noc.nerim.net
	[62.4.17.106]) by ozlabs.org (Postfix) with ESMTP id 6F50CDDE10
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 19:47:01 +1100 (EST)
Date: Sat, 12 Jan 2008 09:46:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH 1/5] Implement module aliasing for i2c to
	translate from device tree names
Message-ID: <20080112094658.197acb08@hyperion.delvare>
In-Reply-To: <20080111202015.65c3c160@hyperion.delvare>
References: <20071220044136.20091.70984.stgit@terra.home>
	<20071220044138.20091.31417.stgit@terra.home>
	<20080111202015.65c3c160@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Fri, 11 Jan 2008 20:20:15 +0100, Jean Delvare wrote:
> > +{
> > +	/* only powerpc drivers implement the id_table,
> > +	 * it is empty on other platforms */
> > +	if (id) {
> > +		while (id->name[0]) {
> > +			if (strcmp(client->driver_name, id->name) == 0)
> 
> This doesn't look right to me. You should be comparing client->name,
> not client->driver_name, with id->name. Where id_table is implemented,
> client->driver_name might not even be set. I see that the next patch in
> the series makes use of client->driver_name as well, so your code
> "works"... but this ain't correct still.

Err, scratch this (and related comments), I just realized what you were
trying to do. That's different from what I had in mind and so I read
your code wrong. I'll read it (and test it) again not making this
incorrect assumption and my comments will likely be different after
that. Well, I still think that it needs to be changed a bit, but
probably not in the direction I suggested at first (which, I realize
now, has its own share of issues - so it's not fair to me to point you
there.)

Sorry for the trouble. I'll post updated comments later today, but I'm
also pretty busy with other issues, some of which need to be solved
before 2.6.24 is released so I can't really delay them.

-- 
Jean Delvare
