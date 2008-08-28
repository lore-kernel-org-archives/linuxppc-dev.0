Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 632DCDDF57
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 22:18:17 +1000 (EST)
Message-Id: <69759E45-CCB6-4D5C-B671-AD8930C8E566@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1219925555.7107.276.camel@pmac.infradead.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
Date: Thu, 28 Aug 2008 07:18:05 -0500
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<1219925555.7107.276.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 28, 2008, at 7:12 AM, David Woodhouse wrote:

> On Wed, 2008-08-13 at 11:27 +1000, Paul Mackerras wrote:
>> The following series of patches implement support for a relocatable
>> kernel by building it as a position-independent executable (PIE).
>> When the linker is given the -pie flag, it creates an executable that
>> contains dynamic relocations which can be used to relocate the image
>> at boot time for any desired base address.  This patch series adds a
>> CONFIG_RELOCATABLE config option for 64-bit which links the kernel
>> with -pie and arranges to process the relocations in early boot.
>>
>> With the first 4 patches applied, a relocatable kernel will still  
>> copy
>> itself down to real address 0.  The last patch changes things so that
>> a relocatable kernel will run wherever it was loaded.  This last  
>> patch
>> is pretty much just a proof of concept since it doesn't do anything  
>> to
>> ensure appropriate alignment of the base address (the base address
>> needs to be 16kB aligned).  We probably want to work out whether we
>> are a kdump kernel and run in-place if so, or copy down to 0 if not.
>
> Is this mature enough for us to consider putting it in Fedora? We'd
> _love_ to stop building a separate kdump kernel for ppc64...

Also, can we get this on ppc32 (head_32.S)?

- k
