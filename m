Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3C0BB7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 18:42:16 +1100 (EST)
Message-ID: <4B0253CF.3090506@garzik.org>
Date: Tue, 17 Nov 2009 02:42:07 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Mahajan Vivek-B08308 <B08308@freescale.com>
Subject: Re: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
	<da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com>
	<F2F605B667B24B489C904986E0D60A08012220A2@zin33exm23.fsl.freescale.net>
In-Reply-To: <F2F605B667B24B489C904986E0D60A08012220A2@zin33exm23.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, Grant Grundler <grundler@google.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2009 01:59 AM, Mahajan Vivek-B08308 wrote:
>> From: Grant Grundler [mailto:grundler@google.com]
>> Sent: Monday, November 16, 2009 11:08 PM
>>> +static int sata_sil24_msi;    /* Disable MSI */
>>> +module_param_named(msi, sata_sil24_msi, bool, S_IRUGO);
>>> +MODULE_PARM_DESC(msi, "Enable MSI (Default: false)");
>>
>> Vivek,
>> Do we even still need the parameter? I'm thinking either MSI
>> works with a chipset or it doesn't. The kernel has globals to
>> "know" which state is true.
>
> Sometimes even in a platform, some PCIe endpoints do very
> well with MSI while others may have to resort to legacy ints.
> Should we let the endpoints make the final call.
>
>>
>> If the parameter is needed, when this driver is compiled into
>> the kernel, how is "msi" parameter specified?
>> I think the parameter needs to be documented and fit in with
>> other "msi" parameters.
>> See "nomsi" in Documentation/kernel-parameters.txt.
>
> In this case "msi" is supposed to be passed via insmod and
> not via kernel cmdline. If the driver is built-in the kernel,
> then force sata_sil24_msi = 1 in the driver to enable it.

First, the original patch was just fine, and it was applied.  You should 
have received email confirmation of this already.

Second, all module options are available on the kernel command line, 
when a module is built into the kernel.  You supply a module name prefix 
to each module option, on the kernel command line.

	Jeff
