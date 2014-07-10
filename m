Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6BE81A01A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jul 2014 09:05:11 +1000 (EST)
Date: Thu, 10 Jul 2014 16:09:36 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Message-ID: <20140710230936.GA31181@kroah.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Karsten Keil <isdn@linux-pingi.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2014 at 09:17:11AM -0400, Peter Hurley wrote:
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
> ---
>  drivers/isdn/i4l/isdn_tty.c   |  2 +-
>  drivers/tty/hvc/hvc_console.c |  2 +-
>  drivers/tty/hvc/hvcs.c        |  2 +-
>  drivers/tty/tty_port.c        | 11 ++---------
>  include/linux/tty.h           | 18 ------------------
>  5 files changed, 5 insertions(+), 30 deletions(-)

I've applied the first 13 patches in this series, as it looks like you
were going to split things up from here, right?  Can you refresh these
and resend when you have that done?

thanks,

greg k-h
