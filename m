Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0AD9B7BAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 23:45:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5516BDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 23:45:31 +1000 (EST)
Message-Id: <E8D39D04-E4B6-4420-AD54-6A95BE35EB30@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kalra Ashish-B00888 <ashish.kalra@freescale.com>
In-Reply-To: <16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Thu, 30 Jul 2009 08:43:18 -0500
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
	<4A70A78D.7070601@gmail.com>
	<16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	Robert Hancock <hancockrwd@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 30, 2009, at 8:23 AM, Kalra Ashish-B00888 wrote:

> Hello,
>
> >> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> >> ---
> >> drivers/ata/sata_fsl.c | 1 +
> >> 1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> >> index 5a88b44..a33f130 100644
> >> --- a/drivers/ata/sata_fsl.c
> >> +++ b/drivers/ata/sata_fsl.c
> >> @@ -1262,6 +1262,7 @@ static struct scsi_host_template  
> sata_fsl_sht = {
> >> static struct ata_port_operations sata_fsl_ops = {
> >> .inherits = &sata_pmp_port_ops,
> >>
> >> + .qc_defer = ata_std_qc_defer;
> >> .qc_prep = sata_fsl_qc_prep,
> >> .qc_issue = sata_fsl_qc_issue,
> >> .qc_fill_rtf = sata_fsl_qc_fill_rtf,
>
> > This doesn't look like it should change anything. sata_fsl_ops  
> inherits
> > from sata_pmp_port_ops, which inherits from sata_port_ops, which  
> already
> > sets qc_defer to ata_std_qc_defer.
> Oh, yes. Actually this patch was for older kernels where there  
> inheritence was not there. As you mentioned, this patch is not  
> required now.
>
How old?  Should we be asking for this to be applied to some of the  
stable kernel series?

- k
