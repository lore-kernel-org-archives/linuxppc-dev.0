Return-Path: <rcj@pochix.net>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
 [209.85.210.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F33BA2C0137
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2012 05:45:28 +1000 (EST)
Received: by iamm10 with SMTP id m10so450883iam.15
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2012 12:45:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343611985.21647.25.camel@pasglop>
References: <1342630157-16468-1-git-send-email-olaf@aepfle.de>
 <1343611985.21647.25.camel@pasglop>
Date: Thu, 16 Aug 2012 14:45:26 -0500
Message-ID: <CALAi6FeDD5UB+p1W5yf3qYehTQYUc4WASwBo4pbc54WM2crPeA@mail.gmail.com>
Subject: Re: [PATCH] scsi/ibmvscsi: /sys/class/scsi_host/hostX/config doesn't
 show any information
From: Robert Jennings <rcj@pochix.net>
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
> n Wed, 2012-07-18 at 18:49 +0200, olaf@aepfle.de wrote:
>> From: Linda Xie <lxiep@us.ibm.com>
>>
>> Expected result:
>> It should show something like this:
>> x1521p4:~ # cat /sys/class/scsi_host/host1/config
>> PARTITIONNAME='x1521p4'
>> NWSDNAME='X1521P4'
>> HOSTNAME='X1521P4'
>> DOMAINNAME='RCHLAND.IBM.COM'
>> NAMESERVERS='9.10.244.100 9.10.244.200'
>>
>> Actual result:
>> x1521p4:~ # cat /sys/class/scsi_host/host0/config
>> x1521p4:~ #
>>
>> This patch changes the size of the buffer used for transfering config
>> data to 4K. It was tested against 2.6.19-rc2 tree.
>>
>> Reported by IBM during SLES11 beta testing:
>
> So this patch just seems to blindly replace all occurrences of PAGE_SIZE
> with HOST_PAGE_SIZE which is utterly wrong. Only one of those needs to
> be changed, the one passed to ibmvscsi_do_host_config() which is what's
> visible to the server, all the rest is just sysfs attributes and should
> remain as-is.
>
> Additionally (not even mentioning that there is no explanation as to
> what the real problem is anywhere in the changeset) I don't like the
> fix. The root of the problem is that the MAD header has a 16-bit length
> field, so writing 0x10000 (64K PAGE_SIZE) into it doesn't quite work.
>
> So in addition to a better comment, I would suggest a fix more like
> this:
>
> scsi/ibmvscsi: Fix host config length field overflow
>
> The length field in the host config packet is only 16-bit long, so
> passing it 0x10000 (64K which is our standard PAGE_SIZE) doesn't
> work and result in an empty config from the server.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>

Acked-by: Robert Jennings <rcj@linux.vnet.ibm.com>

Tested with an IBM i host and confirmed the fix.

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
