Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id 81FF1DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 11:46:02 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so2242451nzf
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 16:46:01 -0800 (PST)
Message-ID: <198592450612281646y7de55a9ep3d0361f90abb0f94@mail.gmail.com>
Date: Fri, 29 Dec 2006 00:46:00 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: spi_mpc83xx driver question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there,

I'm developing mmc driver based on spi_mpc83xx driver. Our mmc card is
connect through SPI to mpc8343E. Now the SPI controller is up, but
protocol driver has problem. I have following piece of code:

static struct spi_driver spimmc_driver = {
    .driver = {
        .name = "spimmc",
        .bus  = &spi_bus_type,
        .owner = THIS_MODULE,
    },
    .probe = spimmc_probe,
    .remove = __devexit_p(spimmc_remove),
    .suspend = spimmc_suspend,
    .resume = spimmc_resume,
};

static int __init spimmc_init (void)
{
    return spi_register_driver(&spimmc_driver);
}
module_init(spimmc_init);

Looking at sysfs, the spimmc driver is there, but ".probe" has never
been called. My question is, how this "probe" callback get called
during init? What could be the reason for that guy not being called?

If I call spimmc_probe driectly from spi_mpc83xx.c (for experiment),
kernel failure happened during boot:

[   26.484876] Badness in kref_get at lib/kref.c:32
[   26.489627] Call trace: [c0004fb0]  [c0005200]  [c00048d0]
[c00e3ad0]  [c010a780]  [c010af94]  [c013beec]  [c013b064]  [c013df68]
 [c0256474]  [c010bea
[   26.508407] Oops: kernel access of bad area, sig: 11 [#1]

I really need help from someone to explain it....

Thanks.

- Reeve
