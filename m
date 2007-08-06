Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23646DDE48
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:33:51 +1000 (EST)
In-Reply-To: <20070801011900.GA31391@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
	<20070727020041.GC1561@localhost.localdomain>
	<ac8f78688ab3769444562b120866ca30@kernel.crashing.org>
	<20070801011900.GA31391@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5fe57365c1fdd591c68546f4cb9347ba@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTC 1.0.0 Release Coming?
Date: Mon, 6 Aug 2007 21:33:17 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Ok, figured out why.  When I push, then pop a quilt patch some of the
>>> files end up with their original contents, but changed timestamps.
>>> That altered stat information causes git-diff-index to give false
>>> indications of changed files, so setlocalversion adds the -dirty.
>>> Running git status, or gitool or various other things causes git to
>>> notice that the files aren't really changed, updates the index and
>>> then the version is generated correctly again.
>>>
>>> Not very robust though.
>>
>> Well you can't blame that on DTC's build system, nor on the
>> setlocalversion script, and not on Git either; it's a Quilt
>> problem...
>
> No, it's really not - touching the files on a pop is correct behaviour
> for quilt (that way it will correctly trigger a rebuild on make
> systems that aren't as flashy as Kbuild).

Yeah okay -- "it's a problem with how all these tools are used
together" :-)

> setlocalversion should be ensuring that the verison information is
> based on content, not stat info, which means it needs to do a git
> status or something that will remove the false positives before using
> git-diff-index to determine whether the tree is clean or not.

Yeah, that seems best.  Please fix this for the kernel version of
setlocalversion as well :-)


Segher
