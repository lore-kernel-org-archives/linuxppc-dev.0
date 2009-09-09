Return-Path: <jeff@garzik.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 627F2B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 11:51:23 +1000 (EST)
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3D21DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 11:51:22 +1000 (EST)
Message-ID: <4AA7040F.1050707@garzik.org>
Date: Tue, 08 Sep 2009 21:25:35 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: ashish kalra <ashish.kalra@freescale.com>
Subject: Re: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
In-Reply-To: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2009 12:03 PM, ashish kalra wrote:
> From: Ashish Kalra <Ashish.Kalra@freescale.com>
> Date: Wed, 29 Jul 2009 21:15:49 +0530
>
> Fix for non-ncq & ncq commands causing timeouts when both are issued
> simultaneously to the same device.
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> ---
> drivers/ata/sata_fsl.c | 1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 5a88b44..a33f130 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1262,6 +1262,7 @@ static struct scsi_host_template sata_fsl_sht = {
> static struct ata_port_operations sata_fsl_ops = {
> .inherits = &sata_pmp_port_ops,
>
> + .qc_defer = ata_std_qc_defer;

Applied version with obvious s/;/,/ fix...

	Jeff
