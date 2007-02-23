Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2419DDDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 09:58:21 +1100 (EST)
To: Patrice Bouchand <pb_fwd_list@yahoo.fr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: mcpu options for AMCC440 with fpu 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Feb 2007 09:45:04 +0100."
	<600461.55072.qm@web23412.mail.ird.yahoo.com>
Date: Fri, 23 Feb 2007 23:58:18 +0100
Sender: wd@denx.de
Message-Id: <20070223225818.8DF743525B0@atlas.denx.de>
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

In message <600461.55072.qm@web23412.mail.ird.yahoo.com> you wrote:
>
>    I was searching for the best mcpu option for amcc440, compiling and running a small program you can find here: 
> http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core 6, and results are obviously the same using DENX4.0.

In general, you should need to meddle much with such options; the ELDK
default settings are usually OK.

> --------------------
> -bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> 
> real    1m15.059s
> user    1m14.996s
> sys     0m0.060s
> -bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> 
> real    0m39.606s
> user    0m39.552s
> sys     0m0.028s
> -bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> 
> real    1m15.016s
> user    1m14.988s
> sys     0m0.024s
> -bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot
> 
> real    0m39.577s
> user    0m39.544s
> sys     0m0.032s

This looks to me as if you have been runing all these  tests  in  the
SAME  environment,  probably  the /opt/eldk/ppc_4xx root file system,
which is soft-float based. You must not do this.

For tests with FP instructions, you MUST use the  /opt/eldk/ppc_4xxFP
root  file  system.  For  tests  with  soft-float,  you  MUST use the
/opt/eldk/ppc_4xx root file system.

You CANNOT link  an  application  build  with  one  settings  against
libraries using other settings, or you will run into trouble. You
would probably have seen the problems if you had used any test where
the results of the calculations would have been visible.


> * I do not explain why not using FPU gives better results ?

Because you did not run the tests you thought yoiu were running.

> * mcpu option seems to not have any effect ?

Use "gcc -v" to see exactly which options get passed to the  compiler
stages.

> *  My third test was to compile and run mplayer.
> - With default options (no mcpu specified), my test mpeg was smooth.
> - With mcpu=440fp, my test mpeg was not smooth.
> 
>  Can anybody bring me some lights about the right gcc mcpu option for amcc440 ?

Just use the  defaults, unless you know exactly what you are doing.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If there was anything that depressed him more than his own  cynicism,
it was that quite often it still wasn't as cynical as real life.
                                 - Terry Pratchett, _Guards! Guards!_
