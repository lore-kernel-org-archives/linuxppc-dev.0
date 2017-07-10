Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5n6w0hWDzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:05:43 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Cyril Bur' <cyrilbur@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>
CC: "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "alistair@popple.id.au" <alistair@popple.id.au>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "rlippert@google.com" <rlippert@google.com>
Subject: RE: [PATCH v2 08/10] powerpc/opal: Add
 opal_async_wait_response_interruptible() to opal-async
Date: Mon, 10 Jul 2017 14:05:34 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0036C52@AcuExch.aculab.com>
References: <20170710013106.27276-1-cyrilbur@gmail.com>
 <20170710013106.27276-9-cyrilbur@gmail.com>
In-Reply-To: <20170710013106.27276-9-cyrilbur@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cyril Bur
> Sent: 10 July 2017 02:31
> This patch adds an _interruptible version of opal_async_wait_response().
> This is useful when a long running OPAL call is performed on behalf of a
> userspace thread, for example, the opal_flash_{read,write,erase}
> functions performed by the powernv-flash MTD driver.
>=20
> It is foreseeable that these functions would take upwards of two minutes
> causing the wait_event() to block long enough to cause hung task
> warnings. Furthermore, wait_event_interruptible() is preferable as
> otherwise there is no way for signals to stop the process which is going
> to be confusing in userspace.

ISTM that if you are doing (something like) a flash full device erase
(that really can take minutes) it isn't actually an interruptible
operation - the flash chip will still be busy.
So allowing the user process be interrupted just leaves a big mess.

OTOH the 'hung task' warning isn't the only problem with uninterruptible
sleeps - the processes also count towards the 'load average'.
Some software believes the 'load average' is a meaningful value.

It would be more generally useful for tasks to be able to sleep
uninterruptibly without counting towards the 'load average' or triggering
the 'task stuck' warning.
(I've code somewhere that sleeps interruptibly unless there is a signal
pending when it sleeps uninterruptibly.)

WRT flash erases, 'whole device' erases aren't significantly quicker
than sector by sector erases.
The latter can be interrupted between sectors.
I'm not sure you'd want to do writes than lock down enough kernel
memory to take even a second to complete.

	David
