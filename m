Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B89D8B72D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 00:23:14 +1000 (EST)
Subject: Re: Questions on Hugetlb for bookE and PHYS_64BIT
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <4FDB7AEC.2010102@freescale.com>
Date: Mon, 18 Jun 2012 09:22:59 -0500
Message-Id: <539824A8-EBAE-44AA-9818-9D4462F25DE2@kernel.crashing.org>
References: <CAE2rjsQpZzMaJQrNQexy7kUSVR6F09Nsuxi6ueKiLAh=Hj-G4Q@mail.gmail.com>
 <4FDB7AEC.2010102@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: telenn barz <telenn.barz@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 15, 2012, at 1:11 PM, Scott Wood wrote:

> On 06/15/2012 09:43 AM, telenn barz wrote:
>> Hi all,
>>=20
>> CONFIG_PHYS_64BIT enables kernel support for larger than 32-bit =
physical
>> addresses. Is it this configuration option we have to enable for the
>> support of 36-bit real memory (as are capable the Freescale e500v2 or
>> e500mc cores family) ?
>=20
> Yes.
>=20
>> The Hugetlb patch for BookE
>> =
(https://lists.ozlabs.org/pipermail/linuxppc-dev/2011-June/091315.html)
>> seems to be surbordinated to CONFIG_PHYS_64BIT. Is there any good =
reason
>> why it is not supported when CONFIG_PHYS_64BIT is disabled ?
>=20
> Because it would be extra work to support that configuration, and
> nobody's felt enough of a need for it to put in that work.

Most of the use-cases we had demanding hugetlb were *also* cases that =
had large amounts of memory, so this is the model we adopted.  Plus, we =
need some of the code from the 36-bit implementation, including the part =
that causes the lowest level of the page table to widen to 64 bits; =
additionally we did not measure much, if any, of a perf hit when =
enabling PHYS_64BIT.=20

Obviously, it could be made to work without it, although there are real =
code changes required. But unless you have a case where you have a =
noticeable performance drop from enabling CONFIG_PHYS_64BIT, it's not =
worth the effort.

-Becky

>=20
> -Scott
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
