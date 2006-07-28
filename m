Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90A9867B5E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2006 04:43:09 +1000 (EST)
In-Reply-To: <1154062599.21801.40.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][0/2] RTAS MSI
Date: Fri, 28 Jul 2006 20:43:02 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The RTAS patch skips the intel-centric MSI layer and uses
>> pci_enable/disable_msi() calls directly.  It does not correctly  
>> handle
>> multi-vector MSI either.
>
> Multi-vector MSIs aren't handled by the linux API anyway it seems (the
> doc says pci_enable_msi() only ever enables one MSI) so that's fine if
> you don't handle them :) The word on the street is that multivector  
> MSIs
> aren't useful, MSI-X are.

pci_enable_msi() should always enable exactly one or zero MSIs.  Maybe
Jake's patch doesn't follow this rule, and that is what he alluded to?


Segher
