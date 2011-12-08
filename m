Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 53C3A1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 00:32:25 +1100 (EST)
In-Reply-To: <20111208170450.22247a4b@kryten>
References: <20111208160227.2ef2d526@kryten>
 <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
 <5188.1323323649@neuling.org> <20111208170450.22247a4b@kryten>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <700CAC5A-AD1A-48BA-BD74-CB9FBB325484@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
Date: Thu, 8 Dec 2011 14:31:33 +0100
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 sukadev@linux.vnet.ibm.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I hate the idea of having a POWER7 FTR bit.  Every loon will (and has
>> tried to in the past) attach every POWER7 related thing to it, rather
>> than thinking about what the feature really is for.
>>
>> What about other processors which could also benefit from this copy
>> loop?  Turning on CPU_FTR_POWER7 for them is gonna look a bit silly.
>
> As we discussed online, we could call it CPU_FTR_VMX_COPY and start
> thinking about a better way to solve the CPU feature bit mess.

But then, most CPUs with VMX will not want that, because it is slower
code for them.  For things like copy loops it makes perfect sense to
have them tuned per CPU core.  For example, this code likes to use
unaligned stores over more complicated shift-and-combine stuff; that
works great on POWER7, but not on much else.

Maybe you should have the various kinds of loop ("source aligned, dest
unaligned, using unaligned stores, 64 bytes") as asm routines, have
some higher level code (which can be runtime patched) select which
to run.

> One idea would be to have a structure of function pointers for each
> CPU that gets runtime patched into the right places, similar to how we
> do some of the MMU fixups.

Sounds good to me :-)


Segher
