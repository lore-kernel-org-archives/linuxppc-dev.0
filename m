Return-Path: <mikey@ozlabs.org>
To: mohan@in.ibm.com
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [Fastboot] [PATCH] Reserve crashkernel memory region 
In-reply-to: <20060424061015.GA31320@in.ibm.com> 
References: <20060424061015.GA31320@in.ibm.com>
Date: Fri, 28 Apr 2006 17:06:26 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060428070704.4AD0A679F5@ozlabs.org>
Cc: fastboot@osdl.org, linuxppc-dev@ozlabs.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Now kexec'ed kernel in a PPC64 machine does not reserve memory for
> crashkernel region. So kexec'ed kernel can not load kdump kernel
> reliably.

Owww 3 boots... scary :-)

> Attached kexec-tools patch reserves memory for kdump kernel by adding
> an entry in the reserve memory table. So while kexec'ed kernel is
> booting, it reserves memory for crashkernel region.

This logic is duplicated in prom_init.c.  

It'd be cool if the kernel parsed the command line early on (after
prom_init.c) and did the memory reserves there.  Then we wouldn't need
this logic in both the kexec tools and prom_init.c.

Mikey
