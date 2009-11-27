Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC3471007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 11:15:34 +1100 (EST)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4AE0F44D-CAD9-457C-9E5D-0279F28D70AF@kernel.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop>  <4B0E9C5F.50304@yahoo.es>
	<1259269265.18084.14.camel@pasglop>  <4B0EF54C.6020101@yahoo.es>
	<1259275057.2659.3.camel@pasglop>
	<4AE0F44D-CAD9-457C-9E5D-0279F28D70AF@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 11:15:27 +1100
Message-ID: <1259280927.2659.11.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-27 at 01:16 +0100, Segher Boessenkool wrote:
> 
> In all code I have done for the XFB, I map it like any other RAM and
> dcbst it after writing to it.  Maybe that is slower though, WIMG=0100
> might be better.  Dunno. 

Well, it depends also what you want to do with it. If you want to expose
it as a standard linux fbdev, it might break apps to expect them to use
dcbst... but it will make rmw cycles a lot faster and avoid wasting
memory with shadowfb.

It's going to mostly depend on what kind of HW accel we can get out of
it, if we get good enough accel we can probably got for I=1 like a
standard fb

Ben.
