Return-Path: <pb_fwd_list@yahoo.fr>
Received: from web23412.mail.ird.yahoo.com (web23412.mail.ird.yahoo.com
	[217.146.189.97]) by ozlabs.org (Postfix) with SMTP id 906BBDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Feb 2007 19:51:45 +1100 (EST)
Date: Mon, 19 Feb 2007 09:45:04 +0100 (CET)
From: Patrice Bouchand <pb_fwd_list@yahoo.fr>
Subject: mcpu options for AMCC440 with fpu
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1467494991-1171874704=:55072"
Message-ID: <600461.55072.qm@web23412.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1467494991-1171874704=:55072
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,

   I was searching for the best mcpu option for amcc440, compiling and running a small program you can find here: 
http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core 6, and results are obviously the same using DENX4.0.

--------------------
-bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    1m15.059s
user    1m14.996s
sys     0m0.060s
-bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    0m39.606s
user    0m39.552s
sys     0m0.028s
-bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    1m15.016s
user    1m14.988s
sys     0m0.024s
-bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot && time ./mandelbrot && rm -f ./mandelbrot

real    0m39.577s
user    0m39.544s
sys     0m0.032s
--------------------

* I do not explain why not using FPU gives better results ?

* I did also a test with bzip2.c ( http://pag.csail.mit.edu/~smcc/projects/single-file-programs/bzip2.c ).

----------------------
-bash-3.00# gcc -O2 ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2

real    0m18.478s
user    0m18.216s
sys     0m0.152s
-bash-3.00# gcc -O2 -mcpu=440 ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2

real    0m18.786s
user    0m18.544s
sys     0m0.128s
-bash-3.00# gcc -O2 -mcpu=440fp ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2

real    0m18.811s
user    0m18.548s
sys     0m0.144s
-bash-3.00# gcc -O2 -mcpu=G3 ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2

real    0m18.871s
user    0m18.644s
sys     0m0.104s
----------------------

* mcpu option seems to not have any effect ?

*  My third test was to compile and run mplayer.
- With default options (no mcpu specified), my test mpeg was smooth.
- With mcpu=440fp, my test mpeg was not smooth.

 Can anybody bring me some lights about the right gcc mcpu option for amcc440 ?

Best regards,

       Patrice Bouchand


 		
---------------------------------
 Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses.
--0-1467494991-1171874704=:55072
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,<br><br>&nbsp;&nbsp; I was searching for the best mcpu option for amcc440, compiling and running a small program you can find here: <br>http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core 6, and results are obviously the same using DENX4.0.<br><br>--------------------<br>-bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 1m15.059s<br>user&nbsp;&nbsp;&nbsp; 1m14.996s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.060s<br>-bash-3.00# gcc -O2 -mcpu=440 ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 0m39.606s<br>user&nbsp;&nbsp;&nbsp; 0m39.552s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.028s<br>-bash-3.00# gcc -O2 -mcpu=440fp ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 1m15.016s<br>user&nbsp;&nbsp;&nbsp;
 1m14.988s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.024s<br>-bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot &amp;&amp; time ./mandelbrot &amp;&amp; rm -f ./mandelbrot<br><br>real&nbsp;&nbsp;&nbsp; 0m39.577s<br>user&nbsp;&nbsp;&nbsp; 0m39.544s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.032s<br>--------------------<br><br>* I do not explain why not using FPU gives better results ?<br><br>* I did also a test with bzip2.c ( http://pag.csail.mit.edu/~smcc/projects/single-file-programs/bzip2.c ).<br><br>----------------------<br>-bash-3.00# gcc -O2 ./bzip2.c -o ./bzip2 &amp;&amp; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br><br>real&nbsp;&nbsp;&nbsp; 0m18.478s<br>user&nbsp;&nbsp;&nbsp; 0m18.216s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.152s<br>-bash-3.00# gcc -O2 -mcpu=440 ./bzip2.c -o ./bzip2 &amp;&amp; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br><br>real&nbsp;&nbsp;&nbsp;
 0m18.786s<br>user&nbsp;&nbsp;&nbsp; 0m18.544s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.128s<br>-bash-3.00# gcc -O2 -mcpu=440fp ./bzip2.c -o ./bzip2 &amp;&amp; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br><br>real&nbsp;&nbsp;&nbsp; 0m18.811s<br>user&nbsp;&nbsp;&nbsp; 0m18.548s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.144s<br>-bash-3.00# gcc -O2 -mcpu=G3 ./bzip2.c -o ./bzip2 &amp;&amp; time ./bzip2 ./oggenc.c &amp;&amp; ./bzip2 -d ./oggenc.c.bz2 &amp;&amp; rm ./bzip2<br><br>real&nbsp;&nbsp;&nbsp; 0m18.871s<br>user&nbsp;&nbsp;&nbsp; 0m18.644s<br>sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.104s<br>----------------------<br><br>* mcpu option seems to not have any effect ?<br><br>*&nbsp; My third test was to compile and run mplayer.<br>- With default options (no mcpu specified), my test mpeg was smooth.<br>- With mcpu=440fp, my test mpeg was not smooth.<br><br>&nbsp;Can anybody bring me some lights about the right gcc mcpu option for amcc440 ?<br><br>Best
 regards,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Patrice Bouchand<br><br><p>&#32;
		<hr size="1"> 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur <a href="http://fr.rd.yahoo.com/evt=42054/*http://fr.answers.yahoo.com">Yahoo! Questions/Réponses</a>.
--0-1467494991-1171874704=:55072--
