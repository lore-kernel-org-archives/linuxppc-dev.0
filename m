Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7FDFDB6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 13:01:33 +1000 (EST)
Message-ID: <4C9188DC.2040300@windriver.com>
Date: Thu, 16 Sep 2010 11:02:52 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<201009151007.50706.dargaud@lpsc.in2p3.fr>	<4C90835E.4050803@windriver.com>
	<201009151651.06816.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201009151651.06816.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guillaume Dargaud wrote:
>> Please use simpleImage.<your target dts name>.elf.
> 
> Great, that seems to be it...
> Except that nothing happens when I jump to 0x40000, no message from the 

0x40000? I recalled the entry point should be 0x400000 for simepleImage.*.elf.
So you have to change this on the file, arch/powerpc/boot/wrapper.

And also you should confirm if the upstream kernel support your board.

Additionally let's assume your bootloader create the map between the virtual
address and the physical address as 1:1. If so you want to execute from 0x40000.
 But the actual PC address should be the loader address + offset. You can get
this by readelf. Here if your loader address is zero, the offset will be pc
address, not 0x40000. You can dump your memory to check this.

Cheers
Tiejun

> kernel, nothing.
> I'm a bit stumped here as my old kernel worked fine.
