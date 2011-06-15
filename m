Return-Path: <brking@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5456B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 06:02:54 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5FJjkmP013172
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 13:45:46 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p5FK2Pmn140068
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 14:02:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5FE2NgB008211
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 08:02:24 -0600
Message-ID: <4DF90FCA.1040706@linux.vnet.ibm.com>
Date: Wed, 15 Jun 2011 15:02:18 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libata/ipr/powerpc: regression between 2.6.39-rc4 and 2.6.39-rc5
References: <20110615191747.GA6324@us.ibm.com>
In-Reply-To: <20110615191747.GA6324@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, wayneb@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	tj@kernel.org, mbizon@freebox.fr, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/2011 02:17 PM, Nishanth Aravamudan wrote:
> From what I can tell, the only place that explicitly clears the FROZEN
> flag is the error-handling code via ata_eh_thaw_port().
> 
> So I thought either we're not invoking the error-handler at probe time
> correctly to kick the port or perhaps the SAS code is not clearing the
> flag?
> 
> I tried the following patch:
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d51f979..abd0e0b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3797,6 +3797,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
>   */
>  int ata_sas_port_start(struct ata_port *ap)
>  {
> +       ap->pflags &= ~ATA_PFLAG_FROZEN;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(ata_sas_port_start);
> 
> and the CD-ROM drive works, but I have no idea if it's the right thing
> to do. I chose this particular change, FWIW, because we call
> ata_sas_port_start before we probe in ata_sas_port_init and it seems
> like we need to mark the port as not frozen before we init it? Perhaps
> that should really be a call to a thaw function, not sure. Let's just
> say the ATA/SAS/SCSI interactions are a bit hard to follow at first :)

That looks like the right thing to do. For ipr's usage of
libata, we don't have the concept of a port frozen state, so this flag
should really never get set. The alternate way to fix this would be to
only set ATA_PFLAG_FROZEN in ata_port_alloc if ap->ops->error_handler
is not NULL.

Thanks,

Brian


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
