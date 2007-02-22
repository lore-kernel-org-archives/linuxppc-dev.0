Return-Path: <pb_fwd_list@yahoo.fr>
Received: from web23402.mail.ird.yahoo.com (web23402.mail.ird.yahoo.com
	[217.146.189.87]) by ozlabs.org (Postfix) with SMTP id C115FDDD07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 17:58:01 +1100 (EST)
Date: Thu, 22 Feb 2007 07:57:59 +0100 (CET)
From: Patrice Bouchand <pb_fwd_list@yahoo.fr>
Subject: RE : Re: mcpu options for AMCC440 with fpu
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20070221223543.64d584d7.mh@omnisys.se>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-334689501-1172127479=:61964"
Message-ID: <447407.61964.qm@web23402.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-334689501-1172127479=:61964
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Thanks for your answer but unfortunately, it makes just the thing a bit slower:

-bash-3.00# gcc -O2 -mcpu=440fp -ffast-math ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    1m17.901s
user    1m17.828s
sys     0m0.036s
-bash-3.00# gcc -O2 -mcpu=440 -ffast-math ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    0m41.180s
user    0m41.116s
sys     0m0.040s
-bash-3.00# gcc -O2 -mcpu=G3 -ffast-math ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    1m14.820s
user    1m14.760s
sys     0m0.044s


Magnus Hjorth <mh@omnisys.se> a écrit : Hi,

Have you tried using the -ffast-math option?

/Magnus


On Wed, 21 Feb 2007 20:47:50 +0100
Patrice Bouchand 
 wrote:

