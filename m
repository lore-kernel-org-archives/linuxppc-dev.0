Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1938DE063
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 08:49:09 +1100 (EST)
Message-Id: <F27CE1B6-E59B-458B-A98B-22D262EA1F00@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18418.4984.671485.346817@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 04/11 v2] [POWERPC] Remove and replace uses of
	PPC_MEMSTART with memstart_addr
Date: Tue, 1 Apr 2008 16:49:00 -0500
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-3-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-4-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-5-git-send-email-galak@kernel.crashing.org>
	<18418.4984.671485.346817@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2008, at 5:50 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> For the sub-arches that support relocatable interrupt vectors (book- 
>> e) its
>> reasonable to have memory start at a non-zero physical address.   
>> For those
>> cases use the variable memstart_addr instead of the #define  
>> PPC_MEMSTART
>> since the only uses of PPC_MEMSTART are for initialization and in the
>> future we can set memstart_addr at runtime to have a relocatable  
>> kernel.
>
> In those cases, is it still true that the kernel sits at the start of
> the usable memory, or might there be usable memory before _stext?
> In other words, is PAGE_OFFSET == KERNELBASE still true or not?

Both cases are possible.

Here are the four cases I see:
* Normal kernel (kernel at physical 0)
* kexec kernel (kernel at physical 32M, but still has access to memory  
from physical 0 to 32M)

* cAMP kernel (kernel at non-zero offset) [eg. 256M offset]
* kexec cAMP kernel (kernel at 256M+32M, but has access to 256M + size)

- k
