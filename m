Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id 251562BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 22:16:48 +1100 (EST)
To: "Mark Chambers" <markc@mail.com>
MIME-Version: 1.0
Message-ID: <OFFFCD5BD5.0EE17E30-ONC1256F4E.003CC864-C1256F4E.003DF1A9@axxessit.no>
From: morten.banzon@axxessit.no
Date: Tue, 16 Nov 2004 12:16:36 +0100
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am not sure if I understand you. The CPM must have been told somehow 
that there is something for its peripherals in this particular region of 
the dpram1 or no ? I wild guess could be that the bootloader (in this case 
u-boot) has configured this area of dpram1 behind the back of the kernel. 
I assume that is not the case. Would not that be rather ugly ?
 
The mcc driver I am trying to get running on linux-2.6.9 is a driver I 
wrote for pSos a few years ago, and it is running fine on that platform.
Therefore, I am sure that there is nothing i the processor or the cpm that 
prevents me from putting mcc related parameters at offset zero in the 
dpram1.
I am still trying to figure out what piece of code in the kernel that I 
have to manipulate to get this driver working. 

Thanks for any advise,
Morten





"Mark Chambers" <markc@mail.com>
16.11.2004 04:43

 
        To:     <morten.banzon@axxessit.no>
        cc: 
        Subject:        Re: MPC82xx -- DPRAM1


The thing you might be missing is that the CPM coprocessor uses some dpram
that
is not accessed by the PPC processor at all.  So the memory must be set
aside for
the peripherals but the linux code won't reference it.

Mark Chambers

----- Original Message ----- 
From: "Dan Malek" <dan@embeddededge.com>
To: <morten.banzon@axxessit.no>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Monday, November 15, 2004 7:18 PM
Subject: Re: MPC82xx -- DPRAM1


>
> On Nov 15, 2004, at 11:10 AM, morten.banzon@axxessit.no wrote:
>
> > I am using 2.6.9 for a mpc8280 project, and am having trouble using
> > dpram1
> > from offset zero, which I need for a mcc hdlc driver.
>
> Why does it have to start at zero?
>
> >  In the file include/asm-ppc/cpm2.h there is a constant
> > CPM_DATAONLY_BASE
> > In the same file the code comment say that the first 128 bytes are 
used
> > for SMC1 and SMC2.
>
> Yes, it is.
>
> > When I examine the smc (cpm_uart) driver i do not find any reference 
to
> > this region of the dpram1.
>
> It's there somewhere, hardcoded with values 0, then sizeof() something
> is
> probably added to it.
>
> > I have replaced the calls to cpm_dpalloc with cpm_dpalloc_fixed and an
> > adress way up in the dpram1 region.
>
> Very bad idea.
>
> > My question is; do you know which code is using the dpram1 addresses
> > below
> > CPM_DATAONLY_BASE ?
>
> The SMC1 and SMC2 peripherals, just like the comment says.
>
> > This region must be used by something (smc ?), because when I clear
> > from
> > offset 0x00 to 0x80 the serial port stop responding.
>
> Yep.
>
>
> -- Dan
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
