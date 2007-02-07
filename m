Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DE78ADDE44
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 03:36:15 +1100 (EST)
Message-ID: <45C9FE30.8010108@freescale.com>
Date: Wed, 07 Feb 2007 10:28:32 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mike Strosaker <strosake@austin.ibm.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>		<20070206013051.GA15525@lixom.net>	<45C90A6E.3040302@freescale.com>		<17865.2853.132102.769702@cargo.ozlabs.ibm.com>	<1170805102.2620.264.camel@localhost.localdomain>
	<45C91275.4020806@freescale.com> <45C97121.9080609@austin.ibm.com>
In-Reply-To: <45C97121.9080609@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Strosaker wrote:

> The op panel on recent systems has 2 lines; the first can display 16 
> characters, the second, 80.  The first line is usually used to display 
> an 8 character hexadecimal progress/error message (called an SRC: System 
> Reference Code), and the second line is used to display a location code 
> when appropriate (e.g. when the SRC indicates a device failure).  IBM 
> documents many of their OF and RTAS SRCs deep in the Hardware 
> Information Center:

In that case, the big question is: does the kernel conform to this standard? 
Looking at the current usage of ppc_md.progress(), I can't help but think that 
it being called the same way printk() is being called, i.e. at the whim of the 
developer who wrote the code.

So let's say that we need to keep ppc_md.progress().  I think we should have 
some way of restricting its usage to systems where it does something different 
than printk().  On an Freescale 83xx reference board, for example, its output 
goes to the same place as printk(), so it doesn't serve any purpose.

Perhaps we should define ppc_md.progress() such that it never sends the output 
to the same place as printk().  If the only output device is the serial port, 
and printk() already outputs there, then ppc_md.progress() should do nothing. 
This would eliminate any "accidental" use of ppc_md.progress(), when printk() is 
the better choice.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
