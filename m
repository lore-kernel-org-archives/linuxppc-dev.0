Message-Id: <200405190239.i4J2dHRV010022@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Re: ELDK help
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 19 May 2004 10:39:17 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

     Thanks. That was the problem. I am using ELDK on x86 platform and
2.4.21 for powerpc kernel.

======= 2004-05-18 09:31:00 Origianl message=======

>In message <200405180149.i4I1niRV001354@ms.usish.com> you wrote:
>>
>>      ELDK worked for me greatly before. Just a few days ago,I found
>> that when I not use make clean, things work ok. However when I make
>> clean and make uImage, the following error message appears:
>
>What host system are you running? Are you sure your native compiler is
>working?
>
>Which kernel tree is this? How did you configure the kernel? What is
>the _exact_ sequence of commands you are using?
>
>> make[3]: Entering directory `/root/new/4.1/drivers/char'
>> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/root/new/4.1/arch/ppc -o conmakehash conmakehash.c
>> /tmp/cck3aG7b.s: Assembler messages:
>> /tmp/cck3aG7b.s:2: Warning: Unrecognized .section attribute: want a,m,s,w,x
>> /tmp/cck3aG7b.s:2: Warning: Unrecognized .section attribute: want a,m,s,w,x
>> /tmp/cck3aG7b.s:155: Warning: Unrecognized .section attribute: want a,m,s,w,x
>> /tmp/cck3aG7b.s:155: Warning: Unrecognized .section attribute: want a,m,s,w,x
>> /usr/local/bin/ld: unrecognized option '--eh-frame-hdr'
>> /usr/local/bin/ld: use the --help option for usage information
>....
>
>>   It seems that the toolchain is broken since it used gcc instead of
>> ppc_82xx-gcc which caused error happen. I reinstalled the ELDK and
>
>You are wrong. This is one of the source files which gets compiled
>using the host's native compiler; the Makefile has this rule for it:
>
>	conmakehash: conmakehash.c
>		$(HOSTCC) $(HOSTCFLAGS) -o conmakehash conmakehash.c
>
>> help. So what could be the problem? Some configuration changes?
>
>Obviously your hostcompiler (gcc) and/or you host's binutils have some
>problems. This is not a problem with the ELDK.

= = = = = = = = = = = = = = = = = = = =

Best regards
Jack Liu
R&D Dept. USI(Shanghai) Inc.
Tel: +86-21-58966996x1155
Fax: +86-21-58967931
Email: Jack_liu@usish.com
http://www.usi.com.tw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
