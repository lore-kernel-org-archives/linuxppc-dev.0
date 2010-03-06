Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203]) by ozlabs.org (Postfix) with ESMTP id D3B2FB7CFC
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Mar 2010 03:43:41 +1100 (EST)
Received: by ywh41 with SMTP id 41so2286752ywh.9
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Mar 2010 08:43:40 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100306050536.GA20539@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<fa686aa41002090913t4c72a3b8o5fda68723bc8d089@mail.gmail.com>
	<20100209191620.GA24539@oksana.dev.rtsoft.ru>
	<20100305120015.a2008f46.akpm@linux-foundation.org>
	<fa686aa41003051228w38579483yd4e95bb8eacf40f7@mail.gmail.com>
	<20100305123527.d6d68e56.akpm@linux-foundation.org>
	<fa686aa41003051547u1f499902w1d3efc614a9b20b6@mail.gmail.com>
	<20100306002823.GA22095@oksana.dev.rtsoft.ru>
	<fa686aa41003051954y3ea8ebebxa915efb74c58dcbb@mail.gmail.com>
	<20100306050536.GA20539@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 6 Mar 2010 09:43:20 -0700
Message-ID: <fa686aa41003060843s5b8dfc28p65541056121c4502@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 5, 2010 at 10:05 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Fri, Mar 05, 2010 at 08:54:56PM -0700, Grant Likely wrote:
> [...]
>> The last version of the patches were posted on Feb 8. =A0-rc8 was
>> released on Feb 12. =A0For changes to common code, that is a little late
>> for getting queued up for the merge window. =A0If it was a subsystem
>> that I maintain, say SPI, then I doubt I would have picked it up for
>> 2.6.34.
>
> And of course the part of the OF rework, which was first posted
> for *review* on Feb 03, is a completely different story?
>
> =A048 files changed, 317 insertions(+), 575 deletions(-)

Completely uncontroversial changes with zero functional behaviour
change.  There was no uncertainty about these ones and they were
posted almost a week earlier.

> It's in Linus' tree now.
>
> And the other part of the OF rework that was posted for review
> on Feb 13 is another story too? It's in Linus' tree as well.

All cleanups and bugfixes except for "Don't assume HAVE_LMB" which
Jeremy had already posted earlier for review.

> Your patches touch 3 architectures, and a lot of the code that
> is used by all the OF drivers, still 03 and 13 Feb was OK for
> them.
>
>> But I am not the GPIO maintainer.
>
> David is. And I heard only positive feedback on the patches
> last time.
>
>> For the record, my main concerns are:
>> - Now that I see the implementation, I think that it is too complex.
>> The bus notifiers really aren't needed and it can be done with much
>> lower impact on the core gpiolib code.
>
> That's a non-argument, what is "lower impact"? Do I touch any
> hot paths? And if nothing has changed, David (again, the gpiolib
> maintainer) is happy with the notifiers approach, why would you
> care?

Adding unneeded notifier infrastructure is churn I don't want to see.

>> Changes to common code don't work that way. =A0Sometimes things just
>> don't get enough attention and they wait another cycle, get reworked,
>> or get dropped entirely.
>
> See above wrt OF rework patches.

which all got attention, were uncontroversial, and did not introduce
functional changes.

>> For one, the device node pointer is moving out of archdata into
>> 'struct device' proper and I've got patches adding OF hooks into the
>> core of the platform bus. =A0If those patches look good to GregKH, then
>> I'll be pursing the same pattern for the other bus types (i2c, spi,
>> etc), and it will be further argument for putting the OF hooks
>> directly into gpiolib instead of using a notifier. =A0I'll be posting
>> the patches as soon as the merge window closes.
>
> I don't get it. Why is it a problem to change your patches that
> ought to be queued for 2.6.*35*?

It's not, and they are going to be queued for 2.6.35.  In fact, I
didn't posted them this week to avoid adding confusion to the merge
window.  The issues isn't changing my patches.  It is that I don't
like the notifier approach, and I intend to prove that it can be done
in a better way.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