> 
> FYI, I got the following answer on mplayer mailing list:
> 
> > Apparently -mcpu=440fp is the one. However, it's possible, that GCC
> > "optimizations" actually make the code slower.
> 
> Can someone confirme this possiblity ?
> 
> Any answer would be greatly appreciated ;) 
> 
> 
>     Patrice Bouchand
> 
> 
> > Hello,
> > 
> >    I was searching for the best mcpu option for amcc440, compiling and
> > running a small program you can find here: 
> > http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core
> > 6, and results are obviously the same using DENX4.0.
> > 
> > --------------------
> > -bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    1m15.059s
> > user    1m14.996s
> > sys     0m0.060s
> > -bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    0m39.606s
> > user    0m39.552s
> > sys     0m0.028s
> > -bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    1m15.016s
> > user    1m14.988s
> > sys     0m0.024s
> > -bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> > 
> > real    0m39.577s
> > user    0m39.544s
> > sys     0m0.032s
> > --------------------
> > 
> > * I do not explain why not using FPU gives better results ?
> > 
> > * I did also a test with bzip2.c
> > ( http://pag.csail.mit.edu/~smcc/projects/single-file-programs/bzip2.c ).
> > 
> > ----------------------
> > -bash-3.00# gcc -O2 ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c
> > && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> > 
> > real    0m18.478s
> > user    0m18.216s
> > sys     0m0.152s
> > -bash-3.00# gcc -O2 -mcpu=440 ./bzip2.c -o ./bzip2 &&
> > time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> > 
> > real    0m18.786s
> > user    0m18.544s
> > sys     0m0.128s
> > -bash-3.00# gcc -O2 -mcpu=440fp ./bzip2.c -o ./bzip2 &&
> > time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> > 
> > real    0m18.811s
> > user    0m18.548s
> > sys     0m0.144s
> > -bash-3.00# gcc -O2 -mcpu=G3 ./bzip2.c -o ./bzip2 &&
> > time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> > 
> > real    0m18.871s
> > user    0m18.644s
> > sys     0m0.104s
> > ----------------------
> > 
> > * mcpu option seems to not have any effect ?
> > 
> > *  My third test was to compile and run mplayer.
> > - With default options (no mcpu specified), my test mpeg was smooth.
> > - With mcpu=440fp, my test mpeg was not smooth.
> > 
> >  Can anybody bring me some lights about the right gcc mcpu option for
> > amcc440 ?
> > 
> > Best regards,
> > 
> >        Patrice Bouchand
> > 
> > 
> > 
> > 
> > ______________________________________________________________________
> > Découvrez une nouvelle façon d'obtenir des réponses à toutes vos
> > questions ! Profitez des connaissances, des opinions et des
> > expériences des internautes sur Yahoo! Questions/Réponses.
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded



 		
---------------------------------
 Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses.
--0-334689501-1172127479=:61964
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Thanks for your answer but unfortunately, it makes just the thing a bit slower:<br><br>-bash-3.00# gcc -O2 -mcpu=440fp -ffast-math ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 1m17.901s<br>user&nbsp;&nbsp;&nbsp; 1m17.828s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.036s<br>-bash-3.00# gcc -O2 -mcpu=440 -ffast-math ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 0m41.180s<br>user&nbsp;&nbsp;&nbsp; 0m41.116s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.040s<br>-bash-3.00# gcc -O2 -mcpu=G3 -ffast-math ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 1m14.820s<br>user&nbsp;&nbsp;&nbsp; 1m14.760s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.044s<br><br><br><b><i>Magnus Hjorth &lt;mh@omnisys.se&gt;</i></b> a écrit&nbsp;:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16,
 255); margin-left: 5px; padding-left: 5px;"> Hi,<br><br>Have you tried using the -ffast-math option?<br><br>/Magnus<br><br><br>On Wed, 21 Feb 2007 20:47:50 +0100<br>Patrice Bouchand <pb_fwd_list@yahoo.fr> wrote:<br><br>&gt; <br>&gt; FYI, I got the following answer on mplayer mailing list:<br>&gt; <br>&gt; &gt; Apparently -mcpu=440fp is the one. However, it's possible, that GCC<br>&gt; &gt; "optimizations" actually make the code slower.<br>&gt; <br>&gt; Can someone confirme this possiblity ?<br>&gt; <br>&gt; Any answer would be greatly appreciated ;) <br>&gt; <br>&gt; <br>&gt;     Patrice Bouchand<br>&gt; <br>&gt; <br>&gt; &gt; Hello,<br>&gt; &gt; <br>&gt; &gt;    I was searching for the best mcpu option for amcc440, compiling and<br>&gt; &gt; running a small program you can find here: <br>&gt; &gt; http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core<br>&gt; &gt; 6, and results are obviously the same using DENX4.0.<br>&gt; &gt; <br>&gt; &gt;
 --------------------<br>&gt; &gt; -bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot &amp;&amp;<br>&gt; &gt; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br>&gt; &gt; <br>&gt; &gt; real    1m15.059s<br>&gt; &gt; user    1m14.996s<br>&gt; &gt; sys     0m0.060s<br>&gt; &gt; -bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot &amp;&amp;<br>&gt; &gt; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br>&gt; &gt; <br>&gt; &gt; real    0m39.606s<br>&gt; &gt; user    0m39.552s<br>&gt; &gt; sys     0m0.028s<br>&gt; &gt; -bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot &amp;&amp;<br>&gt; &gt; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br>&gt; &gt; <br>&gt; &gt; real    1m15.016s<br>&gt; &gt; user    1m14.988s<br>&gt; &gt; sys     0m0.024s<br>&gt; &gt; -bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot &amp;&amp;<br>&gt; &gt; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br>&gt; &gt; <br>&gt; &gt; real    0m39.577s<br>&gt; &gt; user   
 0m39.544s<br>&gt; &gt; sys     0m0.032s<br>&gt; &gt; --------------------<br>&gt; &gt; <br>&gt; &gt; * I do not explain why not using FPU gives better results ?<br>&gt; &gt; <br>&gt; &gt; * I did also a test with bzip2.c<br>&gt; &gt; ( http://pag.csail.mit.edu/~smcc/projects/single-file-programs/bzip2.c ).<br>&gt; &gt; <br>&gt; &gt; ----------------------<br>&gt; &gt; -bash-3.00# gcc -O2 ./bzip2.c -o ./bzip2 &amp;&amp; time ./bzip2 ./oggenc.c<br>&gt; &gt; &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br>&gt; &gt; <br>&gt; &gt; real    0m18.478s<br>&gt; &gt; user    0m18.216s<br>&gt; &gt; sys     0m0.152s<br>&gt; &gt; -bash-3.00# gcc -O2 -mcpu=440 ./bzip2.c -o ./bzip2 &amp;&amp;<br>&gt; &gt; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br>&gt; &gt; <br>&gt; &gt; real    0m18.786s<br>&gt; &gt; user    0m18.544s<br>&gt; &gt; sys     0m0.128s<br>&gt; &gt; -bash-3.00# gcc -O2 -mcpu=440fp ./bzip2.c -o ./bzip2 &amp;&amp;<br>&gt;
 &gt; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br>&gt; &gt; <br>&gt; &gt; real    0m18.811s<br>&gt; &gt; user    0m18.548s<br>&gt; &gt; sys     0m0.144s<br>&gt; &gt; -bash-3.00# gcc -O2 -mcpu=G3 ./bzip2.c -o ./bzip2 &amp;&amp;<br>&gt; &gt; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br>&gt; &gt; <br>&gt; &gt; real    0m18.871s<br>&gt; &gt; user    0m18.644s<br>&gt; &gt; sys     0m0.104s<br>&gt; &gt; ----------------------<br>&gt; &gt; <br>&gt; &gt; * mcpu option seems to not have any effect ?<br>&gt; &gt; <br>&gt; &gt; *  My third test was to compile and run mplayer.<br>&gt; &gt; - With default options (no mcpu specified), my test mpeg was smooth.<br>&gt; &gt; - With mcpu=440fp, my test mpeg was not smooth.<br>&gt; &gt; <br>&gt; &gt;  Can anybody bring me some lights about the right gcc mcpu option for<br>&gt; &gt; amcc440 ?<br>&gt; &gt; <br>&gt; &gt; Best regards,<br>&gt; &gt; <br>&gt; &gt;   
     Patrice Bouchand<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; ______________________________________________________________________<br>&gt; &gt; Découvrez une nouvelle façon d'obtenir des réponses à toutes vos<br>&gt; &gt; questions ! Profitez des connaissances, des opinions et des<br>&gt; &gt; expériences des internautes sur Yahoo! Questions/Réponses.<br>&gt; &gt; _______________________________________________<br>&gt; &gt; Linuxppc-embedded mailing list<br>&gt; &gt; Linuxppc-embedded@ozlabs.org<br>&gt; &gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>&gt; <br>&gt; _______________________________________________<br>&gt; Linuxppc-embedded mailing list<br>&gt; Linuxppc-embedded@ozlabs.org<br>&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br></pb_fwd_list@yahoo.fr></blockquote><br><p>&#32;
		<hr size="1"> 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur <a href="http://fr.rd.yahoo.com/evt=42054/*http://fr.answers.yahoo.com">Yahoo! Questions/Réponses</a>.
--0-334689501-1172127479=:61964--
