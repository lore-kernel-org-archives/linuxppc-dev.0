Message-Id: <200101162346.f0GNkVQ30324@denx.local.net>
To: "Zheng, Haifei" <haifei.zheng@intel.com>
cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FADS board and bootp 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Jan 2001 14:52:34 PST."
             <5D2136DF3DD5D311AE89009027C67FB001D8F288@fmsmsx96.fm.intel.com>
Date: Wed, 17 Jan 2001 00:46:31 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <5D2136DF3DD5D311AE89009027C67FB001D8F288@fmsmsx96.fm.intel.com> you wrote:
>
> After having shelved the FADS board for a couple of weeks, we dug it out
> again and tried to install ppcboot (ver 0.7.1). We used the cross compiler
> that comes with hardhat and set the makefile appropriately. The build went
> smoothly, with the odd warning popping up. As noted in the doc, downloading
> the image is another story. We used the Motorola ADI port to upload the
> kernel and to start execution.... unfortunately it doesn't get far ;-D

You have better chances to get help for  PPCBoot  if  you  send  such
messages to the PPCBoot mailing list at ppcboot-users@lists.sourceforge.net

...
> Flash programming completed
...
> f860TBug> go
>   Use Ctrl-C to abort execution !
> exception: SOFTWARE EMULATION
> 0x02800000      27051956 unknown primary opcode 9

27051956 is indeed no valid opcode, it's my birthday instead :-)

> What methods are you using to upload binaries?

It seems our download method was OK, since the magic number is at the
expected address (at the start of the image in flash).

> Have you experienced similar problems?
>   Or  have we just done something silly?

To be honest: yes. Normally, PPCBoot is started out  of  reset,  when
the  ROM  (or  flash)  is mapped at address 0x0000 and the CPU starts
execution at address 0x0100. So you will find the  first  instruction
of PPCBoot at offset 0x0100 - at address 0x02800100 in your case.

But please be aware that PPCBoot assumes to start with  reset  state,
which means flash mapped at 0.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not simplify the design of a program if a way can be found to make
it complex and wonderful.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
