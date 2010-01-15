Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16E9CB7C9C
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 06:41:02 +1100 (EST)
Date: Fri, 15 Jan 2010 20:23:49 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Kexec support for FSL-BookE, take two
Message-ID: <20100115192349.GA17823@Chamillionaire.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<80DDCCCD-D62C-4A66-AA8B-E0937266AF55@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <80DDCCCD-D62C-4A66-AA8B-E0937266AF55@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kumar Gala | 2010-01-15 11:53:13 [-0600]:

>On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:
>
>> This is take two :)
>> SMP support did not work in the first one and due to the lack of a working
>> SMP machine it is still absent. I took the e500v1 problem into account and
>> the result is that I now use multiple 256MiB mappings.
>> The final mapping covers the first 2GiB so the part of the highmem should
>> be also covered and not just kernel memory.
>> 
>> The first three patches prepare the entry code to work outside of the
>> first page. Patch 4 simply moves code and finally patch 5 implements the
>> kexec functionality.
>
>What do you think we need for SMP support? I'm happy to test out on SMP HW (8572)
Depends on how we want to do it :)
X86 for instance disables all "other" CPUs in machine_shutdown().
Therefore during machine_kexec() they are off and are bootstraped again
during system boot.
PPC64 doesn't do this that way. They call smp_call_function() witch puts
the CPU into real mode and let them spin in a "save" state until they
get released them from this state.

If we are able to disable the CPU and bootstrap it from scratch than I
guess we could do the way x86 does it.
If the CPU keeps the TLB/MMU data after reactivated (what I assume) than we
have to do the same thing that ppc64 does:
- let the other CPU have the also the identical mapping
- spin in a save state in kernel, then purgatory. I guess I should
  revisit ppc64 code for details :)
- update the device tree so kernel can kick the other CPU during boot.

>
>- k

Sebastian
