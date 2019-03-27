Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576B7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 09:11:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDA62075D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 09:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QnhaTx/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA62075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tj122MdhzDqJh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 20:11:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="QnhaTx/D"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ThzD2kfvzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 20:10:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Thz81gkYz9v0Nj;
 Wed, 27 Mar 2019 10:09:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=QnhaTx/D; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yfez3_M8Qsc4; Wed, 27 Mar 2019 10:09:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Thz808zbz9v0Nh;
 Wed, 27 Mar 2019 10:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553677796; bh=dN/IPoee+Kpx4me7vuQTARhQxIrrdBpCPYa7yBnqxQc=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=QnhaTx/DHFwCZ4BuT23C1xCDIL944cgqpwtKSceAtHNCDOyvfrsMZrKhcz/zSdepB
 G3aLX93unwehEf+cdidGNTvT1SFuPpLJ3NAG9QKthibkp8PagrobLRbUfI0w9OARZy
 9+c5DEOsH7DM1N/LS+f/FMsSnXdu59ORc/HflZHA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1029B8B8FB;
 Wed, 27 Mar 2019 10:09:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qckCtBnsNJUk; Wed, 27 Mar 2019 10:09:56 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DFDD58B8EE;
 Wed, 27 Mar 2019 10:09:56 +0100 (CET)
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
 <d340ae4b-a009-0ef3-9621-da3e0a7684f5@c-s.fr>
 <20190326181914.GS3969@gate.crashing.org>
 <5f4aa4b2-1c44-70b9-c383-5d40aecd695c@c-s.fr>
 <20190326201231.GV3969@gate.crashing.org>
 <a8fcafac-415d-7537-4f3d-008279824fef@c-s.fr>
