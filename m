Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D099C2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 11:11:43 +1100 (EST)
Date: Mon, 28 Oct 2013 17:47:45 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Joel Schopp <jschopp@linux.vnet.ibm.com>
Subject: Re: [tpmdd-devel] Has anyone a ATMEL TPM Chip on PPC64
 (CONFIG_TCG_ATMEL)?
Message-ID: <20131028234745.GB26666@obsidianresearch.com>
References: <201310272306.09310.PeterHuewe@gmx.de>
 <526EA6FF.2080401@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <526EA6FF.2080401@linux.vnet.ibm.com>
Cc: Peter H?we <PeterHuewe@gmx.de>, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 28, 2013 at 01:03:43PM -0500, Joel Schopp wrote:
> On 10/27/2013 05:06 PM, Peter H?we wrote:
> > Hi,
> > 
> > I was wondering if anyone here on this list still has a machine with an old 
> > ATMEL TPM (trusted platform module) lying around?
> > 
> >>From the kconfig entry it becomes evident that it was only supported on ppc64 
> > machines.
> > 
> > config TCG_ATMEL
> > 	tristate "Atmel TPM Interface"
> > 	depends on PPC64 || HAS_IOPORT

Hurm, that is crazy, because tpm_atmel.h contains an #else block for
!CONFIG_PPC64. The single major source of complexity in this driver is
that else block.

The driver would be fine, and straightforward if it was a standard,
modern DT enabled driver, which is very easy if PPC64 is the only
supported implementation.

> I reccomend removing the driver.  If the stars align and a user actually
> appears who wants to use one I'll clean up the driver and resubmit it
> for inclusion.  I just don't think that will happen.

The needed clean up is really easy actually, replace everything below
'tpm_vendor_specific tpm_atmel' with approximately this:

static int atml_probe(struct platform_device *pdev)
{
	struct tpm_chip *chip;
	struct resrouce *res;

        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
        if (!r)
                return -EIO;

	if (!(chip = tpm_register_hardware(dev, &tpm_atmel)))
               return -ENODEV;

	chip->iobase = devm_request_and_ioremap(&pdev->dev, res);
	if (!chip->iobase)
	       	return -ENOMEM;

	return 0;
}

static void atml_plat_remove(struct platform_device *pdev)
{
        struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
	tpm_remove_hardware(chip->dev);		
};

static const struct of_device_id platform_match[] = {
        {.compatible = "AT97SC3201"},
        {},
};
MODULE_DEVICE_TABLE(of, platform_match);

static SIMPLE_DEV_PM_OPS(tpm_atml_pm, tpm_pm_suspend, tpm_pm_resume);

static struct platform_driver atml_drv = {
        .probe = atml_probe,
        .remove = atml_plat_remove,
        .driver = {
                .name = "tpm_atmel",
                .owner          = THIS_MODULE,
                .pm             = &tpm_atml_pm,
		.of_match_table = of_match_ptr(platform_match),
        },
};

module_platform_driver(atml_drv);

MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
MODULE_DESCRIPTION("TPM Driver");
MODULE_VERSION("2.0");
MODULE_LICENSE("GPL");

If you guys can convice yourselves that doesn't obviously break anything I can
probably send a proper patch.

Jason
