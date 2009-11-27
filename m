Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 251DE1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 11:09:13 +1100 (EST)
In-Reply-To: <1259275057.2659.3.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop> <4B0E9C5F.50304@yahoo.es>
	<1259269265.18084.14.camel@pasglop> <4B0EF54C.6020101@yahoo.es>
	<1259275057.2659.3.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4AE0F44D-CAD9-457C-9E5D-0279F28D70AF@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
Date: Fri, 27 Nov 2009 01:16:09 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Yup. The idea is to map the first 16MB of MEM1 with a BAT.
>> Mapping the whole 24MB with BATs may not be possible because we  
>> want the framebuffer
>> in MEM1 for performance reasons.
>
> How big is the fb ?

A bit more than a megabyte, something like that.

> We have plenty of BATs on these things... so one 16M
> for the low mem and one 64M for the "high" mem, that leaves something
> like 6 to manage as much as possible up to the fb :-)

The CXe in the gamecube has only four BATs though.

In all code I have done for the XFB, I map it like any other RAM and
dcbst it after writing to it.  Maybe that is slower though, WIMG=0100
might be better.  Dunno.


Segher
