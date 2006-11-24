Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id DA3ED67BCF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Nov 2006 22:24:05 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Perl
Date: Fri, 24 Nov 2006 12:23:28 +0100
References: <20061123230056.464AB353B52@atlas.denx.de>
In-Reply-To: <20061123230056.464AB353B52@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611241223.29117.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

I used FC4 ppc binaries for some testing. xlibs, xterm and python where 
the first packages I did some tests with. It was just a try to see what 
happens.

FPU emulation was the first I needed (of course). Then I switched to the ELDK 
ppc_4xxFP root filesystem. This makes it even possible to use perl with math:

bash-3.00# perl -e 'print ("sin(pi/2)=",sin(3.14/2),"\n")'
sin(pi/2)=0.999999682931835
bash-3.00# perl -e 'print ("sqrt(3)=",sqrt(3),"\n")'
sqrt(3)=1.73205080756888
bash-3.00# cat /proc/cpuinfo
processor       : 0
cpu             : 405GPr
clock           : 399MHz
revision        : 9.81 (pvr 5091 0951)
bogomips        : 495.61
machine         : esd CPCI-405
plb bus clock   : 133MHz
pci bus clock   : 33MHz
bash-3.00#  

I would not recommend to use this for production. But its a good starting 
point before turning on the compiler :-)

Matthias

On Friday 24 November 2006 00:00, Wolfgang Denk wrote:
> In message <200611230826.36163.matthias.fuchs@esd-electronics.com> you 
wrote:
> > 
> > there's a quick'n'dirty way to get a perl running on your CPU.
> > Take the Fedora Core 4 ppc binary rpm (perl-5.8.6-15.ppc.rpm) and install 
it 
> > from an ELDK 4 root filesystem:
> 
> This will only work if you are running on a system where your CPU has
> a full-blown CPU,  32  bytes  cache  line  size,  and  your  run-time
> environment (all system libraries) are configured to use the FPU.
> 
> It will fail on  FPU-less  or  FPU-restricted  systems  like  MPC8xx,
> PPC4xx, or MPC85xx.
> 
> > Note: This test has been done on a PPC405. But do not forget to use a 
kernel 
> > with math emulation for this to work. 
> 
> I guess you didn't do much testing. You should try some  mathematics,
> and  you  might  be surprised what happens when your Perl binary uses
> the (emulated) FPU, while the system libraries use soft-float.
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> It's all Klatchian to me.
>         - Terry Pratchett & Stephen Briggs, _The Discworld Companion_
> 
> 

-- 
-----------------------------------------------------------------------
Dipl.-Ing. Matthias Fuchs             esd electronic system design gmbh
http://www.esd-electronics.com                    Vahrenwalder Str. 207
phone: +49-511-37298-0, fax: -68                30165 Hannover, Germany
-----------------------------------------------------------------------
