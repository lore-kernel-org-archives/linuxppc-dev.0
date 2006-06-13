Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id A4E6467AC7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 07:12:31 +1000 (EST)
Message-ID: <448F2907.4020108@dlasys.net>
Date: Tue, 13 Jun 2006 17:07:19 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>
Subject: Re: help with inittab
References: <EDF27F298D4B03498AE0C249A941DFF803D70E@de01exm68.ds.mot.com>
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D70E@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    My specific problem turned out to be that the serial driver I had
written was still using the physical IO address that I had temporarily
mapped (virtual=physical) during very early boot, and when that
temporary mapping went away I instantly became deaf and dump and it just
happend to go away while starting init.

    But for a long time I though I had other problems, so things I tried
included:
          Writing a simple "hello world" program and running that from
where the kernel starts init.

          I think where the kernel starts init is the first place that
Linux actually starts making use of virtual memory.
    I beleive that the way the kernel loads a program involves actually
forcing pagefaults, so alot of things can work, but if paging is not
working perfectly
    you will not be able to start another process.

          Another thing you should watch out for is that there are two
places Linux looks to start an "init" process.
       The first uses whatever might be specified as a commandline
argument (or in your .config, or hardcoded in some BSP's)
        If that fails then it starts through a list of potential init
processes until one starts.
       I recently had a problem where I wanted to start "/bin/sh" as my
init so I commented out everything else, but left the command line
argument option in and still did not get /bin/sh because it was picking
up the argument from elsewhere.
      

Anantharaman Chetan-W16155 wrote:
> I've tried what you've mentioned below, i.e removing the /sbin/init and
> just having the /bin/sh in the init/main.c file and I don't get a
> standalone shell. I am having a Linux 2.4 Kernel (Montavista 3.1)
> running on a PPC405 in a Xilinx Virtex4 FX100 FPGA.
>
> You mentioned it could be a hardware problem. Are there any errata which
> could explain the h/w bug? 
>
>
> Thanks,
> Chetan Anantharaman
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Sun, 11 Jun 2006 22:02:02 -0400
> From: "David H. Lynch Jr." <dhlii@dlasys.net>
> Subject: Re: help with inittab
> Cc: Chris Dumoulin <cdumoulin@ics-ltd.com>,
> 	linuxppc-embedded@ozlabs.org
> Message-ID: <448CCB1A.409@dlasys.net>
> Content-Type: text/plain; charset=ISO-8859-1
>
>    
>     For debugging or single user purposes you do not need to run init or
> have an inittab.
>     There have been several sugestions that there may be a hardware
> problem - there are a number that are possible.
>
>     I was stalled here for some time because my UartDriver was
> accidentally using the physical IO address instead of the virtual one
>     and I had created a temporary phys=virtual entry in the tbl that was
> conveniently getting blow away just here.
>
>     You can try to isolate your problem by changing your boot ramdisk
> (inramfs or initrd)
>
>     Eliminate or rename /init /sbin/init /linuxrc and any of the other
> permutations that linux tries to execute in init/main.c they are all
> listed very near where you stopped.
>     make sure you have /bin/sh
>
>     reboot on that ramdisk  if you have an "init" related problem then
> you should get a standalone shell.
>     If you have a hardware problem you will likely still stop at the
> same place.
>    
>
>
>
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
