Return-Path: <xenidis@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62849B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 07:08:57 +1000 (EST)
Received: by gyd8 with SMTP id 8so930687gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 14:08:53 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH] powerpc: Fix xmon for systems without MSR[RI]
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <4E5D272B.6000403@freescale.com>
Date: Wed, 31 Aug 2011 16:08:48 -0500
Message-Id: <372EB5CE-5331-4B30-973F-87005D4402CF@pobox.com>
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
	<1314684670.2488.82.camel@pasglop> <4E5D272B.6000403@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 30, 2011, at 1:08 PM, Scott Wood wrote:

> On 08/30/2011 01:11 AM, Benjamin Herrenschmidt wrote:
>> On Mon, 2011-08-08 at 16:25 -0500, Jimi Xenidis wrote:
>>> From: David Gibson <dwg@au1.ibm.com>
>>>=20
>>> Based on patch by David Gibson <dwg@au1.ibm.com>
>>>=20
>>> xmon has a longstanding bug on systems which are SMP-capable but =
lack
>>> the MSR[RI] bit.  In these cases, xmon invoked by IPI on secondary
>>> CPUs will not properly keep quiet, but will print stuff, thereby
>>> garbling the primary xmon's output.  This patch fixes it, by =
ignoring
>>> the RI bit if the processor does not support it.
>>>=20
>>> There's already a version of this for 4xx upstream, which we'll need
>>> to extend to other RI-lacking CPUs at some point.  For now this adds
>>> BookE processors to the mix.
>>=20
>> Don't freescale one have RI ?
>=20
> e500mc does.

hmm, according to the ISA, MSR[RI] is only defined for Book3s and is not =
defined for Book3e
Should we scope it to just book3e?
-jx

>=20
> e500v2 doesn't -- if a machine check happens while MSR[ME]=3D0, it =
causes
> a checkstop.
>=20
> -Scott
>=20
