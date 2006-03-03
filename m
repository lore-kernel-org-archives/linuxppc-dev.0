Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9D05679FB
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 10:23:39 +1100 (EST)
Date: Sat, 4 Mar 2006 00:23:34 +0100
From: Olaf Hering <olh@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force stackpointer alignment in 64bit kernel
Message-ID: <20060303232334.GA9577@suse.de>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
	<20060303191633.GA7792@suse.de>
	<3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Segher Boessenkool wrote:

> > The stackpointer came from 32bit code, which appearently has different
> > alignment rules than 64bit code. The chain was yaboot -> zImage ->  
> > vmlinux
> > Force the stackpointer to be 16 byte aligned.
> 
> The stack pointer is required to be 16-byte aligned when the
> client program is started, on 32-bit as well.

See http://ozlabs.org/pipermail/linuxppc-dev/2006-March/021342.html

Either yaboot and/or zImage need to force a stack alignment, or we apply
the 2 liner.
