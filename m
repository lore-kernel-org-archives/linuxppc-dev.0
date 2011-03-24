Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 2BDB01007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2011 02:14:41 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
Message-id: <hvc-kick-notask@mdm.bga.com>
Subject: Re: hvc_console: Don't access hvc_task if not initialised
To: Amit Shah <amit.shah@redhat.com>
References: <df8ea6d65c1ceeb25b0a3fdfc66995b8a8273ea5.1300951793.git.amit.shah@redhat.com>
In-Reply-To: <df8ea6d65c1ceeb25b0a3fdfc66995b8a8273ea5.1300951793.git.amit.shah@redhat.com>
Date: Thu, 24 Mar 2011 08:58:04 -0600
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, greg@kroah.com, Amit Shah <amit.shah@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[removed stable list from discussion]

On Thu, 24 Mar 2011 07:29:58 -0000, Amit Shah wrote:
> hvc_open() can be called without having any backing device.  This
> results in a call to hvc_kick() which calls wake_up_process on a NULL
> pointer.  

How is hvc_open called without a hvc_driver registered to the tty layer?

> Ensure hvc is initialised by checking for a non-NULL hvc_task
> before waking up the hvc thread.

No if the task is missing the subsystem is really stuck.  Put a check
in open and refuse to open.

> 
> This was found by an autotest run for virtio_console without having a
> console backend.
> 

stack trace please

> CC: stable@kernel.org
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> ---
> drivers/tty/hvc/hvc_console.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index e9cba13..b2cb5cc 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -286,6 +286,9 @@ EXPORT_SYMBOL_GPL(hvc_instantiate);
>  /* Wake the sleeping khvcd */
>  void hvc_kick(void)
>  {
> +	if (!hvc_task)
> +		return;
> +
>  	hvc_kicked = 1;
>  	wake_up_process(hvc_task);
>  }
