Return-Path: <thierry.reding@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 996C81A007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:15:44 +1000 (EST)
Received: by mail-wi0-f176.google.com with SMTP id fb4so8290567wid.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:15:40 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:15:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
Message-ID: <20140925071536.GG12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
In-Reply-To: <1411614872-4009-2-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
> Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
> argument.

That's not true. Out of the four drivers that you modify two use the
parameter. And the two that don't probably should be using it too.

50% is not "rarely". =3D)

>           We can look up msi_chip pointer by the device pointer
> or irq number, so clean up msi_chip argument.

I don't like this particular change. The idea was to keep the API object
oriented so that drivers wouldn't have to know where to get the MSI chip
=66rom. It also makes it more resilient against code reorganizations since
the core code is the only place that needs to know where to get the chip
=66rom.

Thierry

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8EYAAoJEN0jrNd/PrOhKe8P+wRzEsusQS8lMmL8zyqvg5wy
x0Q4+eSI5aEkUEQz6Mtcld6eIwACphFOHeoDrAFauuxrjVqWslHdYAIAKbYoxG0e
xV9PJoc5PY24v4vnR5BvWEHxBfzfJ8QmFlDZGRvy3lqTPhTBOzLIbNUMO1gaoH1Q
MIzSjgl631075wZns41KNNx1TjCaXNeDwjkAyyX4bjJ7SL6ymrsxGo/zhCRCpZSk
2ks9AFoqFQoIOFeziuAW7WAx8BM9ah1ba5tc3oVZ6LC3JHrvoHZ5KCjITV75Geqb
dFzQh7Rx0yFdXVmNOX+O6XtFVvb7hNFELV1SAzQQXWl0Hyid6Dp0ZShKLSumNdG8
WvJFtUil25Prid9JVvpq+PrRGlbOucv0U+wi2cbdrE9/7UwtYoxAHNj/aTXdWwIv
d6ble8v0UT7l5Sk8QIFMI3VbatPqL/i+Mz8NijIKaMRug9/XmXZIN0Q05JhlbJ2b
/AWyYKLGAwYMrZcDU2v8CajO/NGUQ9D+mkqcN0NDsxmvP5woL6GC2tQzZABaAipF
LlbM5T6PfjxRfOvYNAIOJnttoirlQ4UI8CjVEeotPrchQalN7ZESvaHK0z2/Wrv1
kSvUiqTvOPtRaQn4rIs5MTi7tw5NBsG2MyWfy90WkITpn5vEYrX4JQITTUpa/x9B
IKT68Y/8ZFK3ksbjHtIe
=LSxe
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
