Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 270F12C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 01:01:02 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 28493-03 for <linuxppc-dev@lists.ozlabs.org>;
 Tue,  4 Sep 2012 15:54:19 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Date: Tue, 4 Sep 2012 15:51:26 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6FD6@saturn3.aculab.com>
In-Reply-To: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Shaohui Xie" <Shaohui.Xie@freescale.com>, <jgarzik@pobox.com>,
 <linux-ide@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anju Bhartiya <Anju.Bhartiya@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +	/* Read command completed register */
> +	done_mask =3D ioread32(hcr_base + CC);
> +
> +	if (host_priv->quirks & SATA_FSL_QUIRK_V2_ERRATA) {
> +		if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> +			for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {
> +				qc =3D ata_qc_from_tag(ap, tag);
> +				if (qc && ata_is_atapi(qc->tf.protocol))
{
> +					atapi_flag =3D 1;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Workaround for data length mismatch errata */
> +	if (atapi_flag) {

Seems to me like the conditionals for this code are all
in the wrong order - adding code to the normal path.

The whole lot should probably be inside:
	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
and the 'atapi_flag' boolean removed.

I also wonder it this is worthy of an actual quirk?
Might be worth doing anyway.

	David
