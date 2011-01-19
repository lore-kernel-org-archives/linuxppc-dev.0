Return-Path: <jgpobox@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E209EB70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Jan 2011 12:00:34 +1100 (EST)
Received: by vws20 with SMTP id 20so126165vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 17:00:30 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4D3637AB.2040202@pobox.com>
Date: Tue, 18 Jan 2011 20:00:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] pata_mpc52xx: inherit from
	ata_bmdma_port_ops
References: <201101031445.47922.roman.fietze@telemotive.de>
	<20110103135929.GO18831@htj.dyndns.org>
	<4D21DD55.2000000@ru.mvista.com>
	<AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
	<4D21EAF1.2010504@ru.mvista.com> <4D21FA4D.3030506@mvista.com>
	<20110109224820.GB26607@mtj.dyndns.org>
In-Reply-To: <20110109224820.GB26607@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2011 05:48 PM, Tejun Heo wrote:
> pata_mpc52xx supports BMDMA but inherits ata_sff_port_ops which
> triggers BUG_ON() when a DMA command is issued.  Fix it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Roman Fietze<roman.fietze@telemotive.de>
> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
> Cc: stable@kernel.org
> ---
>   drivers/ata/pata_mpc52xx.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 8cc536e..d7d8026 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -610,7 +610,7 @@ static struct scsi_host_template mpc52xx_ata_sht = {
>   };
>
>   static struct ata_port_operations mpc52xx_ata_port_ops = {
> -	.inherits		=&ata_sff_port_ops,
> +	.inherits		=&ata_bmdma_port_ops,
>   	.sff_dev_select		= mpc52xx_ata_dev_select,
>   	.set_piomode		= mpc52xx_ata_set_piomode,

applied
