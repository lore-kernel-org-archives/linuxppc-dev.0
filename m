Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06793DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 02:38:18 +1000 (EST)
In-Reply-To: <46AA3FB8.8030301@nortel.com>
References: <46A8F22E.6010701@nortel.com>
	<fa686aa40707261255x23b06ff4y5fe1527f72c09c5b@mail.gmail.com>
	<46AA3FB8.8030301@nortel.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f0a0de83aafc3614ce0ed3d89c16e00b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: help with ppc sections?
Date: Tue, 31 Jul 2007 18:38:11 +0200
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The ppc64 version appends ',"a"' to the kprobes.text section line.  Is
> this needed here as well?  Could someone elaborate on exactly what its
> purpose is?

It's the (ELF) section attributes for the section.  If this
is executable code, it should be "ax"; if it's writable, it
should be "wa"; if it's not initialised, it should be "".

If the section name followed the normal naming conventions,
(newer) GCC could figure out the section attributes itself;
but then, ".text.kprobes" would imply executable, maybe the
section is really misnamed?  Or maybe you need the "ax"
flags :-)


Segher
