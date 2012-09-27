Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 221A22C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 02:04:03 +1000 (EST)
Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CADRPPNQga4J26oDacT-fGMZiecE2KLsLh2DBEErtQ9_gJSwgpA@mail.gmail.com>
Date: Thu, 27 Sep 2012 11:04:01 -0500
Message-Id: <587B44DE-F710-4AF0-AB0B-A48FEEE29509@kernel.crashing.org>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>
 <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <8086D08B-62B7-4838-8DB6-0F6158DE581A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB4A6F@039-SN1MPN1-004.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F09432A5F@039-SN2MPN1-021.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01AB6AE7@039-SN1MPN1-004.039d.mgd.msft.net>
 <95B12FA1-EC53-4632-8DFB-64109668BA9C@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB8317@039-SN1MPN1-004.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01AC2B34@039-SN1MPN1-004.039d.mgd.msft.net>
 <30C76F52-4022-459D-8B84-876B1A572ABE@kernel.crashing.org>
 <CADRPPNQga4J26oDacT-fGMZiecE2KLsLh2DBEErtQ9_gJSwgpA@mail.gmail.com>
To: Li Yang <leoli@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Hi Kumar,
>>> I have already sent the log.
>>> Do you have any comment on it?
>>>=20
>>> Thanks.
>>> - Hongtao.
>>>=20
>>=20
>> Hongtao,
>>=20
>> You mentioned:
>>=20
>>> I tested the re-parsing way by using setup_pci_atmu() when resume.
>>> And I found out that re-parsing will *change* outbound IO
>>> translation address regitster.
>>=20
>> What do the values look like in both ATMU registers and io_resource =
if you reparse?
>=20
> I think Hongtao mentioned in previous email as follows, the ATMU
> registers are inline with the io_resource address.

I was under that the impression that was the normal boot case, not the =
values from after wakeup.

- k

>>> Since potar is set by out_be32(&pci->pow[j].potar, (hose-
>>> io_resource.start >> 12);
>>> I provide the result of hose->io_resource.start >> 12 as follows:
>>>=20
>>> pcie@ffe09000:
>>> before pci scan: io_resource.start >> 12: 0
>>> after pci scan : io_resource.start >> 12: ff7ed
>>>=20
>>> pcie@ffe0a000:
>>> before pci scan: io_resource.start >> 12: 0
>>> after pci scan : io_resource.start >> 12: ff7db
>>>=20
>>> pcie@ffe0b000:
>>> before pci scan: io_resource.start >> 12: 0
>>> after pci scan : io_resource.start >> 12: ff7c9
>>>=20
>>> Note that I tested on P1022DS.
