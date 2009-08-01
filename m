Return-Path: <linasvepstas@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7A6AB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 Aug 2009 08:40:29 +1000 (EST)
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id 377F8DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Aug 2009 08:40:28 +1000 (EST)
Received: by yxe33 with SMTP id 33so4450696yxe.17
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Aug 2009 15:40:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87hbws3jvx.fsf@basil.nowhere.org>
References: <4A721FB1.4040903@us.ibm.com> <87hbws3jvx.fsf@basil.nowhere.org>
Date: Sat, 1 Aug 2009 17:40:27 -0500
Message-ID: <3ae3aa420908011540k10004997o130c42cec0ba911e@mail.gmail.com>
Subject: Re: [PATCH 1/3] Support for PCI Express reset type
From: Linas Vepstas <linasvepstas@gmail.com>
To: Andi Kleen <andi@firstfloor.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Richard Lary <rlary@us.ibm.com>, linux-pci@vger.kernel.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andi,

2009/7/31 Andi Kleen <andi@firstfloor.org>:
> Mike Mason <mmlnx@us.ibm.com> writes:
>>
>> These patches supersede the previously submitted patch that
>> implemented a fundamental reset bit field.
>>
>> Please review and let me know of any concerns.
>
> Any plans to implement that for x86 too? Right now it seems to be a PPC
> specific hack.

I've found the PCIE chipsepc somewhat daunting, but was under the
impression that much if not most of what was needed was specified
there.

See, for example:
    Documentation/PCI/pcieaer-howto.txt

which states:
|||   The PCI Express Advanced Error Reporting Driver Guide HOWTO
|||                T. Long Nguyen  <tom.l.nguyen@intel.com>
|||                Yanmin Zhang    <yanmin.zhang@intel.com>
|||                                07/29/2006
[..]
||| The PCI Express AER driver provides the infrastructure to support PCI
||| Express Advanced Error Reporting capability. The PCI Express AER
||| driver provides three basic functions:
|||
||| -       Gathers the comprehensive error information if errors occurred.
||| -       Reports error to the users.
||| -       Performs error recovery actions.

I presume the last bullet point  means that the AER code works and
actually does more or less the same thing as the PPC EEH code,
but in a more architecture-independent way, as it only assumes
that PCI AER is there (and is correctly implemented in the CPI chipset)
The AER code uses the same core infrastructure as the EEH code,
at the time, I did exchange emails w/ the above authors discussing
this stuff.

As to whether the x86 server vendors are actually selling something
with AER in it, and whether any of them are actually testing this stuff
is unclear.

FWIW IBM has pretty much no incentive to lobby other server vendors
to get on the ball ...as this is viewed as one of those things that lets
IBM charge premium prices for PPC hardware.

--linas
