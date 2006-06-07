Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A828B67BB8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 08:55:53 +1000 (EST)
In-Reply-To: <20060606164646.GA3161@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<AEFF6654-C958-42F7-93CF-64103B015CB1@watson.ibm.com>
	<17534.30511.192632.558778@localhost.localdomain>
	<20060606164646.GA3161@w-mikek2.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD73D9E8-22EB-48E8-A05D-F1AEE7512590@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Collecting hypervisor call stats
Date: Thu, 8 Jun 2006 00:57:09 +0200
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	linuxppc-dev@ozlabs.org, Chris Yeoh <yeohc@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Can you explain the need for barrier(s) before and after the call  
> to the
> real routine?  It usually takes me a couple days of thought to  
> figure out
> exactly where these are needed. :)

The barriers make the timing ever so slightly more deterministic (not  
more
"accurate" though), because it has a "sync" insn in it.  The sc insn  
to do
the actual hypervisor call is a synchronisation point itself of  
course, as
probably some things around it are as well.  So just blast-em away,  
they do
slow down things, and you don't really care about a few cycles more  
or less
reported, hypervisor calls are not that fast.


Segher
