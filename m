Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1E86BDDFD1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 04:11:43 +1000 (EST)
To: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Weird 5200/mtd-ram problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1243273283.3328.0@antares>
References: <1243273283.3328.0@antares>
Date: Mon, 25 May 2009 20:11:39 +0200
Message-Id: <20090525181140.01DB1832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Albrecht =?iso-8859-1?b?RHJl3w==?=,

In message <1243273283.3328.0@antares> you wrote:
>
> Thanks for youre help, and sorry for the late reply - I've been on  
> vacation...

Hally you...

> For the mtd driver, I tracked down the problem via mapram_write() (in  
> drivers/mtd/chips/map_ram.c) down to the call of map_copy_to() which is  
> actually inline_map_copy_to(), which in turn calls memcpy_toio().  I  
> *think* this is _memcpy_toio() in arch/powerpc/kernel/io.c, which  
> copies all data in long (4-byte) moves, except for the last 4 bytes.  I  
> guess I have to write my own copy function which respects the fact that  
> byte writes actually must be a read word - modify - write word  
> sequence, right?

I remember some nasty problems with memcpy*(),  especially  with  un-
aligned  accesses  over the LocalPlus Bus. I'm not sure if fixes ever
made it into 2.6; the only commit that might be related is 6989f5122f
"fec: do not use memcpy on physical addresses", but this doesn't  got
into details about the casue.

Please see here for an old (2.4.25) patch for this problem - maybe
it's worth a try on your system:

http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=222bd702a59efb22bf66937f6ac844ed7327fd1a

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you're not part of the solution, you're part of the problem.
