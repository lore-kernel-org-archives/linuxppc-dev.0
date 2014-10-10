Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk
 (7.3.c.8.2.a.e.f.f.f.8.1.0.3.2.0.9.6.0.7.2.3.f.b.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:bf32:7069:230:18ff:fea2:8c37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 196241A06F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 19:58:57 +1100 (EST)
Date: Fri, 10 Oct 2014 09:58:28 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Message-ID: <20141010095828.1f0de28b@alan.etchedpixels.co.uk>
In-Reply-To: <5434B5D3.4060308@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
 <4575870.N9RCpZ4UMg@wuerfel> <53A01F02.7000202@hurleysoftware.com>
 <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
 <5434B5D3.4060308@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Keil <isdn@linux-pingi.de>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>,
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

> The point being that holding the tty lock across the _entire_ close
> is equivalent to the current outcome, regardless of O_NONBLOCK.
> 
> I'm reluctant to start returning EGAIN for non-blocking tty opens
> because no tty driver does that now, and I don't think userspace will
> deal well with new return codes from tty opens.

I do not know about the non blocking case mattering. The blocking open
does need to wait, when I broke that case before I broke the console
login drivers (mingetty).

Returning EAGAIN would also only work if poll/select did the right thing.
Currently Linux can't support a System5 style ttymon process because of
this limitation, which means, for example, that systemd can't implement a
single thread to manage all console prompts/setup

Alan
