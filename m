Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0A55DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:41:42 +1100 (EST)
Message-Id: <BAA283E5-3730-4534-AA9D-446B3135966F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1233928837-3401-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for I2C
	to complete
Date: Thu, 19 Feb 2009 10:41:30 -0600
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, broonie@opensource.wolfsonmicro.com,
	linux-i2c@vger.kernel.org, mditto@consentry.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2009, at 8:00 AM, Timur Tabi wrote:

> The i2c_wait() function is using wait_event_interruptible_timeout()  
> to wait for
> the I2C controller to signal that it has completed an I2C bus  
> operation.  If
> the process that causes the I2C operation terminated abruptly, the  
> wait will
> be interrupted, returning an error.  It is better to let the I2C  
> operation
> finished before the process exits.
>
> It is safe to use wait_event_timeout() instead, because the timeout  
> will allow
> the process to exit if the I2C bus hangs.  It's also better to allow  
> the
> I2C operation to finish, because unacknowledged I2C operations can  
> cause the
> I2C bus to hang.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> A similar change should probably be done to i2c-cpm.c, and maybe all  
> other
> I2C drivers.  Not many use wait_event_interruptible_timeout().
>
> drivers/i2c/busses/i2c-mpc.c |    9 +++------
> 1 files changed, 3 insertions(+), 6 deletions(-)

applied to next

- k
