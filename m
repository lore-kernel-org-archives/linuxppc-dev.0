Return-Path: <edmar@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 282A9B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 05:32:18 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6E03DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 05:32:16 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n69JVtKo013095
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2009 12:32:06 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n69JVsfT024949
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2009 14:31:54 -0500 (CDT)
Message-ID: <4A5645A9.3080003@freescale.com>
Date: Thu, 09 Jul 2009 14:31:53 -0500
From: Edmar Wienskoski-RA8797 <edmar@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: binutils 2.19 issue with kernel link
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
	<4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
In-Reply-To: <4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Alan Modra <amodra@bigpond.net.au>, bug-binutils@gnu.org
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
> On Jul 8, 2009, at 11:40 PM, Alan Modra wrote:
>
>> On Wed, Jul 08, 2009 at 10:52:59PM -0500, Kumar Gala wrote:
>>> To further verify this if I switch the -me500 to -mspe and build things
>>> seem to be ok.  This further points at some APU section related bug.
>>
>> Like omitting .PPC.EMB.apuinfo from your kernel link script?  See the
>> ld info doc on orphan sections.
>
> Ok, not terribly enlightening, but why would .PPC.EMB.apuinfo sections 
> be different than something like .debug sections which we also dont 
> list in the linker script.
>
> - k
>
Alan,

I understand your arguments, but there is something inconsistent about this.
If I change the script to be:
        _end3 = . ;
        . = _end3;
        . = ALIGN(PAGE_SIZE);
        _end = . ;
        PROVIDE32 (end = .);
}
The result is corrected:
c067f678 A _end3
c0680000 A _end

Why the apuinfo section with zero VMA sometimes interfere with "." and 
sometimes not ?

Edmar
