Return-Path: <amodra@bigpond.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0A05BB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 10:05:05 +1000 (EST)
Received: from nskntmtas04p.mx.bigpond.com (nskntmtas04p.mx.bigpond.com
	[61.9.168.146]) by ozlabs.org (Postfix) with ESMTP id B4527DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 10:05:04 +1000 (EST)
Date: Sat, 11 Jul 2009 09:35:03 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: binutils 2.19 issue with kernel link
Message-ID: <20090711000503.GO3181@bubble.grove.modra.org>
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
	<4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
	<4A5645A9.3080003@freescale.com>
	<20090710041536.GE3181@bubble.grove.modra.org>
	<D4C31507-B4F9-4979-A6E1-7971242D644B@kernel.crashing.org>
	<4F69F333-8BCA-4BB8-A5C1-4B25EA5D1287@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F69F333-8BCA-4BB8-A5C1-4B25EA5D1287@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 10, 2009 at 10:27:26AM -0500, Kumar Gala wrote:
> binutils-2.19		_end is what we expect
> binutils-2.19.1		_end is what we expect
> binutils-2.19.50.0.1	_end is what we expect
> binutils-2.19.51.0.1	_end is 00001000
>
> From the release notes:
>
> binutils-2.19.50.0.1 is based on CVS binutils 2008 1007
> binutils-2.19.51.0.1 is based on CVS binutils 2009 0106

Yes, I already have good reason to suspect this patch

2008-10-22  Alan Modra  <amodra@bigpond.net.au>

	* ldlang.c (lang_output_section_find_by_flags): Handle non-alloc
	sections.
	* emultempl/elf32.em (enum orphan_save_index): Add orphan_nonalloc.
	(hold): Likewise.
	(gld${EMULATION_NAME}_place_orphan): Handle non-alloc orphans.

causes the change in linker behaviour.  Did you try the patch I posted?

-- 
Alan Modra
Australia Development Lab, IBM
