Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AAF5DE1AD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 04:53:01 +1100 (EST)
Message-ID: <47A35C66.80008@pobox.com>
Date: Fri, 01 Feb 2008 12:52:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC][NET][SERIAL] UCCs: replace device-id with
	cell-index
References: <20080201150126.GB26545@localhost.localdomain>
	<72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
	<20080201173331.GA8020@localhost.localdomain>
In-Reply-To: <20080201173331.GA8020@localhost.localdomain>
Content-Type: text/plain; charset=utf8; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-serial@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Fri, Feb 01, 2008 at 09:32:38AM -0600, Kumar Gala wrote:
>> On Feb 1, 2008, at 9:01 AM, Anton Vorontsov wrote:
>>
>>> It isn't used anywhere, so remove it. If we'll ever need something
>>> like this, we'll use compatible property instead.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>>
>>> Rebased on top of recent tree.
>>>
>>> Documentation/powerpc/booting-without-of.txt |    1 -
>>> arch/powerpc/boot/dts/mpc832x_mds.dts        |    3 ---
>>> arch/powerpc/boot/dts/mpc832x_rdb.dts        |    2 --
>>> arch/powerpc/boot/dts/mpc836x_mds.dts        |    2 --
>>> arch/powerpc/boot/dts/mpc8568mds.dts         |    2 --
>>> 5 files changed, 0 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
>>> Documentation/powerpc/booting-without-of.txt
>>> index 410c847..dcf9758 100644
>>> --- a/Documentation/powerpc/booting-without-of.txt
>>> +++ b/Documentation/powerpc/booting-without-of.txt
>>> @@ -1675,7 +1675,6 @@ platforms are moved over to use the flattened- 
>>> device-tree model.
>>> 	ucc@2000 {
>>> 		device_type = "network";
>>> 		compatible = "ucc_geth";
>>> -		model = "UCC";
>>> 		device-id = <1>;
>> can we change device-id to cell-index?
> 
> Sure. But let's do this in the separate patch? Because this change
> actually touches the code in the two subsystems: net and serial.
> 
> I hope everybody will agree to pass it through powerpc tree..?
> 
> - - - -
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [POWERPC][NET][SERIAL] UCCs: replace device-id with cell-index
> 
> device-id is worse than cell-index. Probably cell-index isn't
> good either, but device-id is worse anyway.
> 
> Drivers are modified for backward compatibility's sake.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    4 ++--
>  arch/powerpc/boot/dts/mpc832x_mds.dts        |    4 +---
>  arch/powerpc/boot/dts/mpc832x_rdb.dts        |    2 --
>  arch/powerpc/boot/dts/mpc836x_mds.dts        |    2 --
>  arch/powerpc/boot/dts/mpc836x_rdk.dts        |   12 ++++++------
>  arch/powerpc/boot/dts/mpc8568mds.dts         |    2 --
>  drivers/net/ucc_geth.c                       |    8 +++++++-
>  drivers/net/ucc_geth_mii.c                   |   11 ++++++++---
>  drivers/serial/ucc_uart.c                    |   16 ++++++++++++----
>  9 files changed, 36 insertions(+), 25 deletions(-)

ACK drivers/net
