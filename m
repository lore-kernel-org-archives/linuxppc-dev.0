Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 86C14DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 12:44:38 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2509107pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 01 Apr 2008 18:44:30 -0700 (PDT)
Subject: Re: Access physical memory via mmap() on ppc440epx.
From: Josh Boyer <jwboyer@gmail.com>
To: Leonid <Leonid@a-k-a.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C033A981B@ehost011-3.exch011.intermedia.net>
References: <406A31B117F2734987636D6CCC93EE3C033A981B@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 20:44:25 -0500
Message-Id: <1207100665.12155.100.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2008-04-01 at 14:12 -0700, Leonid wrote:
> Hi:
> 
> I am trying to read from NOR flash, located on address 0xfc000000, on my

It's at 0x1fc000000 IIRC.

> TLB entries look strange though. That what it was on u-boot stage:
> 
> 440EPx>tlb 0 10
> IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
>  0 : 00 40000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
>  1 : 00 00000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
>  2 : 00 c0000000 256MB V0 -> 1_c0000000 U:0000 -I-G- XWRXWR
>  3 : 00 f0000000 256MB V0 -> 1_f0000000 U:0000 WI-G- XWRXWR

See.  Virtual is 0xf0000000, physical is 0x1f0000000.

> On Linux stage it looks rather different:

I don't even see your entry in here.  Likely because the TLB is small
and it's gone by the time you do the dump

> Probably under MMU it should look this way? How to use mmap() then?

Try mmap64 on the real physical address and see if that helps.

josh
