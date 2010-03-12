Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7B494B7D19
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 02:52:51 +1100 (EST)
Date: Fri, 12 Mar 2010 07:52:13 -0800
From: Greg KH <greg@kroah.com>
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 (resend #3)] hvc_console: Fix race between hvc_close
	and hvc_remove
Message-ID: <20100312155213.GA3626@kroah.com>
References: <1268019497-6164-1-git-send-email-amit.shah@redhat.com>
	<1268374995-20722-1-git-send-email-amit.shah@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1268374995-20722-1-git-send-email-amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 12, 2010 at 11:53:15AM +0530, Amit Shah wrote:
> Alan pointed out a race in the code where hvc_remove is invoked. The
> recent virtio_console work is the first user of hvc_remove().
> 
> Alan describes it thus:
> 
> The hvc_console assumes that a close and remove call can't occur at the
> same time.
> 
> In addition tty_hangup(tty) is problematic as tty_hangup is asynchronous
> itself....
> 
> So this can happen
> 
>         hvc_close                               hvc_remove
>         hung up ? - no
>                                                 lock
>                                                 tty = hp->tty
>                                                 unlock
>         lock
>         hp->tty = NULL
>         unlock
>         notify del
>         kref_put the hvc struct
>         close completes
>         tty is destroyed
>                                                 tty_hangup dead tty
>                                                 tty->ops will be NULL
>                                                 NULL->...
> 
> This patch adds some tty krefs and also converts to using tty_vhangup().
> 
> Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
> CC: linuxppc-dev@ozlabs.org
> CC: Rusty Russell <rusty@rustcorp.com.au>
> ---
> 
> Linus, sending to you this time as I didn't receive any response from
> Ben or Greg for the previous submissions.

It's in my "to-apply" queue.  Which I was ignoring due to the -rc1
merge, and then I've been busy with -stable stuff and a conference this
week.  I'll get to it soon.

thanks for your patience,

greg k-h
