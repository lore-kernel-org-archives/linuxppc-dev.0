Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 454A3B7DB8
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 04:04:03 +1000 (EST)
Subject: Re: [PATCH v4] powerpc: Add hibernation support for FSL BookE
	processors
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100416190319.GA4104@oksana.dev.rtsoft.ru>
Date: Mon, 17 May 2010 13:03:54 -0500
Message-Id: <C7E43B79-6CAB-493B-BB6B-770C1863EACB@kernel.crashing.org>
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com> <4BC77497.9070401@freescale.com>
	<20100416115643.GA3092@oksana.dev.rtsoft.ru>
	<4BC8883C.8050703@freescale.com>
	<20100416190319.GA4104@oksana.dev.rtsoft.ru>
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Anton Vorontsov <avorontsov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 16, 2010, at 2:03 PM, Anton Vorontsov wrote:

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
> ---
>=20
> On Fri, Apr 16, 2010 at 10:54:36AM -0500, Scott Wood wrote:
>> Anton Vorontsov wrote:
>>> +	/* Invalidate TLB0 & TLB1 */
>>> +	li	r6,0x04
>>> +	tlbivax 0,r6
>>> +	TLBSYNC
>>> +	li	r6,0x0c
>>> +	tlbivax 0,r6
>>> +	TLBSYNC
>>=20
>> Is this needed?  Shouldn't the boot process have already given us a
>> sane TLB?
>=20
> Thanks for catching, it seems that it's just a left over from
> some debugging code and not actually needed. ..that reminded me
> the time I spent inserting BookE specific code into swsusp_32.S,
> and then debugging all that #ifdef mess...
>=20
> This is tested on e500v2.
>=20
> arch/powerpc/kernel/Makefile       |    8 +-
> arch/powerpc/kernel/swsusp_booke.S |  192 =
++++++++++++++++++++++++++++++++++++
> 2 files changed, 198 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/kernel/swsusp_booke.S

Scott, you ok (ACK) this version or still need tweaks?

- k=
