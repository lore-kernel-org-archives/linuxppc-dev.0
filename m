Return-Path: <dan.j.williams@gmail.com>
Received: from mail-vw0-f172.google.com (mail-vw0-f172.google.com
	[209.85.212.172]) by ozlabs.org (Postfix) with ESMTP id B59C8B6F04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 18:29:22 +1100 (EST)
Received: by vws2 with SMTP id 2so1156381vws.17
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 23:29:20 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1260797602-7476-1-git-send-email-Vishnu@freescale.com>
References: <1260797602-7476-1-git-send-email-Vishnu@freescale.com>
Date: Tue, 15 Dec 2009 00:29:20 -0700
Message-ID: <e9c3a7c20912142329j6603402ah2963d075419efa1c@mail.gmail.com>
Subject: Re: [PATCH v0] Crypto: Talitos: re-initialize async_tx descriptors
From: Dan Williams <dan.j.williams@intel.com>
To: Vishnu Suresh <Vishnu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: herbert@gondor.apana.org.au, B04825@freescale.com,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 14, 2009 at 6:33 AM, Vishnu Suresh <Vishnu@freescale.com> wrote=
:
> The async_tx descriptors contains dangling pointers.
> Hence, re-initialize them to NULL before use.
>
> Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
> ---
> o. Rebased to linux-next as of 20091214
>
> =A0drivers/crypto/talitos.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index 87f06be..9e261c6 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -952,6 +952,9 @@ static struct dma_async_tx_descriptor * talitos_prep_=
dma_xor(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0dma_async_tx_descriptor_init(&new->async_tx, &xor_chan->co=
mmon);
> + =A0 =A0 =A0 new->async_tx.parent =3D NULL;
> + =A0 =A0 =A0 new->async_tx.next =3D NULL;
> +
>
> =A0 =A0 =A0 =A0desc =3D &new->hwdesc;
> =A0 =A0 =A0 =A0/* Set destination: Last pointer pair */

These two values are owned by the async_tx api, drivers are not
supposed to touch them.  Both iop_adma and the new ppx4xx driver
(which use the async_tx channel switching capability) get away without
touching these fields which makes me suspect there is a
misunderstanding/bug somewhere else in the talitos implementation.
Also that dma_async_tx_descriptor_init() is unexpected in the hot
path, it's only needed at initial descriptor allocation.  End result I
think this driver needs some more time to brew.

--
Dan
