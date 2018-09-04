Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424Nmc04HszF3Lr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 20:46:19 +1000 (AEST)
Received: by mail-lf1-f65.google.com with SMTP id g6-v6so2519007lfb.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 03:46:19 -0700 (PDT)
Subject: Re: [PATCH 01/25] tty: Change return type to void
To: Jaejoong Kim <climbbb.kim@gmail.com>, linux-um@lists.infradead.org,
 netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-s390@vger.kernel.org, devel@driverdev.osuosl.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
 <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3b5cce6a-b4c3-edf9-51c8-0a16f156e128@cogentembedded.com>
Date: Tue, 4 Sep 2018 13:45:14 +0300
MIME-Version: 1.0
In-Reply-To: <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

On 9/4/2018 5:44 AM, Jaejoong Kim wrote:

> Many drivers with tty use the tty_stand_install(). But, there is no
> need to handle the error, since it always returns 0. So, change the
> return type of tty_standard_install() and tty_port_install() to void
> type and remove unnecessary exception handling where we use these
> functions.
> 
> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
> ---
>   drivers/tty/tty_io.c   | 10 ++++++----
>   drivers/tty/tty_port.c |  4 ++--
>   include/linux/tty.h    |  4 ++--
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
[...]
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index c56e397..63cdac1 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
>   extern void tty_release_struct(struct tty_struct *tty, int idx);
>   extern int tty_release(struct inode *inode, struct file *filp);
>   extern void tty_init_termios(struct tty_struct *tty);
> -extern int tty_standard_install(struct tty_driver *driver,
> +extern void tty_standard_install(struct tty_driver *driver,
>   		struct tty_struct *tty);
>   
>   extern struct mutex tty_mutex;
> @@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,
>   extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
>   extern void tty_port_close(struct tty_port *port,
>   				struct tty_struct *tty, struct file *filp);
> -extern int tty_port_install(struct tty_port *port, struct tty_driver *driver,
> +extern void tty_port_install(struct tty_port *port, struct tty_driver *driver,
>   				struct tty_struct *tty);

    You need to update all the callers in the same patch -- the kernel must 
remain buildable after each patch but you seem to have spread that update 
among a lot of patches..

[...]

MBR, Sergei
