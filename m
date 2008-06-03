Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F556DE7D3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 00:43:05 +1000 (EST)
Message-Id: <F0BE858D-DA3B-4BBC-9527-F88DE9D23D54@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080603091858.0b50ef02@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Kprobes for book-e
Date: Tue, 3 Jun 2008 09:37:49 -0500
References: <7B7EF7F090B9804A830ACC82F2CDE95D2609E8@insardxms01.ap.sony.com>
	<20080603091858.0b50ef02@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "Sulibhavi,
	Madhvesh" <madhvesh.s@ap.sony.com>, rsmadhvesh@vsnl.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2008, at 9:18 AM, Josh Boyer wrote:

> On Tue, 3 Jun 2008 19:40:55 +0530
> "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com> wrote:
>
>> Josh Boyer wrote on Tuesday, June 03, 2008 5:22 PM
>>> What build issues?  Ebony should build fine for 2.6.26-rc3, unless
>>> you're trying to apply this patchset to it without the other
>>> patches it
>>> requires.
>>
>> I am trying without kprobes patches. I get build error
>> as below
>>
>> --------------------------------------------------------------
>> BFD: ./vmlinux.strip.28275: section .bss lma 0xc034f000 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section `.text' can't be allocated in
>> segment 0
>> /usr/local/powerpc-linux/bin/powerpc-linux-objcopy:
>> ./vmlinux.strip.28275: Bad value
>> BFD: ./vmlinux.strip.28275: section .text lma 0xc0000000 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .ref.text lma 0xc024e000 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .devinit.text lma 0xc024f860
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .devexit.text lma 0xc0253624
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .rodata lma 0xc0254000 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .pci_fixup lma 0xc02ebcc8  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section __ksymtab lma 0xc02ec280 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section __ksymtab_gpl lma 0xc02f0c58
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section __kcrctab lma 0xc02f2620 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section __kcrctab_gpl lma 0xc02f4b0c
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section __ksymtab_strings lma 0xc02f57f0
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section __param lma 0xc0302d74 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section __ex_table lma 0xc0304000  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section __bug_table lma 0xc0305780  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .init.text lma 0xc0309000  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .exit.text lma 0xc0321010  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .init.data lma 0xc0321bd4  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .init.setup lma 0xc03253e0  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .initcall.init lma 0xc032568c
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .con_initcall.init lma 0xc03258c4
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section __ftr_fixup lma 0xc03258d0  
>> overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .machine.desc lma 0xc0326000
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .data lma 0xc0327000 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section .data.init_task lma 0xc0348000
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .data.page_aligned lma 0xc034a000
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .data.cacheline_aligned lma
>> 0xc034d000 overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .data.read_mostly lma 0xc034d100
>> overlaps previous sections
>> BFD: ./vmlinux.strip.28275: section .bss lma 0xc034f000 overlaps
>> previous sections
>> BFD: ./vmlinux.strip.28275: section `.text' can't be allocated in
>> segment 0
>> /usr/local/powerpc-linux/bin/powerpc-linux-objcopy:
>> ./vmlinux.strip.28275: Bad value
>> make[1]: *** [arch/powerpc/boot/treeImage.ebony] Error 1
>> rm arch/powerpc/boot/ebony.dtb
>> make: *** [zImage] Error 2
>
> Um, weird.  What version of binutils and gcc are you using?
>
> I've heard of problems with binutils 2.17, but I have no idea why that
> would be.

This looks like the binutils problem that cell was having and I  
believe Alan Modra fixed:

http://sourceware.org/ml/binutils/2008-05/msg00008.html

- k
>
>
> josh
