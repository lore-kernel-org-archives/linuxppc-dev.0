Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 26654B71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 06:33:41 +1100 (EST)
Date: Thu, 18 Nov 2010 11:34:05 -0800 (PST)
Message-Id: <20101118.113405.116386129.davem@davemloft.net>
To: mlcreech@gmail.com
Subject: Re: Gianfar TCP checksumming broken in 2.6.35+
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTi=fZnj94761L_=1DpPAErVG8EHESObtd+d5xJfK@mail.gmail.com>
References: <AANLkTi=-ZAL-to4qZ0vA20L589fMQm89E9mH9WWOvX0c@mail.gmail.com>
	<20101118.090615.71123752.davem@davemloft.net>
	<AANLkTi=fZnj94761L_=1DpPAErVG8EHESObtd+d5xJfK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew L. Creech" <mlcreech@gmail.com>
Date: Thu, 18 Nov 2010 14:31:46 -0500

> On Thu, Nov 18, 2010 at 12:06 PM, David Miller <davem@davemloft.net> =
wrote:
>>
>> Can someone please follow up Matthew to get this bug resolved? =A0It=
 has
>> been sitting around for a long time.
>>
>> I suspect the gianfar driver, for these chip revisions, will need to=

>> do a software checksum when the offset matches the criteria mentione=
d
>> in the errata above.
>>
> =

> I added a patch for this which fixes our affected systems; however, I=

> don't know if this is a good way to perform checksum offloading, I
> just kind of dug around until I found a function that seemed like it
> worked.  :)  Patch against 2.6.36 is below for reference.

It looks fine except I would limit the software checksum to the
exact conditions listed in the errate.

Otherwise this is going to hurt performance and cpu utilization
quite a bit.
