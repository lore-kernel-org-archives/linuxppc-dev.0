Return-Path: <linas@austin.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C67A67A6C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 05:47:36 +1000 (EST)
Received: from e3.ny.us.ibm.com (e3.pok.ibm.com [9.56.232.143])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k56HXtBd008087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 13:33:56 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k56HXopC032458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 13:33:50 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k56HXo1f249906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 13:33:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k56HXoTQ012538
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 13:33:50 -0400
Date: Tue, 6 Jun 2006 12:33:43 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Base address of executables - weirdness?
Message-ID: <20060606173343.GE9294@austin.ibm.com>
References: <4485A279.4050403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4485A279.4050403@zytor.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 06, 2006 at 08:42:49AM -0700, H. Peter Anvin wrote:
> I'm trying to track down an odd issue with klibc on ppc32.
> 
> Until recently, binaries linked with ld defaulted to a base address of 
> 0x10000000+SIZEOF_HEADERS.  However, recently I've gotten a couple of 
> reports -- and I've been able to confirm this on my FC5 system -- that 
> some versions of ld links at 0x01800000+SIZEOF_HEADERS.  Needless to 
> say, this is more than a bit confusing, *especially* since "ld -verbose" 
> still reports:
> 
>      PROVIDE (__executable_start = 0x10000000); . = 0x10000000 + 
> SIZEOF_HEADERS;
> 
> ... at the top of the linker script.
> 
> I'm rather baffled.  Has anyone else seen this, and/or have any other 
> explanation?

Googling "0x01800000 linux ppc" brings up some interesting but old hits.

However, I swear I saw someone suggest a patch last week that changed
0x10000000 to 0x01800000 somewhere, (vmlinux.lds ??) as a proposed cure
for a bug. Sorry, I deleted it.

--linas 
