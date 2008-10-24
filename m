Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id 18401DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 13:26:47 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so597139rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 19:26:46 -0700 (PDT)
Date: Thu, 23 Oct 2008 20:26:42 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: cuImage not building
Message-ID: <20081024022641.GA21389@secretlab.ca>
References: <423286.86157.qm@web46307.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <423286.86157.qm@web46307.mail.sp1.yahoo.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
