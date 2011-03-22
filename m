Return-Path: <dan.j.williams@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2F86B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 11:49:58 +1100 (EST)
Received: by wyj26 with SMTP id 26so5958871wyj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 17:49:53 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1299174901-16762-4-git-send-email-iws@ovro.caltech.edu>
References: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
	<1299174901-16762-4-git-send-email-iws@ovro.caltech.edu>
Date: Mon, 21 Mar 2011 17:49:49 -0700
Message-ID: <AANLkTim07cvTwm+KfY=Fh6SofQWyPV_3ns7qKAjzpN=d@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] fsldma: use channel name in printk output
From: Dan Williams <dan.j.williams@intel.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 3, 2011 at 9:54 AM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> This makes debugging the driver much easier when multiple channels are
> running concurrently. In addition, you can see how much descriptor
> memory each channel has allocated via the dmapool API in sysfs.
>
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> =A0drivers/dma/fsldma.c | =A0 69 +++++++++++++++++++++++++---------------=
---------
> =A0drivers/dma/fsldma.h | =A0 =A01 +
> =A02 files changed, 36 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 2e1af45..e535cd1 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -37,7 +37,12 @@
>
> =A0#include "fsldma.h"
>
> -static const char msg_ld_oom[] =3D "No free memory for link descriptor\n=
";
> +#define chan_dbg(chan, fmt, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 dev_dbg(chan->dev, "%s: " fmt, chan->name, ##arg)
> +#define chan_err(chan, fmt, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 dev_err(chan->dev, "%s: " fmt, chan->name, ##arg)
> +

I already have this applied, but if you want to send an incremental
cleanup patch you could achieve a similar effect without increasing
the size of fsldma_chan by using the class device that is created by
dma_async_device_register.

Something like:

#define to_chan_dev(chan) (&chan->common.dev->device)
#define chan_err(chan, fmt, arg...) \
   dev_err(chan->dev, "%s: " fmt, dev_name(to_chan_dev(chan)), ##arg)

...where dev_name() returns something like "dma0chan0".

--
Dan
