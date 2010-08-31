Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id AFE22B7107
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 22:30:20 +1000 (EST)
Received: by pwj1 with SMTP id 1so3122784pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 05:30:18 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 31 Aug 2010 18:00:17 +0530
Message-ID: <AANLkTinBR8n9MSbNCdEmJVNBMSqX7Nde7=YMyLt3WyDu@mail.gmail.com>
Subject: SPI driver for MPC837xERDB
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636417525622a5d048f1dbe38
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636417525622a5d048f1dbe38
Content-Type: text/plain; charset=ISO-8859-1

Hi all,



I am new to linux device driver development. I have to develop a SPI driver
for MPC8377 processor based board. Right now I don't have a that board
ready(but I have the MPC837xERDB with me), so I was thinking of developing
and testing it on the RDB. But in MPC837xERDB, I don't have an SPI slave
device, the SPI pins on the board is connected to the SD card slot. Is it
possible to use SD card slot as SPI device? Also I have written a sample SPI
driver, but its probe function is not getting called?



#include <linux/module.h>
#include <linux/spi/spi.h>

static int __devinit spi_probe(struct spi_device *spi)
{
        printk(KERN_DEBUG "spi_probe...");
        return 0;
}

static int __devexit spi_remove(struct spi_device *spi)
{
        printk(KERN_DEBUG "spi_remove\n");
        return 0;
}

static struct spi_driver sample_spi_driver = {
        .driver = {
                .name = "sample-spi",
                .bus = &spi_bus_type,
                .owner = THIS_MODULE,
        },
        .probe = spi_probe,
        .remove = spi_remove,
};


static __init int spi_module_init(void)
{
  printk(KERN_INFO "SPI Driver Version 0.1\n");
  return spi_register_driver(&sample_spi_driver);
}

static __exit void spi_module_exit(void)
{
  /* unregister SPI device */
  spi_unregister_driver(&sample_spi_driver);
}

MODULE_LICENSE("GPL");

module_init(spi_module_init);
module_exit(spi_module_exit);



Any help would be greatly appreciated.
Thanks in advance,
Ravi

--001636417525622a5d048f1dbe38
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"lia-message-body lia-component-body">
				=09
						<div class=3D"lia-message-body-content">
							<p>Hi all,</p><p>=A0</p><p>I am new to linux device driver=20
development. I have to develop a SPI driver for MPC8377 processor based=20
board. Right now I don&#39;t have a that board ready(but I have the=20
MPC837xERDB with me), so I was thinking of developing and testing it on=20
the RDB. But in MPC837xERDB, I don&#39;t have an SPI slave device, the SPI=
=20
pins on the board is connected to the SD card slot. Is it possible to=20
use SD card slot as SPI device? Also I have written a sample SPI driver,
 but its probe function is not getting called?</p><p>=A0</p><pre>#include &=
lt;linux/module.h&gt;<br>#include &lt;linux/spi/spi.h&gt;<br><br>static int=
 __devinit spi_probe(struct spi_device *spi)<br>{<br>        printk(KERN_DE=
BUG &quot;spi_probe...&quot;);<br>
        return 0;<br>}<br><br>static int __devexit spi_remove(struct spi_de=
vice *spi)<br>{<br>        printk(KERN_DEBUG &quot;spi_remove\n&quot;);<br>=
        return 0;<br>}<br><br>static struct spi_driver sample_spi_driver =
=3D {<br>
        .driver =3D {<br>                .name =3D &quot;sample-spi&quot;,<=
br>                .bus =3D &amp;spi_bus_type,<br>                .owner =
=3D THIS_MODULE,<br>        },<br>        .probe =3D spi_probe,<br>        =
.remove =3D spi_remove,<br>
};<br><br><br>static __init int spi_module_init(void)<br>{<br>  printk(KERN=
_INFO &quot;SPI Driver Version 0.1\n&quot;);<br>  return spi_register_drive=
r(&amp;sample_spi_driver);<br>}<br><br>static __exit void spi_module_exit(v=
oid)<br>
{<br>  /* unregister SPI device */<br>  spi_unregister_driver(&amp;sample_s=
pi_driver);<br>}<br><br>MODULE_LICENSE(&quot;GPL&quot;);<br><br>module_init=
(spi_module_init);<br>module_exit(spi_module_exit);</pre><p>=A0</p><p>Any h=
elp would be greatly appreciated.<br>
Thanks in advance,<br>Ravi</p>						=09
						=09
						</div>
					=09
					=09
					=09
				=09
				</div>

--001636417525622a5d048f1dbe38--
