Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7E7EDDDA7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 02:56:14 +1100 (EST)
Date: Tue, 10 Feb 2009 16:55:54 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C   to complete
Message-ID: <20090210165554.0da8bf7c@hyperion.delvare>
In-Reply-To: <ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Feb 2009 08:59:57 -0600, Timur Tabi wrote:
> On Fri, Feb 6, 2009 at 8:00 AM, Timur Tabi <timur@freescale.com> wrote:
> > The i2c_wait() function is using wait_event_interruptible_timeout() to wait for
> > the I2C controller to signal that it has completed an I2C bus operation.  If
> > the process that causes the I2C operation terminated abruptly, the wait will
> > be interrupted, returning an error.  It is better to let the I2C operation
> > finished before the process exits.
> >
> > It is safe to use wait_event_timeout() instead, because the timeout will allow
> > the process to exit if the I2C bus hangs.  It's also better to allow the
> > I2C operation to finish, because unacknowledged I2C operations can cause the
> > I2C bus to hang.
> >
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Jean,
> 
> Could you pick up this patch for 2.6.30?

No, that's something for either Ben Dooks (Cc'd) or the powerpc tree.

-- 
Jean Delvare
