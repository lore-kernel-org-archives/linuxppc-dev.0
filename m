Return-Path: <dmitry.torokhov@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id 663A66888B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 09:04:28 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id o37so279891nzf
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2005 14:04:26 -0800 (PST)
Message-ID: <d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
Date: Wed, 14 Dec 2005 17:04:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20051214213923.GB17548@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051213223659.GB20017@hansmi.ch>
	<1134568620.3875.6.camel@localhost> <20051214213923.GB17548@hansmi.ch>
Cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On 12/14/05, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
>  *
> + * Nov 2005 - Parag Warudkar
> + *  o Added ability to export data via relayfs
> + *
> + * Nov/Dec 2005 - Michael Hanselmann
> + *  o Compile relayfs support only if enabled in the kernel
> + *  o Enable relayfs only if requested by the user
> + *

We have an SCM, not need to have a changelog in the driver.

>
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +struct rchan* rch =3D NULL;
> +struct rchan_callbacks* rcb =3D NULL;

Initializing with 0/NULL adds to the size of the image for no reason.

>
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +static int relayfs =3D 0;

Same here.

> +module_param(relayfs, int, 0444);
> +MODULE_PARM_DESC(relayfs, "Activate relayfs support");
> +#endif
> +
>  static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>                             int *z, int *fingers)
>  {
> @@ -194,6 +219,13 @@ static void atp_complete(struct urb* urb
>                goto exit;
>        }
>
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +       /* "rch" is NULL if relayfs is not enabled */
> +       if (rch && dev->data) {
> +               relay_write(rch, dev->data, dev->urb->actual_length);
> +       }
> +#endif
> +

Haveing ifdefs in the middle of the code is not too nice. can we
please have something like this:

#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
static inline void appletouch_relayfs_dump(...)
{
...
}
static int appletouch_relayfs_init(void)
{
...
}
static void appletouch_relayfs_exit()
{
...
}
#else
static inline void appletouch_relayfs_dump(...) { }
static int appletouch_relayfs_init(void) { return 0; }
static void appletouch_relayfs_exit() { }
#endif

Also, would not it be better to initialize relayfs only when device is
opened because there won't be any data otehrwise?

--
Dmitry
