Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02199B7D15
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Apr 2010 22:19:41 +1000 (EST)
Subject: Re: [PATCH 1/4] fsl_msi: fix the conflict of virt_msir's chip_data
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4BCBE133.3010407@freescale.com>
Date: Mon, 19 Apr 2010 07:19:25 -0500
Message-Id: <2628E3BC-6FC4-4D84-A228-03C6D955EB4F@kernel.crashing.org>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271644834.14835.40.camel@concordia>
	<4BCBE133.3010407@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 18, 2010, at 11:50 PM, Li Yang wrote:

> On 4/19/2010 10:40 AM, Michael Ellerman wrote:
>> On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
>>  =20
>>> From: Zhao Chenhui<b26998@freescale.com>
>>>=20
>>> In fsl_of_msi_probe(), the virt_msir's chip_data have been stored
>>> the pointer to struct mpic. We add a struct fsl_msi_cascade_data
>>> to store the pointer to struct fsl_msi and msir_index.  Otherwise,
>>> the pointer to struct mpic will be over-written, and will cause
>>> problem when calling eoi() of the irq.
>>>    =20
>> I don't quite understand. Do you mean someone was overwriting
>> handler_data somewhere?
>>  =20
>=20
> The patch at http://patchwork.ozlabs.org/patch/48794/ was overwriting =
the chip_data.  We move the newly added pointer to fsl_msi structure to =
the handler data.

Let's fix that patch.

- k=
