Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A817DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 14:17:43 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: MSR_SPE - being turned off... 
In-reply-to: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com> 
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
Date: Tue, 05 May 2009 14:17:42 +1000
Message-ID: <23583.1241497062@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I have both a MPC8548 SBC and MPC8572 system that are running different
> flavors of the same Linux - 2.6.23.
> 
> I explicitly am turning it on very early on. 

Where are you turning this on?  In the appication?

> Later, I have an application that is compiled with SPE instructions
> (e.g.: evstdd) , and there is where the problems happen. 

What is the problem?

> If I explicitly make sure there are NO SPE instructions in the
> application, nothing bad happens!
> 
> I am polling the MSR - and it seems the SPE is turned OFF?

You are polling MSR in your application?

Anyway, this is expected.  We do lazy restore of these registers after a
context switch.  So the SPE bit in the MSR may not be set if no SPE
instructions have run since the last context switch.

> What have I done wrong and/or has there been fixes in later kernels that
> I should be aware of that might help this issue?

I'm not clear what the problem is.  You've just said "problems happen"
when you include SPE instructions.  

Are you getting a SIGILL or some other signal?  Is your program
terminating.  Can you get a GDB back-trace or dump of which instruction
is causing the "problem".

Mikey
