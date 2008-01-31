Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 9D5A9DDFF5
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 09:10:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 16:10:06 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03EE4A90@ismail.innsys.innovsys.com>
In-Reply-To: <47A24480.8060103@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
	<20080131204158.GV14201@localdomain>
	<47A235AD.9050107@freescale.com> <47A24480.8060103@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Nathan Lynch" <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Scott Wood wrote:
>> Nathan Lynch wrote:
>>> Is the crashing program multithreaded?  The first report had firefox
>>> triggering the oops.
>>=20
>> OK, I've got a test program that triggers it now.  I'll see if I can
>> figure out what's going on.
>=20
> The problem seems to be that update_mmu_cache() is called on a guard
> page with no access rights.=20
>=20
> Changing update_mmu_cache() to always call flush_dcache_icache_page()
> fixes it, though a better performing fix would probably be to add an
> exception table entry for the dcbst.

I can confirm that this seems to fix it.
