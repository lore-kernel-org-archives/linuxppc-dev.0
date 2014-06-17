Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C63DD1A027F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 22:07:52 +1000 (EST)
Date: Tue, 17 Jun 2014 12:54:41 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Message-ID: <20140617125441.67cd5ef4@alan.etchedpixels.co.uk>
In-Reply-To: <8191805.dfI4LbYmWz@wuerfel>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <53A01F02.7000202@hurleysoftware.com>
 <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
 <8191805.dfI4LbYmWz@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Keil <isdn@linux-pingi.de>,
 'Peter Hurley' <peter@hurleysoftware.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
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

> Before the patch, I believe tty_reopen() would return -EIO because
> the TTY_CLOSING flag is set. After the patch, tty_open() blocks
> on tty_lock() before calling tty_reopen(). AFAICT, this is independent
> of O_NONBLOCK.

That would be a bug then. Returning -EIO is fine (if unfriendly). The
O_NONBLOCK can't block in this case though because the port could take a
long time to give up trying to dribble its bits (up to 30 seconds or so)

Alan
