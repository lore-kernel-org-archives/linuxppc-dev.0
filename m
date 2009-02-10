Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id E1824DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 01:59:59 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so101177qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 06:59:57 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1233928837-3401-1-git-send-email-timur@freescale.com>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
Date: Tue, 10 Feb 2009 08:59:57 -0600
Message-ID: <ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for I2C
	to complete
From: Timur Tabi <timur@freescale.com>
To: Jean Delvare <khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 6, 2009 at 8:00 AM, Timur Tabi <timur@freescale.com> wrote:
> The i2c_wait() function is using wait_event_interruptible_timeout() to wait for
> the I2C controller to signal that it has completed an I2C bus operation.  If
> the process that causes the I2C operation terminated abruptly, the wait will
> be interrupted, returning an error.  It is better to let the I2C operation
> finished before the process exits.
>
> It is safe to use wait_event_timeout() instead, because the timeout will allow
> the process to exit if the I2C bus hangs.  It's also better to allow the
> I2C operation to finish, because unacknowledged I2C operations can cause the
> I2C bus to hang.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Jean,

Could you pick up this patch for 2.6.30?

-- 
Timur Tabi
Linux kernel developer at Freescale
