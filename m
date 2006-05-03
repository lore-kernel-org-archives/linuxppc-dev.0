Return-Path: <benh@kernel.crashing.org>
Subject: Re: Maple freezing on PCI Target-Abort
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jfaslist <jfaslist@yahoo.fr>
In-Reply-To: <4458C89B.9070505@yahoo.fr>
References: <43E23B4A.4020402@yahoo.fr>
	<1138930958.4934.102.camel@localhost.localdomain>
	<43E37DAC.4030606@yahoo.fr>
	<1139011975.8543.4.camel@localhost.localdomain>
	<4458C89B.9070505@yahoo.fr>
Content-Type: text/plain
Date: Thu, 04 May 2006 09:05:55 +1000
Message-Id: <1146697555.6652.85.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Setting the CPC925 according to item 3, fixes the problem. I give this 
> for the record, since the fix should be in PIBS, I think.
> I still don't like the fact that a user process causing the condition 
> causes the system to enter the "mon" debugger rather than being killed 
> w/ SIGBUS/SIGSEGV. I guess the correct way for a fix would be to write a 
> Maple specific machine_check exception?

Wasn't that fixed ? The current kernel will send a SIGBUS to userland.
The problem however is that in some cases, MC can be asynchronous in
which case I suppose it's possible that userland triggers a condition
that will cause a machine check later on in kernel mode. In any way,
userland direct mapping of MMIO is a root only facility...

Ben.
