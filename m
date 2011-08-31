Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 433EBB6F83
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 13:01:57 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
Date: Wed, 31 Aug 2011 03:01:39 +0000
Message-ID: <4E5DA412.5020300@freescale.com>
References: <1314644999-16955-1-git-send-email-timur@freescale.com>
	<3F34FBCD-3F0B-4D59-A947-C16CC812B42E@freescale.com>
	<4E5DA1CC.1020808@freescale.com>
	<DBF3606B-8F59-4E5F-9B47-C3E0235665C4@freescale.com>
In-Reply-To: <DBF3606B-8F59-4E5F-9B47-C3E0235665C4@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Aug 30, 2011, at 9:51 PM, Tabi Timur-B04825 wrote:
>
>> Kumar Gala wrote:
>>> Do we really want the generic "fsl,fpga-cpld"&   "fsl,fpga-pixis"?  Thi=
s seems to vague.
>>
>> Yes, the PIXIS is generally register compatible across all boards.  Ther=
e
>> may be some minor differences, but the OCM driver can work with all PIXI=
S
>> boards that have an PIXIS.
>
> Is this true?  Don't we have pixis and ngpixis in u-boot?

I forgot about that.  Well, everything I said is true about the ngpixis,=20
so I guess I should use "ngpixis" instead of just "pixis" here.  I'll have=
=20
to check if the old pixis can be used this way.

>
>>> Also you need "pixis" on MPC8544DS, MPC8572DS, MPC8536DS.
>>
>> Ok.
>>
>>> Also fpga-cpld makes no sense if we keep this.  You are either a CPLD o=
r FPGA not both.
>>
>> Then I don't understand what the CPLD is.
>
> http://en.wikipedia.org/wiki/Complex_programmable_logic_device

Ok, I get it now.  Is there a name for the CPLD we use on these chips?=20
I'm having a hard time getting proper documentation on the CPLD.  York=20
expressed similar frustration.

Perhaps these should be called board-control devices.  How about

	fsl,boardcontrol-cpld
	fsl,boardcontrol-ngpixis
	fsl,boardcontrol-qixis


--=20
Timur Tabi
Linux kernel developer at Freescale=
