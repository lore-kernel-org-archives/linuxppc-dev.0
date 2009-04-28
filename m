Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC636DE034
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:26:56 +1000 (EST)
Message-Id: <C9F24544-55E1-4F51-B94C-B7FE60CADD7C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0904280808220.8094@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Fix up elf_read_implies_exec() usage
Date: Tue, 28 Apr 2009 08:26:48 -0500
References: <Pine.LNX.4.64.0904280808220.8094@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2009, at 8:08 AM, Kumar Gala wrote:

> On ppc64 we implemented elf_read_implies_exec() for 32-bit binaries
> because old toolchains had bugs with regards to marking PHDRs as
> executable that needed to be.  For some reason we didn't do this on
> ppc32 builds.  This hadn't been an issue until recent changes to I$/D$
> handling that impacted the per-page exec handling on embedded PPC.
>
> Additionally we believe if a toolchain supported PT_GNU_STACK that it
> sets the proper PHDR permissions so we only have  
> elf_read_implies_exec()
> true if we don't see PT_GNU_STACK set.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>
> Paul, please pick this up for 2.6.30 and send onto linus.
>
> - k

oops.. didn't see you grabbed the old one already.  I'll send a new  
patch based on it to switch to testing against EXSTACK_DEFAULT

- k
