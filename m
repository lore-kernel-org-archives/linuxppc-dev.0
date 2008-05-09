Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id ED4A6DDF71
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 23:31:38 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so348208anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 09 May 2008 06:31:37 -0700 (PDT)
Message-ID: <fa686aa40805090631v2e8bc87fq24583f863872df97@mail.gmail.com>
Date: Fri, 9 May 2008 07:31:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jason Jin" <Jason.jin@freescale.com>
Subject: Re: [PATCH 2/4 V4] MSI support on 83xx/85xx/86xx board
In-Reply-To: <1210323810-24833-2-git-send-email-Jason.jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<1210323810-24833-2-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 9, 2008 at 3:03 AM, Jason Jin <Jason.jin@freescale.com> wrote:
> This MSI driver can be used on 83xx/85xx/86xx board.
> In this driver, virtual interrupt host and chip were
> setup. There are 256 MSI interrupts in this host, Every 32
> MSI interrupts cascaded to one IPIC/MPIC interrupt.
> The chip was treated as edge sensitive and some necessary
> functions were setup for this chip.
>
> Before using the MSI interrupt, PCI/PCIE device need to
> ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
> bitmap show which MSI interrupt was used, reserve bit in
> the bitmap can be used to force the device use some designate
> MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
> for testing the all the MSI interrupts. The msi-available-ranges
> property in the dts file was used for this purpose.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
> Update to V4 version per the suggestion's from Michael Ellerman
> +static struct of_platform_driver fsl_of_msi_driver = {
> +       .name = "fsl-of-msi",
> +       .match_table = fsl_of_msi_ids,
> +       .probe = fsl_of_msi_probe,
> +};

nitpick: 'of' in 'fsl-of-msi' is redundant.  We *already* know that
this is an of_platform driver.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
