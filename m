Return-Path: <pb_fwd_list@yahoo.fr>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id 91084DDD09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 06:47:57 +1100 (EST)
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix1-g20.free.fr (Postfix) with ESMTP id C92ACA5D2BC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 20:47:55 +0100 (CET)
Received: from [88.167.113.175] (unknown [88.167.113.175])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 8001E16702
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 20:47:51 +0100 (CET)
Subject: Re: mcpu options for AMCC440 with fpu
From: Patrice Bouchand <pb_fwd_list@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <600461.55072.qm@web23412.mail.ird.yahoo.com>
References: <600461.55072.qm@web23412.mail.ird.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2007 20:47:50 +0100
Message-Id: <1172087270.3018.18.camel@localhost.localdomain>
Mime-Version: 1.0
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


FYI, I got the following answer on mplayer mailing list:

> Apparently -mcpu=440fp is the one. However, it's possible, that GCC
> "optimizations" actually make the code slower.

Can someone confirme this possiblity ?

Any answer would be greatly appreciated ;) 


    Patrice Bouchand


> Hello,
> 
>    I was searching for the best mcpu option for amcc440, compiling and
> running a small program you can find here: 
> http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core
> 6, and results are obviously the same using DENX4.0.
> 
> --------------------
> -bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot &&
> time ./mandelbrot && rm -f ./mandelbrot
> 
> real    1m15.059s
> user    1m14.996s
> sys     0m0.060s
> -bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot &&
> time ./mandelbrot && rm -f ./mandelbrot
> 
> real    0m39.606s
> user    0m39.552s
> sys     0m0.028s
> -bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot &&
> time ./mandelbrot && rm -f ./mandelbrot
> 
> real    1m15.016s
> user    1m14.988s
> sys     0m0.024s
> -bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot &&
> time ./mandelbrot && rm -f ./mandelbrot
> 
> real    0m39.577s
> user    0m39.544s
> sys     0m0.032s
> --------------------
> 
> * I do not explain why not using FPU gives better results ?
> 
> * I did also a test with bzip2.c
> ( http://pag.csail.mit.edu/~smcc/projects/single-file-programs/bzip2.c ).
> 
> ----------------------
> -bash-3.00# gcc -O2 ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c
> && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> 
> real    0m18.478s
> user    0m18.216s
> sys     0m0.152s
> -bash-3.00# gcc -O2 -mcpu=440 ./bzip2.c -o ./bzip2 &&
> time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> 
> real    0m18.786s
> user    0m18.544s
> sys     0m0.128s
> -bash-3.00# gcc -O2 -mcpu=440fp ./bzip2.c -o ./bzip2 &&
> time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> 
> real    0m18.811s
> user    0m18.548s
> sys     0m0.144s
> -bash-3.00# gcc -O2 -mcpu=G3 ./bzip2.c -o ./bzip2 &&
> time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> 
> real    0m18.871s
> user    0m18.644s
> sys     0m0.104s
> ----------------------
> 
> * mcpu option seems to not have any effect ?
> 
> *  My third test was to compile and run mplayer.
> - With default options (no mcpu specified), my test mpeg was smooth.
> - With mcpu=440fp, my test mpeg was not smooth.
> 
>  Can anybody bring me some lights about the right gcc mcpu option for
> amcc440 ?
> 
> Best regards,
> 
>        Patrice Bouchand
> 
> 
> 
> 
> ______________________________________________________________________
> Découvrez une nouvelle façon d'obtenir des réponses à toutes vos
> questions ! Profitez des connaissances, des opinions et des
> expériences des internautes sur Yahoo! Questions/Réponses.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
