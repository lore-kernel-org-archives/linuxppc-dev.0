Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 908B2679F7
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 01:46:00 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k3KG16fa007119
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 09:01:06 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k3KFv2MN023999
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 10:57:02 -0500 (CDT)
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <1145383451.20176.9.camel@localhost.localdomain>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
	<2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
	<1144938844.7777.16.camel@localhost.localdomain>
	<1145378886.5314.57.camel@cashmere.sps.mot.com>
	<1145383451.20176.9.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1145547747.5314.126.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 20 Apr 2006 10:42:28 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-04-18 at 13:04, Michael Ellerman wrote:

> > OK, I'm back to reading the list and beginning to catch
> > up some here...
> > 
> > Let me see if I understand the consensus and direction:
> > 
> >     1) DTC should NOT reserve its own blob space in the
> >        memory map, as it does for generated ASM code now,

> > In all of this, I'm on deck for step 1) above.

I have updated the DTC to have several bug fixes:

    - asm_emit_cell() little endian bug fix
    - use two .long and not .quad directives
    - Eliminate emitting memreserve for blob in ASM output

These updates are available here:

    www.jdl.com/git_repos
and
    git://ozlabs.org/srv/projects/dtc/dtc.git

Please verify and let me know of any problems!

> Nice summary :)

Thanks.

> I'm up for 3a, we should make redundant/overlapping reserves "harmless",
> by which I mean "not an error", but there should definitely be a warning
> in the dmesg - as it will _usually_ indicate a bug.

Please feel free to patch these into existence as needed! :-)

Thanks,
jdl
