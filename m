Return-Path: <lk.atwork@yahoo.com>
Received: from n75.bullet.mail.sp1.yahoo.com (n75.bullet.mail.sp1.yahoo.com
	[98.136.44.51]) by ozlabs.org (Postfix) with SMTP id E1539DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Oct 2008 11:02:33 +1100 (EST)
Date: Fri, 24 Oct 2008 16:55:45 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: cuImage not building
Cc: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-525434489-1224892545=:1346"
Message-ID: <313034.1346.qm@web46303.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-525434489-1224892545=:1346
Content-Type: text/plain; charset=us-ascii



Thanks a lot Grant.
With your pointers I was able to fix the problem.

LK



________________________________
From: Grant Likely <grant.likely@secretlab.ca>
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Sent: Thursday, October 23, 2008 7:26:42 PM
Subject: Re: cuImage not building

On Thu, Oct 23, 2008 at 07:05:20PM -0700, Laxmikant Rashinkar wrote:
> Hi,
> 
> I have gotten our MPC8347 based board to work under Linux-2.6.27.1.
> 
> Since our board is similar to mpc834x_mds, I initially modified files relevant
> to mpc834x_mds to get our board working.
> 
> Now I'm trying to rename files so that they reflect our board names.
> 
> After this renaming, uImage gets built ok, but cuImage build fails. 
> I enabled make's verbose flag to see what was going on
> and here are the error messages
> 
> + powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.snsp arch/powerpc/boot/cuboot-snsp.o ./zImage.15886.o arch/powerpc/boot/wrapper.a
> powerpc-unknown-linux-gnu-ld: arch/powerpc/boot/cuboot-snsp.o: No such file: No such file or directory
> 
> Here is the build invocation with mpc834x_mds files.
> 
> + powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.mpc834x_mds arch/powerpc/boot/cuboot-83xx.o ./zImage.3158.o arch/powerpc/boot/wrapper.a
> 
> From the two invocations, not working code gets called with arch/powerpc/boot/cuboot-snsp.o
> whereas working code gets called with arch/powerpc/boot/cuboot-83xx.o.
> 
> I have made relevant changes to appropriate Makefiles, but I still cant get cuImage to build.

Look at Documentation/powerpc/bootwrapper.txt and
arch/powerpc/boot/wrapper.  There is some magic stuff in the wrapper
script which translates board names into the correct wrapper bits.  This
is particularly important for cuboot targets.

g.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



      
--0-525434489-1224892545=:1346
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div><br></div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">Thanks a lot Grant.<br>With your pointers I was able to fix the problem.<br><br>LK<br><br><div style="font-family: arial,helvetica,sans-serif; font-size: 12pt;"><font face="Tahoma" size="2"><hr size="1"><b><span style="font-weight: bold;">From:</span></b> Grant Likely &lt;grant.likely@secretlab.ca&gt;<br><b><span style="font-weight: bold;">To:</span></b> Laxmikant Rashinkar &lt;lk.atwork@yahoo.com&gt;<br><b><span style="font-weight: bold;">Cc:</span></b> linuxppc-embedded@ozlabs.org<br><b><span style="font-weight: bold;">Sent:</span></b> Thursday, October 23, 2008 7:26:42 PM<br><b><span style="font-weight: bold;">Subject:</span></b> Re: cuImage not building<br></font><br>
On Thu, Oct 23, 2008 at 07:05:20PM -0700, Laxmikant Rashinkar wrote:<br>&gt; Hi,<br>&gt; <br>&gt; I have gotten our MPC8347 based board to work under Linux-2.6.27.1.<br>&gt; <br>&gt; Since our board is similar to mpc834x_mds, I initially modified files relevant<br>&gt; to mpc834x_mds to get our board working.<br>&gt; <br>&gt; Now I'm trying to rename files so that they reflect our board names.<br>&gt; <br>&gt; After this renaming, uImage gets built ok, but cuImage build fails. <br>&gt; I enabled make's verbose flag to see what was going on<br>&gt; and here are the error messages<br>&gt; <br>&gt; + powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.snsp arch/powerpc/boot/cuboot-snsp.o ./zImage.15886.o arch/powerpc/boot/wrapper.a<br>&gt; powerpc-unknown-linux-gnu-ld: arch/powerpc/boot/cuboot-snsp.o: No such file: No such file or directory<br>&gt; <br>&gt; Here is the
 build invocation with mpc834x_mds files.<br>&gt; <br>&gt; + powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.mpc834x_mds arch/powerpc/boot/cuboot-83xx.o ./zImage.3158.o arch/powerpc/boot/wrapper.a<br>&gt; <br>&gt; From the two invocations, not working code gets called with arch/powerpc/boot/cuboot-snsp.o<br>&gt; whereas working code gets called with arch/powerpc/boot/cuboot-83xx.o.<br>&gt; <br>&gt; I have made relevant changes to appropriate Makefiles, but I still cant get cuImage to build.<br><br>Look at Documentation/powerpc/bootwrapper.txt and<br>arch/powerpc/boot/wrapper.&nbsp; There is some magic stuff in the wrapper<br>script which translates board names into the correct wrapper bits.&nbsp; This<br>is particularly important for cuboot targets.<br><br>g.<br><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a
 ymailto="mailto:Linuxppc-embedded@ozlabs.org" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></div></div></div><br>

      </body></html>
--0-525434489-1224892545=:1346--
