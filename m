Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE2541A0258
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 18:01:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Date: Tue, 17 Jun 2014 10:00:59 +0200
Message-ID: <4575870.N9RCpZ4UMg@wuerfel>
In-Reply-To: <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Karsten Keil <isdn@linux-pingi.de>, Peter Hurley <peter@hurleysoftware.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 16 June 2014 09:17:11 Peter Hurley wrote:
> tty_wait_until_sent_from_close() drops the tty lock while waiting
> for the tty driver to finish sending previously accepted data (ie.,
> data remaining in its write buffer and transmit fifo).
> 
> However, dropping the tty lock is a hold-over from when the tty
> lock was system-wide; ie., one lock for all ttys.
> 
> Since commit 89c8d91e31f267703e365593f6bfebb9f6d2ad01,
> 'tty: localise the lock', dropping the tty lock has not been necessary.
> 
> CC: Karsten Keil <isdn@linux-pingi.de>
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

I don't understand the second half of the changelog, it doesn't seem
to fit here: there deadlock that we are trying to avoid here happens
when the *same* tty needs the lock to complete the function that
sends the pending data. I don't think we do still do that any more,
but it doesn't seem related to the tty lock being system-wide or not.

	Arnd
