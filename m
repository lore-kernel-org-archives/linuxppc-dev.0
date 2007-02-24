Return-Path: <pb_fwd_list@yahoo.fr>
Received: from postfix2-g20.free.fr (postfix2-g20.free.fr [212.27.60.43])
	by ozlabs.org (Postfix) with ESMTP id 3E745DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 18:03:40 +1100 (EST)
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 25C76B5CAF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 06:45:02 +0100 (CET)
Subject: Re: mcpu options for AMCC440 with fpu
From: Patrice Bouchand <pb_fwd_list@yahoo.fr>
To: WolfgangDenk <wd@denx.de>
In-Reply-To: <20070223225818.8DF743525B0@atlas.denx.de>
References: <20070223225818.8DF743525B0@atlas.denx.de>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 07:44:45 +0100
Message-Id: <1172299485.2993.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: pb_fwd_list@yahoo.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 
Indeed ! I was waiting for warnings or errors while compiling to tell me
I was doing something wrong but I should not.

 Thanks for your time.

   Patrice


> In message <600461.55072.qm@web23412.mail.ird.yahoo.com> you wrote:
> >
> >    I was searching for the best mcpu option for amcc440, compiling and running a small program you can find here: 
> > http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core 6, and results are obviously the same using DENX4.0.
> 
> In general, you should need to meddle much with such options; the ELDK
> default settings are usually OK.
> 
> > --------------------
> > -bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    1m15.059s
> > user    1m14.996s
> > sys     0m0.060s
> > -bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    0m39.606s
> > user    0m39.552s
> > sys     0m0.028s
> > -bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    1m15.016s
> > user    1m14.988s
> > sys     0m0.024s
> > -bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    0m39.577s
> > user    0m39.544s
> > sys     0m0.032s
> 
> This looks to me as if you have been runing all these  tests  in  the
> SAME  environment,  probably  the /opt/eldk/ppc_4xx root file system,
> which is soft-float based. You must not do this.
> 
> For tests with FP instructions, you MUST use the  /opt/eldk/ppc_4xxFP
> root  file  system.  For  tests  with  soft-float,  you  MUST use the
> /opt/eldk/ppc_4xx root file system.
> 
> You CANNOT link  an  application  build  with  one  settings  against
> libraries using other settings, or you will run into trouble. You
> would probably have seen the problems if you had used any test where
> the results of the calculations would have been visible.
> 
> 
> > * I do not explain why not using FPU gives better results ?
> 
> Because you did not run the tests you thought yoiu were running.
> 
> > * mcpu option seems to not have any effect ?
> 
> Use "gcc -v" to see exactly which options get passed to the  compiler
> stages.
> 
> > *  My third test was to compile and run mplayer.
> > - With default options (no mcpu specified), my test mpeg was smooth.
> > - With mcpu=440fp, my test mpeg was not smooth.
> > 
> >  Can anybody bring me some lights about the right gcc mcpu option for amcc440 ?
> 
> Just use the  defaults, unless you know exactly what you are doing.
> 
> Best regards,
> 
> Wolfgang Denk
> 
