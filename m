Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A917F1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:50:42 +1100 (EST)
Message-ID: <4EBC00D2.2030208@freescale.com>
Date: Thu, 10 Nov 2011 10:50:26 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Subject: Re: [RFC PATCH 02/17] powerpc: Split up PHYS_64BIT config option
 to fix "select" issues
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-3-git-send-email-Kyle.D.Moffett@boeing.com>
 <4EBBD9DF.6080100@freescale.com>
 <501ACA94-491F-43A7-9DCF-485BEE824DD5@boeing.com>
In-Reply-To: <501ACA94-491F-43A7-9DCF-485BEE824DD5@boeing.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moffett, Kyle D wrote:

> Did you look at the existing code?  It's already that complicated:
> 
> config ARCH_PHYS_ADDR_T_64BIT
> 	def_bool PPC64 || PHYS_64BIT

I never understood why we have PHYS_64BIT and ARCH_PHYS_ADDR_T_64BIT, since they mean the same thing.  

> config ARCH_DMA_ADDR_T_64BIT
> 	def_bool ARCH_PHYS_ADDR_T_64BIT
> 
> config {P1022_DS,P2041_RDB,P3041_DS,P3060_QDS,P4080_DS,P5020_DS}
> 	select PHYS_64BIT

I posted a patch to remove the P1022_DS version of this.  I'm in favor of removing it from the other boards and letting the defconfig define it, but Kumar nak'd that idea.

> config PTE_64BIT
> 	bool
> 	depends on 44x || E500 || PPC_86xx
> 	default y if PHYS_64BIT

I think this one is about how our TLB registers look, and it's not related to anything else.

> Even worse, PHYS_64BIT is not set on 64-bit processors, but there is
> a lot of driver code that seems to assume PHYS_64BIT indicates the
> size of "phys_addr_t".

There's a Kconfig option somewhere that takes care of this.

> The big issue is that the Kconfig docs are very clear that "select"
> should not be used on user-visible options (AKA: PHYS_64BIT), and yet
> half the PPC_85xx boards have this tidbit:
> 	select PHYS_64BIT # The DTS has 36-bit addresses

I'm not sure that Kconfig rule is enforceable.  We use 'select' all the time to make sure that our boards enable the options that need to be enabled.  I'd rather see this:

config X
	select A

config Y
	select A

config Z
	select A

than this:

config A
	default y if X | Y | Z

The former is more maintainable and does not allow the option of disabling "A" if someone wants "X".

> I'm totally OK with removing that from all those boards, but to preserve
> the existing behavior (also used by the entire 44x platform) I added the
> new config symbol PHYS_64BIT_DT_REQUIRED, which is used to control
> whether or not the "PHYS_64BIT" option is even visible to the user.
> 
> I originally called it "PHYS_64BIT_REQUIRED", but since all of the
> board comments talked about 36-bit DTS addresses, I added the _DT_.

They're really 64-bit DTS addresses.  The 36 bit is just a hardware quirk of our SOCs.  From the kernel's perspective, there's no difference between 36-bit and 64-bit physical address.

>> There are only two reasons to create a 32-bit kernel:
>>
>> 1) A small performance improvement on systems with 2GB or less.
>> 2) Some SOC devices only support 32-bit physical addresses, so the
>> easiest way to ensure a compatible address is to prohibit memory above
>> 4GB.
> 
> If this is true, then why does PHYS_64BIT have that big ugly list of
> dependencies right now? 

Because Kumar doesn't want to allow 32-bit kernels on our high-end parts.  Like I said, I'm not a fan of that decision.

> I don't know about the other platforms well
> enough to tell what would break by enabling PHYS_64BIT, but I assume
> that something in the past caused that dependency list.

It's just an arbitrary decision.  We don't ship 32-bit DTs for the P4080-class parts, and we don't have a U-Boot configuration option for building a 32-bit compatible U-Boot.

-- 
Timur Tabi
Linux kernel developer at Freescale
