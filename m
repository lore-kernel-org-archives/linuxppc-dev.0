Return-Path: <dan.j.williams@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id CBE54B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 07:52:17 +1000 (EST)
Received: by wyb42 with SMTP id 42so1256202wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 14:52:16 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1285628277-26894-4-git-send-email-iws@ovro.caltech.edu>
References: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>
	<1285628277-26894-4-git-send-email-iws@ovro.caltech.edu>
Date: Wed, 29 Sep 2010 14:52:16 -0700
Message-ID: <AANLkTik4_se70GkKb2FLwsiUtQGyaHgxsLn3MQhmv5jh@mail.gmail.com>
Subject: Re: [PATCH 3/4] fsldma: remove DMA_SLAVE support
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

On Mon, Sep 27, 2010 at 3:57 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote=
:
> Now that the generic DMAEngine API has support for scatterlist to
> scatterlist copying, this implementation of the DMA_SLAVE API is no
> longer necessary.
>
> In order to let device_control() continue to function, a stub
> device_prep_slave_sg() function is provided. This allows custom device
> configuration, such as enabling external control.
>

> + =A0 =A0 =A0 case DMA_SLAVE_CONFIG:
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg =3D (struct fsldma_slave_config *)arg;

Now that I actually see someone trying to use the recommended
extension model it comes across as unsafe, what guarantees that arg is
pointing to a fsldma_slave_config.  At at minimum you could ensure
that this channel has been claimed for private usage which loosely
implies that the client knows that it is talking to an fsldma channel.
 Even safer is to just assign you a one-off dma_ctrl_cmd
(FSLDMA_EXTERNAL_START) for this purpose.  Otherwise this and the
other patches look good.

--
Dan
