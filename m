Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 052F9B70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 23:23:59 +1000 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 1D523DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 23:23:56 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MMMGS-00074B-W5
	for linuxppc-dev@ozlabs.org; Thu, 02 Jul 2009 13:23:49 +0000
Received: from p4ff06b4a.dip.t-dialin.net ([79.240.107.74])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 13:23:48 +0000
Received: from dzu by p4ff06b4a.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 13:23:48 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
Date: Thu, 02 Jul 2009 15:23:36 +0200
Message-ID: <m2iqibp6av.fsf@ohwell.denx.de>
References: <4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
	<4A49249C.5080101@freescale.com>
	<97dd5fd20906291346s3ee60edbr1863c27280ae373c@mail.gmail.com>
	<4A492C1A.6020302@freescale.com>
	<97dd5fd20906300911k7b1e72banf61bcb9ff500787@mail.gmail.com>
	<97dd5fd20906301048o30354271haf603a9bae29b0fe@mail.gmail.com>
	<m21vp0vbx2.fsf@ohwell.denx.de>
	<20090701170436.GA502@b07421-ec1.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

> On Wed, Jul 01, 2009 at 02:13:29PM +0200, Detlev Zundel wrote:
>> Hi,
>> 
>> > As for my device tree, I reverted back to the original version with
>> > nothing filled in and just replaced 0xfa20xxxx with 0xf000xxxx as Gary
>> > suggested earlier.
>> 
>> Would it be a problem to also dynamically fixup IMMR in the device tree
>> from U-Boot?
>
> Yes.  It can appear in multiple places in the device tree (for exmaple,
> in things like the localbus and pci nodes where we have some IMMR
> registers but need ranges to point outside IMMR); this introduces more
> dependencies between u-boot and the input dtb than just getting the
> address right in the first place.

Ah, I see - the IMMR address is duplicated because the nodes you mention
are not children of "soc", so they cannot reference that parent address
space.

I guess re-arranging the hierarchy is not viable, but maybe we can
include this orthogonal parent-child relation.  For example, could a
"reg-parent" phandle solve this duplication?

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
