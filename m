Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34984DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 03:22:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8OHNPNv003285
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 13:23:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8OHLuVd657594
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 13:21:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8OHLuA1012812
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 13:21:56 -0400
Date: Mon, 24 Sep 2007 12:21:49 -0500
To: Anton Blanchard <anton@samba.org>, Andy Whitcroft <apw@shadowen.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: [apw@shadowen.org: 2.6.23-rc6-mm1 -- powerpc pSeries_log_error
	panic in rtas_call/early_enable_eeh]
Message-ID: <20070924172149.GA5327@austin.ibm.com>
References: <20070923161740.GA12488@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070923161740.GA12488@kryten>
From: linas@austin.ibm.com (Linas Vepstas)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just got back from vacation.

I'll give this a whirl shortly.

--linas

On Sun, Sep 23, 2007 at 11:17:40AM -0500, Anton Blanchard wrote:
> 
> Hi Linas,
> 
> Looks like EEH could be involved :)
> 
> Anton
> 
> ----- Forwarded message from Andy Whitcroft <apw@shadowen.org> -----
> 
> From: Andy Whitcroft <apw@shadowen.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Subject: 2.6.23-rc6-mm1 -- powerpc pSeries_log_error panic in
> 	rtas_call/early_enable_eeh
> X-SPF-Guess: neutral
> Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
> X-BeenThere: linuxppc-dev@ozlabs.org
> X-Mailman-Version: 2.1.9
> List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
> List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
> 	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
> List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
> List-Post: <mailto:linuxppc-dev@ozlabs.org>
> List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
> List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
> 	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
> 
> Seeing the following panic booting an old powerpc LPAR:
> 
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc000000000047b48
> cpu 0x0: Vector: 300 (Data Access) at [c0000000006a3750]
>     pc: c000000000047b48: .pSeries_log_error+0x364/0x420
>     lr: c000000000047acc: .pSeries_log_error+0x2e8/0x420
>     sp: c0000000006a39d0
>    msr: 8000000000001032
>    dar: 0
>  dsisr: 42000000
>   current = 0xc0000000005acab0
>   paca    = 0xc0000000005ad700
>     pid   = 0, comm = swapper
> enter ? for help
> [c0000000006a3af0] c000000000021164 .rtas_call+0x200/0x250
> [c0000000006a3ba0] c000000000049d50 .early_enable_eeh+0x168/0x360
> [c0000000006a3c70] c00000000002f674 .traverse_pci_devices+0x8c/0x138
> [c0000000006a3d10] c000000000560ce8 .eeh_init+0x1a8/0x200
> [c0000000006a3db0] c00000000055fb70 .pSeries_setup_arch+0x128/0x234
> [c0000000006a3e40] c00000000054f830 .setup_arch+0x214/0x24c
> [c0000000006a3ee0] c000000000546a38 .start_kernel+0xd4/0x3e4
> [c0000000006a3f90] c00000000045adc4 .start_here_common+0x54/0x58
> 0:mon>
> 
> This machine is:
> 
> # cat /proc/cpuinfo
> processor       : 0
> cpu             : POWER4+ (gq)
> clock           : 1703.965296MHz
> revision        : 19.0
> 
> [...]
> machine         : CHRP IBM,7040-681
> 
> -apw
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> ----- End forwarded message -----
