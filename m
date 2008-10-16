Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/5] hvc_console: Add tty window resizing
Date: Thu, 16 Oct 2008 22:41:29 +1100
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.306993844@linux.vnet.ibm.com>
In-Reply-To: <20081014091413.306993844@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810162241.29883.rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 14 October 2008 20:12:51 Hendrik Brueckner wrote:
> From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>
> The patch provides the hvc_resize() function to update the terminal
> window dimensions (struct winsize) for a specified hvc console.
> The function stores the new window size and schedules a function
> that finally updates the tty winsize and signals the change to
> user space (SIGWINCH).
> Because the winsize update must acquire a mutex and might sleep,
> the function is scheduled instead of being called from hvc_poll()
> or khvcd.

I want this functionality for lguest, too.  But I don't see anything which 
uses this call yet?   Are we going to use the config_change notifier from 
virtio?  (Which IIRC neither S/390 nor lguest have plumbed in).

Cheers,
Rusty.
