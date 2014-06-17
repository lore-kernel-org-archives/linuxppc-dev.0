Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 231AD1A0514
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 21:31:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Date: Tue, 17 Jun 2014 13:31:38 +0200
Message-ID: <8191805.dfI4LbYmWz@wuerfel>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <53A01F02.7000202@hurleysoftware.com>
 <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Karsten Keil <isdn@linux-pingi.de>, 'Peter Hurley' <peter@hurleysoftware.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 17 June 2014 11:03:50 David Laight wrote:
> From: Peter Hurley
> ...
> > > I don't understand the second half of the changelog, it doesn't seem
> > > to fit here: there deadlock that we are trying to avoid here happens
> > > when the *same* tty needs the lock to complete the function that
> > > sends the pending data. I don't think we do still do that any more,
> > > but it doesn't seem related to the tty lock being system-wide or not.
> > 
> > The tty lock is not used in the i/o path; it's purpose is to
> > mutually exclude state changes in open(), close() and hangup().
> > 
> > The commit that added this [1] comments that _other_ ttys may wait
> > for this tty to complete, and comments in the code note that this
> > function should be removed when the system-wide tty mutex was removed
> > (which happened with the commit noted in the changelog).
> 
> What happens if another process tries to do a non-blocking open
> while you are sleeping in close waiting for output to drain?
> 
> Hopefully this returns before that data has drained.

Before the patch, I believe tty_reopen() would return -EIO because
the TTY_CLOSING flag is set. After the patch, tty_open() blocks
on tty_lock() before calling tty_reopen(). AFAICT, this is independent
of O_NONBLOCK.

	Arnd
