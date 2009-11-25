Return-Path: <albert_herranz@yahoo.es>
Received: from smtp140.mail.ukl.yahoo.com (smtp140.mail.ukl.yahoo.com
	[77.238.184.71]) by ozlabs.org (Postfix) with SMTP id B75151007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:06:32 +1100 (EST)
Message-ID: <4B0D6410.2080809@yahoo.es>
Date: Wed, 25 Nov 2009 18:06:24 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<3D2BF5CA-C4BE-4250-8EC9-7A8E767572E2@kernel.crashing.org>
	<4B0C2002.4050704@yahoo.es>
	<7129FD29-82CE-4731-90F2-0EA6775EF861@kernel.crashing.org>
In-Reply-To: <7129FD29-82CE-4731-90F2-0EA6775EF861@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> If GAMECUBE_COMMON is unacceptable, maybe GAMECUBE_LEGACY or
>> GAMECUBE_COMPAT?
> 
> Maybe it's best to write GAMECUBE || WII in the places that use it, then?
> 

That gets messy in conditionals, like for example:

 config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
-		&& !PPC_85xx && !PPC_86xx
+		&& !PPC_85xx && !PPC_86xx && !(GAMECUBE || WII)
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	select ARCH_SUPPORTS_MSI

I'd prefer to have a Kconfig option for that, if we can come up with an agreed name :)

Thanks,
Albert
