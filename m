Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <4458C89B.9070505@yahoo.fr>
References: <43E23B4A.4020402@yahoo.fr>	
	<1138930958.4934.102.camel@localhost.localdomain>	
	<43E37DAC.4030606@yahoo.fr>
	<1139011975.8543.4.camel@localhost.localdomain>
	<4458C89B.9070505@yahoo.fr>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2BCBBD4E-35BE-4B9D-8FAB-797AF11D0D8C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Maple freezing on PCI Target-Abort
Date: Wed, 3 May 2006 17:40:37 +0200
To: jfaslist <jfaslist@yahoo.fr>
Cc: linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I still don't like the fact that a user process causing the  
> condition causes the system to enter the "mon" debugger rather than  
> being killed w/ SIGBUS/SIGSEGV. I guess the correct way for a fix  
> would be to write a Maple specific machine_check exception?

arch/powerpc/kernel/traps.c:machine_check_exception() does
check for user mode, and if so, throws SIGBUS.  It doesn't
do this if CONFIG_PPC64 though; that's a bug.

I'm not sure if the user-mode check should be done before
or after the machine-specific handler though.  Ben?


Segher
