Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88B5CDDF33
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 18:24:50 +1100 (EST)
Received: from LPSC0173W (lpscvpn9.in2p3.fr [134.158.47.245])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m317Oitq021702
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 09:24:45 +0200
Message-ID: <093b01c893c9$758b1d60$f52f9e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W><fa686aa40803260601j6e7f507fpe4d31c7c462fce5e@mail.gmail.com><066b01c890c0$17d9a800$ad289e86@LPSC0173W><068401c890d0$294e3e10$ad289e86@LPSC0173W>
	<20080328160614.6018DF68050@mail116-sin.bigfish.com>
Subject: Re: Patch: FW:Xilinx: BSP: Updated ML405 to
	matchhardwareusedfortesting
Date: Tue, 1 Apr 2008 09:24:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I should add that I've tried several things:
>> - compile the Xilinx kernel as indicated in my previous message.
>> - compile it with just the xparameters_ml*.h files added
>
> This should work.

It doesn't... Which makes me wonder if my problem may be with the boot
itself.
Once I have my zImage properly (?) compiled, I create an ACE file thus:
$ xmd -tcl genace.tcl -jprog -board ml405 -target ppc_hw -hw system.bit -elf 
zImage -ace Kernel26.ace
But then nothing happens when I boot with it.

[...]
>> .config:773:warning: trying to assign nonexistent symbol XILINX_ML40x
>
> Did you check out the head of the tree?

You mean svn head ? Yes.
Something escapes me here. I pull the complete kernel git tree from Xilinx 
and
when I menuconfig it, it removes the Xilinx additions ('nonexistent symbol 
')...

I'm not very knowledgeable of the kernel organization, so I don't know what
this means, but I imagine there's a relation between 'XILINX_ML40x=y' in
.config, Kconfig which holds the help text and the .h/.c driver files
themselves. How can I check that the whole package is sane ?

>> Two more things:
>>
>> $ make ARCH=ppc ml405_defconfig
>> cp  .config
>> cp: missing destination file operand after `.config'
>> Try `cp --help' for more information.
>> make: *** [ml405_defconfig] Error 1
>
> I'd suggest starting over with a fresh tree.
> 1) Copy the xparameters file, overwriting the appropriate xparameters
> file in the git tree.
> 2) make ARCH=ppc ml405_defconfig
> 3) make ARCH=ppc all

One detail, I'm not doing 'make' from the kernel directory, but from the
buildroot directory, this way I'm sure it's compiled with the appropriate
cross-compiler and environment. Maybe targets such as ml405_defconfig are 
not transmitted properly from one make to the other. Anyone who knows 
buildroot care to
comment on that ?

-- 
Guillaume Dargaud
http://www.gdargaud.net/