Message-ID: <5f059a1e-63f8-703f-fd0b-dceb0bb8f9a0@c-s.fr>
Date: Wed, 27 Mar 2019 10:09:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8fcafac-415d-7537-4f3d-008279824fef@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/03/2019 à 09:56, Christophe Leroy a écrit :
> 
> 
> Le 26/03/2019 à 21:12, Segher Boessenkool a écrit :
>> On Tue, Mar 26, 2019 at 08:28:58PM +0100, Christophe Leroy wrote:
>>>
>>>
>>> Le 26/03/2019 à 19:19, Segher Boessenkool a écrit :
>>>> On Tue, Mar 26, 2019 at 07:55:33AM +0000, Christophe Leroy wrote:
>>>>>     STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 
>>>>> 2**4
>>>>>           filesz 0x00000000 memsz 0x00000000 flags rwx
>>>>
>>>> You need to prevent this one somehow.  What object file forces this?
>>>
>>> mpc885_ads_defconfig
>>
>> No, which object file, ".o file".  Not defconfig :-)
>>
> 
> Ok, how to I know that ? Is it based on some file flags or some headers ?
> 
> Here is the list of headers in vmlinux.o, is there one that shouldn't 
> exist ?
> 
> 
> vmlinux.o:     file format elf32-powerpc
> 
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>    0 .text         003320c0  00000000  00000000  00001000  2**12
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    1 .head.text    00002340  00000000  00000000  003330c0  2**0
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    2 .init.text    00017cb8  00000000  00000000  00335400  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    3 .text.unlikely 00004154  00000000  00000000  0034d0b8  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    4 .ref.text     000013f0  00000000  00000000  0035120c  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    5 .softirqentry.text 00000258  00000000  00000000  003525fc  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    6 .sched.text   00003930  00000000  00000000  00352854  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    7 .cpuidle.text 0000007c  00000000  00000000  00356184  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    8 .meminit.text 00000584  00000000  00000000  00356200  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>    9 .exit.text    00000800  00000000  00000000  00356784  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>   10 .rodata       0001d7a7  00000000  00000000  00356f90  2**4
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   11 .init.rodata  00000790  00000000  00000000  00374738  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   12 .rodata.str1.4 00022329  00000000  00000000  00374ec8  2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>   13 __param       000003c0  00000000  00000000  003971f4  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   14 .note.Linux   00000018  00000000  00000000  003975b4  2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>   15 __ex_table    00000ca8  00000000  00000000  003975cc  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   16 __ftr_alt_97  00000008  00000000  00000000  00398274  2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>   17 __ftr_fixup   00000198  00000000  00000000  00398280  2**3
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   18 __reservedmem_of_table 000000c4  00000000  00000000  00398418  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   19 __irqchip_of_table_end 000000c4  00000000  00000000  003984dc  2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>   20 __modver      00000008  00000000  00000000  003985a0  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   21 __reservedmem_of_table_end 000000c4  00000000  00000000  003985a8  
> 2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>   22 .eh_frame     00134eb8  00000000  00000000  0039866c  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   23 .fixup        00000cc8  00000000  00000000  004cd524  2**0
>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>   24 .data         00013668  00000000  00000000  004cf000  2**12
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   25 __bug_table   00006ce4  00000000  00000000  004e2668  2**0
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   26 .data..read_mostly 00001ce8  00000000  00000000  004e9350  2**3
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   27 .init.data    0000244c  00000000  00000000  004eb038  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   28 .init.setup   0000039c  00000000  00000000  004ed484  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   29 .initcallrootfs.init 00000004  00000000  00000000  004ed820  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   30 .data..page_aligned 00003000  00000000  00000000  004ee000  2**12
>                    CONTENTS, ALLOC, LOAD, DATA
>   31 .initcall3.init 00000008  00000000  00000000  004f1000  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   32 .initcallearly.init 00000010  00000000  00000000  004f1008  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   33 .initcall6.init 00000120  00000000  00000000  004f1018  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   34 .initcall4.init 00000080  00000000  00000000  004f1138  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   35 .data.once    0000009e  00000000  00000000  004f11b8  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>   36 .initcall1.init 00000048  00000000  00000000  004f1258  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   37 .initcall7.init 00000030  00000000  00000000  004f12a0  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   38 .machine.desc 000000e0  00000000  00000000  004f12d0  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   39 .data..cacheline_aligned 00005000  00000000  00000000  004f13b0  2**4
>                    CONTENTS, ALLOC, LOAD, DATA
>   40 .data..ro_after_init 000004b8  00000000  00000000  004f63b0  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   41 .initcall2.init 00000018  00000000  00000000  004f6868  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   42 .initcall5.init 00000070  00000000  00000000  004f6880  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   43 .meminit.data 00000010  00000000  00000000  004f68f0  2**2
>                    CONTENTS, ALLOC, LOAD, DATA
>   44 .ref.data     00000578  00000000  00000000  004f6900  2**2
>                    CONTENTS, ALLOC, LOAD, DATA
>   45 .exitcall.exit 000000b0  00000000  00000000  004f6e78  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   46 .initcall0.init 0000000c  00000000  00000000  004f6f28  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   47 .con_initcall.init 00000004  00000000  00000000  004f6f34  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   48 .initcall7s.init 00000004  00000000  00000000  004f6f38  2**2
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   49 .data..shared_aligned 00000118  00000000  00000000  004f6f40  2**4
>                    CONTENTS, ALLOC, LOAD, DATA
>   50 .sdata        00000188  00000000  00000000  004f7058  2**3
>                    CONTENTS, ALLOC, LOAD, RELOC, DATA
>   51 .sbss         000002d4  00000000  00000000  004f71e0  2**3
>                    ALLOC
>   52 .bss          0001e728  00000000  00000000  004f71e0  2**4
>                    ALLOC
>   53 .stab         00000270  00000000  00000000  004f71e0  2**2
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   54 .stabstr      00000335  00000000  00000000  004f7450  2**0
>                    CONTENTS, READONLY, DEBUGGING
>   55 .comment      0000339c  00000000  00000000  004f7785  2**0
>                    CONTENTS, READONLY
>   56 .note.GNU-stack 00000000  00000000  00000000  004fab21  2**0
>                    CONTENTS, READONLY, CODE
>   57 .debug_aranges 000077e8  00000000  00000000  004fab28  2**3
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   58 .debug_info   030a43d8  00000000  00000000  00502310  2**0
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   59 .debug_abbrev 0018bdc0  00000000  00000000  035a66e8  2**0
>                    CONTENTS, READONLY, DEBUGGING
>   60 .debug_line   005d69b9  00000000  00000000  037324a8  2**0
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   61 .debug_frame  00134eb8  00000000  00000000  03d08e64  2**2
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   62 .debug_str    01b24fc1  00000000  00000000  03e3dd1c  2**0
>                    CONTENTS, READONLY, DEBUGGING
>   63 .debug_loc    00242597  00000000  00000000  05962cdd  2**0
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   64 .debug_ranges 001ea010  00000000  00000000  05ba5274  2**0
>                    CONTENTS, RELOC, READONLY, DEBUGGING
>   65 .gnu.attributes 00000012  00000000  00000000  05d8f284  2**0
>                    CONTENTS, READONLY
> 

Using readelf, I get the following output

[root@localhost linux-powerpc]# powerpc64-linux-readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0xc0000000
There are 3 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   LOAD           0x010000 0xc0000000 0x00000000 0x3f8ce4 0x417a08 RWE 
0x10000
   NOTE           0x3c3ca8 0xc03b3ca8 0x003b3ca8 0x0003c 0x0003c R   0x4
   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10

  Section to Segment mapping:
   Segment Sections...
    00     .head.text .text .rodata __param __modver __ex_table .notes 
.init.text .exit.text .init.data .init.setup .initcall.init 
.con_initcall.init __ftr_fixup .machine.desc .data .data..init_task 
.data..page_aligned .data..cacheline_aligned .data..read_mostly 
__bug_table .sbss .bss
    01     .notes
    02



Is it the section .note.GNU-stack which implies GNU_STACK program header 
? That section seems to be present in most .o files.

Christophe
