Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3F3362BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 20:12:41 +1100 (EST)
Date: Thu, 13 Jan 2005 01:12:35 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Aubrey Lee <aubrey1127@gmail.com>
Message-ID: <20050113091235.GA2816@gate.ebshome.net>
References: <7f834d4e0501130050666b757a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f834d4e0501130050666b757a@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: About Zebra Error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jan 13, 2005 at 04:50:27PM +0800, Aubrey Lee wrote:
>  hi, In the PC(i686) system, I build and run zebra successfully. And now
> I'm porting it to the powerpc system. Cross-compiling finished without error.
> But when I run the zebra from my target board, it gives me  a big headache:
> --------------------------------------------------------------------------  
> bash-2.05b# /opt/zebra/sbin/zebra
>              sock: Address family not supported by protocol
> ----------------------------------------------------------------------------
> And Up to now I cann't find the message in the souce 
> code files.  
>      The two ethx and their driver of my board is OK.
>      What shall I do?

Most probably zebra needs some some socket family (e.g. PF_PACKET) 
which wasn't enabled in your PPC kernel.

Compare .config files for x86 and PPC kernels, especially networking 
configuration parts.

The reason you cannot find "Address family not supported by protocol" 
message in the zebra sources is because this message comes from libc, 
e.g. by using perror(3) or sys_errlist directly.

--
Eugene
