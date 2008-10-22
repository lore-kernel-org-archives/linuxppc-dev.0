Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C1A12DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:42:44 +1100 (EST)
Date: Wed, 22 Oct 2008 05:42:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Message-ID: <20081022014243.GA19362@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
	<20081017212942.GA1919@oksana.dev.rtsoft.ru>
	<200810200029.58312.david-b@pacbell.net>
	<20081020154835.GA3234@oksana.dev.rtsoft.ru>
	<1224635360.7654.294.camel@pasglop>
	<20081022010347.GA7377@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081022010347.GA7377@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 05:03:47AM +0400, Anton Vorontsov wrote:
> On Wed, Oct 22, 2008 at 11:29:20AM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > But it doesn't work as a module (i.e. OF-specific bits should be
> > > always in-kernel).
> > 
> > Why not ?
> 
> If say "X" driver loads prior to bus-notifier module (where we fill
> the platform data), then X.0 device will try to probe w/o platform
> data and will fail. The only way to re-probe things is to rmmod X &&
> insmod of_pdata_filler_X && insmod X. So things depend on the module
> load order.

Thinking about it more, I started recalling other issues. The bus
notifier chain doesn't replay previous events, so we also have to
register the notifier before the _devices_ are registered. And this
ruins the whole approach. :-/ Yeah, that's why I abandoned the bus
notifier idea.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
