Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05978B714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:32:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E7E5DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:32:02 +1000 (EST)
Subject: Re: [PATCH v2] drivers/hvc: add missing __devexit_p()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Frysinger <vapier@gentoo.org>
In-Reply-To: <1242632661-16198-1-git-send-email-vapier@gentoo.org>
References: <1242632521-15954-1-git-send-email-vapier@gentoo.org>
	<1242632661-16198-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 13:30:57 +1000
Message-Id: <1245123057.12400.53.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-05-18 at 03:44 -0400, Mike Frysinger wrote:
> The remove function uses __devexit, so the .remove assignment needs
> __devexit_p() to fix a build error with hotplug disabled.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> CC: linuxppc-dev@ozlabs.org
> ---
> v2

Thanks. Andrew, I'm picking this one up.

Cheers,
Ben.

> 	- include all hvc files
> 
>  drivers/char/hvc_iseries.c |    2 +-
>  drivers/char/hvc_vio.c     |    2 +-
>  drivers/char/hvcs.c        |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
> index 449727b..936d05b 100644
> --- a/drivers/char/hvc_iseries.c
> +++ b/drivers/char/hvc_iseries.c
> @@ -241,7 +241,7 @@ static int __devexit hvc_vio_remove(struct vio_dev *vdev)
>  static struct vio_driver hvc_vio_driver = {
>  	.id_table	= hvc_driver_table,
>  	.probe		= hvc_vio_probe,
> -	.remove		= hvc_vio_remove,
> +	.remove		= __devexit_p(hvc_vio_remove),
>  	.driver		= {
>  		.name	= hvc_driver_name,
>  		.owner	= THIS_MODULE,
> diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
> index bd62dc8..c72b994 100644
> --- a/drivers/char/hvc_vio.c
> +++ b/drivers/char/hvc_vio.c
> @@ -113,7 +113,7 @@ static int __devexit hvc_vio_remove(struct vio_dev *vdev)
>  static struct vio_driver hvc_vio_driver = {
>  	.id_table	= hvc_driver_table,
>  	.probe		= hvc_vio_probe,
> -	.remove		= hvc_vio_remove,
> +	.remove		= __devexit_p(hvc_vio_remove),
>  	.driver		= {
>  		.name	= hvc_driver_name,
>  		.owner	= THIS_MODULE,
> diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
> index c76bccf..2724d62 100644
> --- a/drivers/char/hvcs.c
> +++ b/drivers/char/hvcs.c
> @@ -868,7 +868,7 @@ static int __devexit hvcs_remove(struct vio_dev *dev)
>  static struct vio_driver hvcs_vio_driver = {
>  	.id_table	= hvcs_driver_table,
>  	.probe		= hvcs_probe,
> -	.remove		= hvcs_remove,
> +	.remove		= __devexit_p(hvcs_remove),
>  	.driver		= {
>  		.name	= hvcs_driver_name,
>  		.owner	= THIS_MODULE,
