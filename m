Return-Path: <kjoutwater@raytheon.com>
Received: from tus-gate2.raytheon.com (tus-gate2.raytheon.com [199.46.245.231])
	by ozlabs.org (Postfix) with ESMTP id 2CDC868386
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 09:52:07 +1000 (EST)
Received: from ds02t00.directory.ray.com (ds02t00.directory.ray.com
	[147.25.154.117])
	by tus-gate2.raytheon.com (8.12.10/8.12.10) with ESMTP id
	j8TNq53H000090 for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 16:52:05 -0700 (MST)
Received: from ds02t00 (localhost [127.0.0.1])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j8TNoUCA014220
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 Sep 2005 23:51:17 GMT
Received: from ds02t00.directory.ray.com with LMTP by ds02t00
	(2.0.6/sieved-2-0-build-559)
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 Sep 2005 23:50:29 +0000
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j8TNmHsh013587
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 23:48:17 GMT
In-Reply-To: <433A631B.6000602@xilinx.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF5E6CFFE0.7E25CCDD-ON0725708B.00826E8F-0725708B.0082C3E1@mck.us.ray.com>
Date: Thu, 29 Sep 2005 16:48:16 -0700
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: linuxppc-2.4.30-pre1 crashes with root fs on Xilinx SystemACE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter - 
That's about the throughput I saw on my system.  It's pretty slow!

Tony - 
I did get things working by applying a "sysace nointr" patch that had been 
posted to the list some
time ago in response to comments that SystemACE interrupts were not 
working as expected on
Memec boards.  I did my initial development on a Memec board and had lots 
of problems until
I disabled SystemACE interrupts.  Some day I may actually go back and try 
to figure out
what is going on, but for the time being, I can live with what I have.


Peter Ryser <peter.ryser@xilinx.com> wrote on 09/28/2005 02:32:11 AM:

> Some time ago we did some tests with bonnie++ on Linux running on 
> the PPC405 in a Virtex-II Pro FPGA. You can expect the following 
performance:
> Read peak: 629 KB/s
> Write peak: 299 KB/s
> Not considering network overhead, a 10MB file should take less than 
> a minute to update.
> 
> - Peter
> 
> 
> Tony Lee wrote:
> Keith, 
> 
> Some suggestions, before you verify your hw board/FPGA works fine 
> with SYSACE, 
>     * don't use sysace as root fs.
>     * use a ram fs as root fs. 
>     * Next, load sysace driver a loadable driver module.  It works, 
> I tried it.
>     * check mount read only and see if it works.
>     * Next, mount it writable.
> 
> We have some issues with sysace driver initially, everything works 
> out fine later.
> There were small errors in our HW layout.
> 
> I had to hack the sysace driver left and right to id the problem.  But 
at the 
> end, after I fixed the layout problem from the fpga's ucf file, the 
> original driver
> run perfectly without any modification.
> 
> In my experiences, the ppc linux distribution and its linux sysace 
> driver are good
> if everything is setup correctly.
> 
> One minor issues:  The sysace driver's write performance sucks.  I 
> have to explain
> to others why the upgrade 10 MBytes files with usb flash writer takes 
tens of 
> seconds.  When we do it from linux (nfs or ftp), it tooks minutes to 
sync.
> 
> Peter, maybe you can push the xilinx a bit on sysace write performance? 
:-)
> 
> -Tony

> On 8/29/05, Peter Ryser <peter.ryser@xilinx.com> wrote: 
> Hi Keith,
> 
> I sent you a private email but for other interested people:
> Downloading the latest linuxppc-2.4 kernel I could boot from and access
> System ACE CF without problems on a ML403 (Virtex-4, 4VFX12) and a ML310 

> (Virtex-II Pro, 2VP30) using EDK 7.1.2. In both cases I started with
> config_xilinx_ml300.
> 
> - Peter
> 
> 
> 
> Keith J Outwater wrote:
> 
> >Hello -
> >Per a previous suggestion from this list, I rsynced the linuxppc-2.4
> >kernel sources from MontaVista and modified the kernel to run on my 
custom
> >ppc405/VirtexII Pro based system with U-Boot as the bootloader.
> >When I try to use the SystemACE device as the root filesystem, the 
kernel 
> >crashes with a sig 11.  Looking at the 'oops' output it appears  the
> >SystemACE driver may be to blame.  The crash is random - sometimes I 
get
> >all the way to login as root and then things crash on a file copy or a 
> >file read.
> >Before I start digging deeper, is anyone running a VirtexIIPro based
> >system with the root filesystem in the CF card attached to a SystemACE?
> >I'm wondering if I really have the best kernel and SystemACE driver. 
> >BTW, I'm developing the hardware design using Xilinx EDK 7.02i.
> >Thanks,
> >Keith
> >_______________________________________________
> >Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> >
> >
> 
> 
> 
> _______________________________________________ 
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded 
> 
> 
> 
> -- 
> -Tony
> Having fun with FPGA HW + ppc + Linux
