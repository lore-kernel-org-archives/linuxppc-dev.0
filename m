Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E551B7D94
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 07:17:48 +1000 (EST)
Subject: Re: [PATCH v5] powerpc: Add hibernation support for FSL BookE
	processors
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100517185652.GA11081@oksana.dev.rtsoft.ru>
Date: Mon, 17 May 2010 16:17:22 -0500
Message-Id: <2848DA81-7CF7-422D-B0C4-AF7778328DC9@kernel.crashing.org>
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com> <4BC77497.9070401@freescale.com>
	<20100416115643.GA3092@oksana.dev.rtsoft.ru>
	<4BC8883C.8050703@freescale.com>
	<20100416190319.GA4104@oksana.dev.rtsoft.ru>
	<4BF18715.8050201@freescale.com>
	<20100517185652.GA11081@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 17, 2010, at 1:56 PM, Anton Vorontsov wrote:

> This is started as swsusp_32.S modifications, but the amount of =
#ifdefs
> made the whole file horribly unreadable, so let's put the support into
> its own separate file.
>=20
> The code should be relatively easy to modify to support 44x BookEs as
> well, but since I don't have any 44x to test, let's confine the code =
to
> FSL BookE. (The only FSL-specific part so far is 'flush_dcache_L1'.)
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
>=20
> On Mon, May 17, 2010 at 01:12:37PM -0500, Scott Wood wrote:
>> On 04/16/2010 02:03 PM, Anton Vorontsov wrote:
>>> +	/* restore the MSR */
>>> +	lwz	r3,SL_MSR(r11)
>>> +
>>> +	/* Restore TB */
>>> +	li	r3,0
>>=20
>> Missing mtmsr?
>>=20
>> Otherwise ACK.
>=20
> Fixed, thanks!
>=20
> arch/powerpc/kernel/Makefile       |    8 +-
> arch/powerpc/kernel/swsusp_booke.S |  193 =
++++++++++++++++++++++++++++++++++++
> 2 files changed, 199 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/kernel/swsusp_booke.S

applied to next (fixed one white space issue).

- k=
