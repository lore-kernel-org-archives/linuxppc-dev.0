Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3475B6F67
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 15:16:29 +1000 (EST)
Subject: Re: [PATCH v4 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110708042235.GA26357@kroah.com>
Date: Fri, 8 Jul 2011 00:16:20 -0500
Message-Id: <A300A787-C750-44BF-B2EB-E09A3534058B@kernel.crashing.org>
References: <1310097643-8414-1-git-send-email-galak@kernel.crashing.org>
	<20110708042235.GA26357@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 7, 2011, at 11:22 PM, Greg KH wrote:

> On Thu, Jul 07, 2011 at 11:00:41PM -0500, Kumar Gala wrote:
>> On some architectures we need to setup pdev_archdata before we add =
the
>> device.  Waiting til a bus_notifier is too late since we might need =
the
>> pdev_archdata in the bus notifier.  One example is setting up of =
dma_mask
>> pointers such that it can be used in a bus_notifier.
>>=20
>> We add weak noop version of arch_setup_pdev_archdata() and allow the =
arch
>> code to override with access the full definitions of struct device,
>> struct platform_device, and struct pdev_archdata.
>>=20
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> v4:
>> * Move to use a weak function based on comments from Greg
>> v3:
>> * Add more comments and add missing call to arch_setup_pdev_archdata =
in
>>  platform_device_register
>> v2:
>> * Added license, and comments about arch_setup_pdev_archdata()
>>  per Mike's comments
>>=20
>> drivers/base/platform.c         |   22 ++++++++++++++++++++++
>> include/linux/platform_device.h |    1 +
>> 2 files changed, 23 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 1c291af..060686d 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -32,6 +32,26 @@ struct device platform_bus =3D {
>> EXPORT_SYMBOL_GPL(platform_bus);
>>=20
>> /**
>> + * arch_setup_pdev_archdata - Allow manipulation of archdata before =
its used
>> + * @dev: platform device
>> + *
>> + * This is called before platform_device_add() such that any =
pdev_archdata may
>> + * be setup before the platform_notifier is called.  So if a user =
needs to
>> + * manipulate any relevant information in the pdev_archdata they can =
do:
>> + *
>> + * 	platform_devic_alloc()
>> + * 	... manipulate ...
>> + * 	platform_device_add()
>> + *
>> + * And if they don't care they can just call =
platform_device_register() and
>> + * everything will just work out.
>> + */
>> +void __weak arch_setup_pdev_archdata(struct platform_device *pdev)
>> +{
>> +	return ;
>> +}
>=20
> The "return" isn't needed, nor is the extra ' ' there, right?  :)

yep, removed the ';' as well ;)

> Change that and you can take this through the ppc tree and add a:
> 	Acked-by: Greg Kroah-Hartman
> to them.

Ack added to all.

thanks

- k=
