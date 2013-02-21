Return-Path: <phileas-fogg@mail.ru>
Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [94.100.177.98])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DED02C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 07:45:06 +1100 (EST)
Message-ID: <5126955B.9070808@mail.ru>
Date: Thu, 21 Feb 2013 22:44:59 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop>
In-Reply-To: <1361478942.4676.53.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2013-02-21 at 21:38 +0100, Phileas Fogg wrote:
>> The new 8 bytes at offset 0x90 in dt.dump.hex look suspicously like
>> the kernel virtual address: 0xc00000000001a4a0.
>
> It does indeed. What does that address correspond to in the kernel
> text ? Can you disassemble around it with "objdump -D vmlinux" ?
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Here.
I used OpenWRT ELF for testing and it's stripped.
Then i compiled Linux 3.8 myself and didn't strip it.
Addresses are different in both cases but the code is the same and
it is kexec code :)


Stripped OpenWRT image:
------------------------

c00000000001a474:       48 00 00 05     bl      0xc00000000001a478
c00000000001a478:       7c a8 02 a6     mflr    r5
c00000000001a47c:       38 a5 00 1c     addi    r5,r5,28
c00000000001a480:       7c 21 0b 78     mr      r1,r1
c00000000001a484:       80 85 00 00     lwz     r4,0(r5)
c00000000001a488:       2c 04 00 00     cmpwi   r4,0
c00000000001a48c:       40 82 00 62     bnea-   0x60
c00000000001a490:       4b ff ff f0     b       0xc00000000001a480
c00000000001a494:       00 00 00 00     .long 0x0
c00000000001a498:       a0 6d 00 48     lhz     r3,72(r13)
c00000000001a49c:       48 00 00 11     bl      0xc00000000001a4ac
c00000000001a4a0:       38 80 00 02     li      r4,2              <-------- !!!
c00000000001a4a4:       98 8d 00 4b     stb     r4,75(r13)
c00000000001a4a8:       4b ff ff cc     b       0xc00000000001a474
c00000000001a4ac:       39 20 00 02     li      r9,2
c00000000001a4b0:       39 40 00 30     li      r10,48
c00000000001a4b4:       7d 68 02 a6     mflr    r11
c00000000001a4b8:       7d 80 00 a6     mfmsr   r12
c00000000001a4bc:       7d 89 48 78     andc    r9,r12,r9
c00000000001a4c0:       7d 8a 50 78     andc    r10,r12,r10
c00000000001a4c4:       7d 21 01 64     mtmsrd  r9,1



Unstripped Linux 3.8 kernel:
-----------------------------


c00000000001c02c <.kexec_wait>:
c00000000001c02c:       48 00 00 05     bl      c00000000001c030 <.kexec_wait+0x4>
c00000000001c030:       7c a8 02 a6     mflr    r5
c00000000001c034:       38 a5 00 1c     addi    r5,r5,28
c00000000001c038:       7c 21 0b 78     mr      r1,r1
c00000000001c03c:       80 85 00 00     lwz     r4,0(r5)
c00000000001c040:       2c 04 00 00     cmpwi   r4,0
c00000000001c044:       40 82 00 62     bnea-   60 <reloc_start+0x60>
c00000000001c048:       4b ff ff f0     b       c00000000001c038 <.kexec_wait+0xc>

c00000000001c04c <kexec_flag>:
c00000000001c04c:       00 00 00 00     .long 0x0

c00000000001c050 <.kexec_smp_wait>:
c00000000001c050:       a0 6d 00 48     lhz     r3,72(r13)
c00000000001c054:       48 00 00 11     bl      c00000000001c064 <real_mode>
c00000000001c058:       38 80 00 02     li      r4,2        <---------- !!!
c00000000001c05c:       98 8d 00 4b     stb     r4,75(r13)
c00000000001c060:       4b ff ff cc     b       c00000000001c02c <.kexec_wait>

c00000000001c064 <real_mode>:
c00000000001c064:       39 20 00 02     li      r9,2
c00000000001c068:       39 40 00 30     li      r10,48


regards
