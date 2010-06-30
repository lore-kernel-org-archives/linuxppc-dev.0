Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 482AAB6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 16:14:36 +1000 (EST)
Received: by iwn36 with SMTP id 36so256231iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 23:14:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100629185617.GA24285@schlenkerla.am.freescale.net>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
Date: Tue, 29 Jun 2010 23:14:34 -0700
Message-ID: <AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

>> Bus Fault @ 0x00404c40, fixup 0x00000000
>> Machine check in kernel mode.
>> Caused by (from msr): regs 07d1cb80 Unknown values in msr
>> NIP: 00404C40 XER: 00000000 LR: 00404C24 REGS: 07d1cb80 TRAP: 0200 DAR: 00000001
>> MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
>
> Can you look up the source line/instruction corresponding to 0x404c40, in
> the wrapper ELF file?

I'm not sure how to look up it. But I used the BDI to dump the
instructions in which you may find some clue? These should be kernel
code, right? Maybe the gdb can help to de-assemble them?

BDI>md 0x404c00 0x20
00404c00 : 0x4800317d   1207972221  H.1}
00404c04 : 0x80010014  -2147418092  ....
00404c08 : 0xbbc10008  -1144979448  ....
00404c0c : 0x7c0803a6   2080900006  |...
00404c10 : 0x38210010    941686800  8!..
00404c14 : 0x4e800020   1317011488  N..
00404c18 : 0x9421fff0  -1809711120  .!..
00404c1c : 0x7c0802a6   2080899750  |...
00404c20 : 0x429f0005   1117716485  B...
00404c24 : 0xbfc10008  -1077870584  ....
00404c28 : 0x7fc802a6   2143814310  ....
00404c2c : 0x90010014  -1878982636  ....
00404c30 : 0x3fde0001   1071513601  ?...
00404c34 : 0x3bdedd98   1004461464  ;...
00404c38 : 0x813e8000  -2126610432  .>..
00404c3c : 0x81490000  -2125922304  .I..
00404c40 : 0xa00a0000  -1609957376  ....
00404c44 : 0x0c000000    201326592  ....
00404c48 : 0x4c00012c   1275068716  L..,
00404c4c : 0x70090001   1879638017  p...
00404c50 : 0x4082fff0   1082327024  @...
00404c54 : 0x817e8000  -2122416128  .~..
00404c58 : 0x5469402e   1416183854  Ti@.

Thanks a lot,
-Shawn.
