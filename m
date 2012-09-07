Return-Path: <rcj@pochix.net>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F1332C0095
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 02:33:14 +1000 (EST)
Received: by ieak14 with SMTP id k14so628804iea.15
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Sep 2012 09:33:12 -0700 (PDT)
MIME-Version: 1.0
Sender: rcj@pochix.net
In-Reply-To: <1343611985.21647.25.camel@pasglop>
References: <1342630157-16468-1-git-send-email-olaf@aepfle.de>
 <1343611985.21647.25.camel@pasglop>
Date: Fri, 7 Sep 2012 11:33:12 -0500
Message-ID: <CALAi6Fcj1Np-Hm3UiJFM4FMEhMNQ=MMiVQDv6T0mEZGVmJq33A@mail.gmail.com>
Subject: Re: [PATCH] scsi/ibmvscsi: /sys/class/scsi_host/hostX/config doesn't
 show any information
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: olaf@aepfle.de, Linda Xie <lxiep@us.ibm.com>,
 Brian J King <bjking1@us.ibm.com>, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 29, 2012 at 8:33 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> scsi/ibmvscsi: Fix host config length field overflow
>
> The length field in the host config packet is only 16-bit long, so
> passing it 0x10000 (64K which is our standard PAGE_SIZE) doesn't
> work and result in an empty config from the server.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>

James, can this be added to your for-next branch so that we can
also get this to the stable trees?  Thanks.

Acked-by: Robert Jennings <rcj@linux.vnet.ibm.com>

> ---
>
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 3a6c474..337e8b3 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -1541,6 +1541,9 @@ static int ibmvscsi_do_host_config(struct ibmvscsi_host_data *hostdata,
>
>         host_config = &evt_struct->iu.mad.host_config;
>
> +       /* The transport length field is only 16-bit */
> +       length = min(0xffff, length);
> +
>         /* Set up a lun reset SRP command */
>         memset(host_config, 0x00, sizeof(*host_config));
>         host_config->common.type = VIOSRP_HOST_CONFIG_TYPE;
>
>
