Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A2082C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 07:40:17 +1000 (EST)
Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=GB2312
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <867C679D-6CA3-4F02-9864-E7E8A62BD6BF@freescale.com>
Date: Thu, 27 Sep 2012 16:38:22 -0500
Message-Id: <AC1B086A-98FD-4C86-ACA7-2C59DDF5F68E@kernel.crashing.org>
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
 <CADRPPNQga4J26oDacT-fGMZiecE2KLsLh2DBEErtQ9_gJSwgpA@mail.gmail.com>,
 <587B44DE-F710-4A! F0-AB0B-A48FEEE29509@kernel.crashing.org>
 <867C679D-6CA3-4F02-9864-E7E8A62BD6BF@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 27, 2012, at 11:27 AM, Li Yang-R58472 wrote:

>=20
> =D4=DA Sep 28, 2012=A3=AC0:07=A3=AC"Kumar Gala" =
<galak@kernel.crashing.org> =D0=B4=B5=C0=A3=BA
>=20
>>>>> Hi Kumar,
>>>>> I have already sent the log.
>>>>> Do you have any comment on it?
>>>>>=20
>>>>> Thanks.
>>>>> - Hongtao.
>>>>>=20
>>>>=20
>>>> Hongtao,
>>>>=20
>>>> You mentioned:
>>>>=20
>>>>> I tested the re-parsing way by using setup_pci_atmu() when resume.
>>>>> And I found out that re-parsing will *change* outbound IO
>>>>> translation address regitster.
>>>>=20
>>>> What do the values look like in both ATMU registers and io_resource =
if you reparse?
>>>=20
>>> I think Hongtao mentioned in previous email as follows, the ATMU
>>> registers are inline with the io_resource address.
>>=20
>> I was under that the impression that was the normal boot case, not =
the values from after wakeup.
>=20
> It is for the normal boot.  But re-parse will use the io resource =
after pic scan to initialize atmu.  Instead, the original atmu is =
initialized use the io resource before the scan.
>=20
> Leo

I think I see, so isn't the mem resources also wrong?

Can we dump the following:

1. enable pr_debug() in pcibios_setup_phb_resources so we get "PHB: " =
prints
2. Can we dump hose->io_resource & hose->mem_resources[] right after =
wakeup?

I think I see what direction but would be useful to get a few more =
answers.

- k=
