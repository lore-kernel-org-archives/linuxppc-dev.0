Return-Path: <Srivatsan.CR@in.flextronics.com>
Received: from bglnt005.asia.ad.flextronics.com (unknown [203.145.155.1])
	by ozlabs.org (Postfix) with ESMTP id BA2C967F46
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 23:18:39 +1000 (EST)
Message-ID: <3B58B875DBDE504F94D2A1A1C9DF6F1F01DF3F65@bglnt005.asia.ad.flextronics.com>
From: Srivatsan CR <Srivatsan.CR@in.flextronics.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 8 Aug 2005 18:48:36 +0530 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59C1B.AECD5730"
Subject: [Newbie] Question on m8260_gorom
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C59C1B.AECD5730
Content-Type: text/plain;
	charset="iso-8859-1"

Dear all,

      1) I am using a LinuxPPC kernel version 2.4.18 and on a MPC8280
processor.
      2) I am assuming that the Linux memory map for PowerPC looks like the
following:

          
END_OF_RAM|---------------|
          |               |
          |               |
          |               |
          |               |
          |               |
          |               |
  0x800000|---------------|
          |Linux-PPC      |
          |Kernel         |
          |               |
      0x0 |---------------|

    Even at the run-time the kernel code resides in the Ram from address 0x0
till 8MB. In m8260_gorom the start_addr variable is initialized to 0x0  but
Kernel is not booting. Actually we are trying to boot the Linux Kernel from
its RAM copy at the time of exception.

      3) An Kernel stack overflow was generated . So that the control enters
m8260_gorom. On entering m8260_gorom it executes till RFI after that the
control gets inside my_console_write. This happens even before we execute
the mtlr r4 and blr opcodes. So something else is creating the exception
which is making the code to dump exception on the console. (Not sure what it
is?)

     4) Questions are :

             a) Is it possible to start from Ram copy of the Linux kernel
Image at an exception generated restart 
                mechanism ? 
             B) Has anyone encountered a situation like the one described
above and can anyone tell us what is the cause 
                of the exception. (It's always printing "Bad kernel page
access")

Thanks for all your time. 


With Best Regards,
C.R.Srivatsan
             

-----Original Message-----
From: linuxppc-embedded-request@ozlabs.org
[mailto:linuxppc-embedded-request@ozlabs.org] 
Sent: Monday, August 08, 2005 7:19 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 12, Issue 25

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. Re: [PATCH] 8xx: add cpm_get_cpmp() (Dan Malek)
   2. Re: [PATCH] 8xx: add cpm_get_cpmp() (Dan Malek)
   3. Re: [PATCH] 8xx: add cpm_get_cpmp() (Marcelo Tosatti)
   4. A configure error for samba3 on ppc (JohnsonCheng)
   5. Re: [PATCH] 8xx: add cpm_get_cpmp() (Dan Malek)
   6. Re: [PATCH] 8xx: add cpm_get_cpmp()
      (Aristeu Sergio Rozanski Filho)
   7. Re: [PATCH] 8xx: add cpm_get_cpmp() (Marcelo Tosatti)
   8. Re: [PATCH] 8xx: add cpm_get_cpmp() (Dan Malek)
   9. Re: [PATCH] 8xx: add cpm_get_cpmp() (Eugene Surovegin)
  10. Re: Volunteers to test i2c-algo-8xx on v2.6? (Debora Liu)


----------------------------------------------------------------------

Message: 1
Date: Sat, 6 Aug 2005 22:40:37 -0400
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Aug 6, 2005, at 7:27 PM, Marcelo Tosatti wrote:

> It already is exported, declared as
>
> commproc.h:extern       cpm8xx_t        *cpmp;          /* Pointer to 
> comm processor */
>
>
> and many drivers use the pointer directly.

We shouldn't be doing this.  All drivers should ioremap() any peripheral
spaces they use and not make any assumptions someone else has done that
already.  We've been making such changes in the 82xx/83xx/85xx CPM2 drivers.
If it isn't convenient to find the #defines for the ioremap(), we should
change that.  When I originally wrote all of this code, it was long ago when
we didn't have some of the abstractions and it seemed any shortcuts for
performance were desired :-)


> arch/ppc/8260_io/ drivers also use the same convention.

If there are any drivers in here, they either aren't used or on their way
out.  The only things that should remain are common support functions.


Thanks.

	-- Dan



------------------------------

Message: 2
Date: Sat, 6 Aug 2005 23:36:16 -0400
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <d74e24bbf82e4cedd3358465343d28ae@embeddededge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Aug 6, 2005, at 7:42 PM, Aristeu Sergio Rozanski Filho wrote:

> but not with EXPORT_SYMBOL(). I noticed this while compiling i2c stuff 
> as module. also, I think it's better add a function to do this instead 
> doing EXPORT_SYMBOL() in a variable.

Right.  We should just ioremap() :-)

Thanks.

	-- Dan



------------------------------

Message: 3
Date: Sun, 7 Aug 2005 01:31:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20050807043110.GA6316@dmt.cnet>
Content-Type: text/plain; charset=us-ascii

On Sat, Aug 06, 2005 at 10:40:37PM -0400, Dan Malek wrote:
> 
> On Aug 6, 2005, at 7:27 PM, Marcelo Tosatti wrote:
> 
> >It already is exported, declared as
> >
> >commproc.h:extern       cpm8xx_t        *cpmp;          /* Pointer to 
> >comm processor */
> >
> >
> >and many drivers use the pointer directly.
> 
> We shouldn't be doing this.  All drivers should ioremap() any 
> peripheral spaces they use and not make any assumptions someone else 
> has done that already.  We've been making such changes in the 
> 82xx/83xx/85xx CPM2 drivers.  If it isn't convenient to find the 
> #defines for the ioremap(), we should change that.  When I originally 
> wrote all of this code, it was long ago when we didn't have some of 
> the abstractions and it seemed any shortcuts for performance were 
> desired :-)

OK makes sense (yep it was even discussed already).

Aris, sounds like you should proceed with cpm_get_cpmp() and change all
other drivers using it also.

> 
> 
> >arch/ppc/8260_io/ drivers also use the same convention.
> 
> If there are any drivers in here, they either aren't used or on their 
> way out.  The only things that should remain are common support 
> functions.

OK!


------------------------------

Message: 4
Date: Sun, 7 Aug 2005 17:15:55 +0800
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
Subject: A configure error for samba3 on ppc
To: <linuxppc-embedded@ozlabs.org>
Message-ID: <20050807091603.CE57667F29@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"

When I configure samba3.0.10 on ppc as following command:

CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
./configure -host=powerpc-linux

 

I got a configure error message as following:

Configure: error: cannot run test program while cross compiling

See 'config.log' for more details

 

I think this is a samba configure bug, do anybody know how to pass it?

 

Thanks,

Johnson Cheng

-------------- next part --------------
An HTML attachment was scrubbed...
URL:
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20050807/95f23597/
attachment-0001.htm

------------------------------

Message: 5
Date: Sun, 7 Aug 2005 11:39:52 -0400
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <09b0792f426f1d5883cf5d437723f075@embeddededge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Aug 7, 2005, at 12:31 AM, Marcelo Tosatti wrote:

> Aris, sounds like you should proceed with cpm_get_cpmp() and change 
> all other drivers using it also.

It depends how you define the semantics of this function call.
Can you call it any (and all of the) time you need it, or does it actually
perform an ioremap() and you only want to call it once?

I guess implemented properly it doesn't matter.  On the first call it should
do the ioremap() and on subsequent calls it just returns the mapping.  This
is one of those common functions that should be in commproc.c.

Thanks.

	-- Dan



------------------------------

Message: 6
Date: Sun, 7 Aug 2005 12:44:32 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20050807154432.GE5210@cathedrallabs.org>
Content-Type: text/plain; charset=us-ascii

> It depends how you define the semantics of this function call.
> Can you call it any (and all of the) time you need it, or does it 
> actually perform an ioremap() and you only want to call it once?
what about don't cache it and call ioremap() from driver? (I guess
ioremap() already check if an area is already mapped, no?)

--
Aristeu



------------------------------

Message: 7
Date: Sun, 7 Aug 2005 12:57:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20050807155731.GA2715@dmt.cnet>
Content-Type: text/plain; charset=us-ascii

On Sun, Aug 07, 2005 at 12:44:32PM -0300, Aristeu Sergio Rozanski Filho
wrote:
> > It depends how you define the semantics of this function call.
> > Can you call it any (and all of the) time you need it, or does it 
> > actually perform an ioremap() and you only want to call it once?
> what about don't cache it and call ioremap() from driver? (I guess
> ioremap() already check if an area is already mapped, no?)

Yep, ioremap() should be doing virtual address caching already, no?


------------------------------

Message: 8
Date: Sun, 7 Aug 2005 13:25:34 -0400
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <2fcd8a329246b2f2c303e515dd0cb7bf@embeddededge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Aug 7, 2005, at 11:44 AM, Aristeu Sergio Rozanski Filho wrote:

> what about don't cache it and call ioremap() from driver? (I guess
> ioremap() already check if an area is already mapped, no?)

Either way.  I'm actually leaning toward these "pointer helper"
functions. :-)  Something like get_cpmp(), or get_immr(), that will hide the
details of the mapping, so you don't have to include and know which #defines
to use as part of an ioremap() call.

It seems to be more clear to me, and I'm thinking about making the same
changes to the CPM2 drivers.  It also allows a performance versus compact
code trade off, declaring these as inline functions or as real functions.

Thanks.

	-- Dan



------------------------------

Message: 9
Date: Sun, 7 Aug 2005 12:18:29 -0700
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20050807191829.GA5375@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii

On Sun, Aug 07, 2005 at 12:57:31PM -0300, Marcelo Tosatti wrote:
> On Sun, Aug 07, 2005 at 12:44:32PM -0300, Aristeu Sergio Rozanski Filho
wrote:
> > > It depends how you define the semantics of this function call.
> > > Can you call it any (and all of the) time you need it, or does it 
> > > actually perform an ioremap() and you only want to call it once?
> > what about don't cache it and call ioremap() from driver? (I guess
> > ioremap() already check if an area is already mapped, no?)
> 
> Yep, ioremap() should be doing virtual address caching already, no?

In general, ioremap() doesn't do any caching currently. Some subarchs do
some limited caching, e.g. if BATs (classic PPC) or CAMs (e500) are
available and were used previously for ioremap() mappings. 

Some time ago I made a trivial ioremap cache patch (useful on 4xx, which
doesn't have BATs nor CAMs), although it wass really a hack and it was never
merged :).

--
Eugene



------------------------------

Message: 10
Date: Mon, 8 Aug 2005 09:53:32 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
Subject: Re: Volunteers to test i2c-algo-8xx on v2.6?
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Message-ID: <20050808014920.0373467F1E@ozlabs.org>

Hello, Marcelo Tosatti

In message <2005-08-07 08:34:52 marcelo.tosatti@cyclades.com> you wrote:
>
>Does anyone volunteer to test this 8xx i2c driver?
>
>
I don't have kernel v2.6, but I have test my board with eldk-3.1.1
linux-2.4.25
when my board kernel booting, I found one problem.
eldk-3.1.1 linux-2.4.25 kernel include i2c, i2c-algo-8xx, pcf8563 driver.
If one pcf8563 chip on my board, there are't problem.
But if my board don't have pcf8563 chip, kernel stop as blow:
Linux version 2.4.25 (liu@bighead) (gcc version 3.3.3 (DENX ELDK 3.1.1
3.3.3-9))
#4 励 7埖 29 12:19:14 CST 2005
m8xx_setup.c:Reserved 0x10000 memory at 0xc0190000
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nftla1
ip=192.168.0.207:192.168.0.82:::sc855t:eth
0:off
Decrementer Frequency = 300000000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 79.66 BogoMIPS
========= HZ=100   loops_per_jiffy=398336
Memory: 30752k available (1144k kernel code, 356k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
WDT_8xx: SWT not enabled by firmware, SYPCR=0xffffff88
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
      Starting kswapd
Journalled Block Device driver loaded
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
i2c-algo-8xx.o: i2c mpc8xx algorithm module version 2.6.1 (20010830)
i2c-rpx.o: i2c MPC8xx module version 2.6.1 (20010830)
i2c-proc.o version 2.6.1 (20010830)
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0380 is on SMC2 using BRG2
pty: 256 Unix98 ptys configured
PCF8563 Real-Time Clock Driver $Revision: 1.3 $ wd@denx.de



I modify i2c-algo-8xx.c cpm_iic_write(), then no problem,
my board defined by CONFIG_SVM8xx

#ifdef CONFIG_SVM8xx
    while(!(i2c->i2c_i2cer & 0x12))
      if (time_after(jiffies, tmo)) {
        tmo = 0;
        break;
      }
#else
                while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo)));
/* Bus
#endif



= = = = = = = = = = = = = = = = = = = =
				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-08





------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 12, Issue 25
*************************************************

------_=_NextPart_001_01C59C1B.AECD5730
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>[Newbie] Question on m8260_gorom</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Dear all,</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) I am using a =
LinuxPPC kernel version 2.4.18 and on a MPC8280 processor.</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) I am assuming that =
the Linux memory map for PowerPC looks like the following:</FONT>
</P>

<P><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>END_OF_RAM|---------------|</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT SIZE=3D2>&nbsp; 0x800000|---------------|</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|Linux-PPC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|Kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0 =
|---------------|</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Even at the run-time the kernel =
code resides in the Ram from address 0x0 till 8MB. In m8260_gorom the =
start_addr variable is initialized to 0x0&nbsp; but Kernel is not =
booting. Actually we are trying to boot the Linux Kernel from its RAM =
copy at the time of exception.</FONT></P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3) An Kernel stack =
overflow was generated . So that the control enters m8260_gorom. On =
entering m8260_gorom it executes till RFI after that the control gets =
inside my_console_write. This happens even before we execute the mtlr =
r4 and blr opcodes. So something else is creating the exception which =
is making the code to dump exception on the console. (Not sure what it =
is?)</FONT></P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; 4) Questions are :</FONT>
</P>

<P><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; a) Is it possible to start from Ram copy of the Linux kernel =
Image at an exception generated restart </FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mechanism ? </FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; B) Has anyone encountered a situation like the one described =
above and can anyone tell us what is the cause </FONT></P>

<P><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; of the exception. (It's always printing =
&quot;Bad kernel page access&quot;)</FONT>
</P>

<P><FONT SIZE=3D2>Thanks for all your time. </FONT>
</P>
<BR>

<P><FONT SIZE=3D2>With Best Regards,</FONT>
<BR><FONT SIZE=3D2>C.R.Srivatsan</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: linuxppc-embedded-request@ozlabs.org [<A =
HREF=3D"mailto:linuxppc-embedded-request@ozlabs.org">mailto:linuxppc-emb=
edded-request@ozlabs.org</A>] </FONT>
<BR><FONT SIZE=3D2>Sent: Monday, August 08, 2005 7:19 AM</FONT>
<BR><FONT SIZE=3D2>To: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Subject: Linuxppc-embedded Digest, Vol 12, Issue =
25</FONT>
</P>

<P><FONT SIZE=3D2>Send Linuxppc-embedded mailing list submissions =
to</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
SIZE=3D2>linuxppc-embedded@ozlabs.org</FONT>
</P>

<P><FONT SIZE=3D2>To subscribe or unsubscribe via the World Wide Web, =
visit</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2><A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" =
TARGET=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded<=
/A></FONT>
<BR><FONT SIZE=3D2>or, via email, send a message with subject or body =
'help' to</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
SIZE=3D2>linuxppc-embedded-request@ozlabs.org</FONT>
</P>

<P><FONT SIZE=3D2>You can reach the person managing the list at</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
SIZE=3D2>linuxppc-embedded-owner@ozlabs.org</FONT>
</P>

<P><FONT SIZE=3D2>When replying, please edit your Subject line so it is =
more specific than &quot;Re: Contents of Linuxppc-embedded =
digest...&quot;</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Today's Topics:</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp; 1. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Dan Malek)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 2. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Dan Malek)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 3. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Marcelo Tosatti)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 4. A configure error for samba3 on ppc =
(JohnsonCheng)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 5. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Dan Malek)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 6. Re: [PATCH] 8xx: add =
cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Aristeu Sergio =
Rozanski Filho)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 7. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Marcelo Tosatti)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 8. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Dan Malek)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp; 9. Re: [PATCH] 8xx: add cpm_get_cpmp() =
(Eugene Surovegin)</FONT>
<BR><FONT SIZE=3D2>&nbsp; 10. Re: Volunteers to test i2c-algo-8xx on =
v2.6? (Debora Liu)</FONT>
</P>
<BR>

<P><FONT =
SIZE=3D2>---------------------------------------------------------------=
-------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 1</FONT>
<BR><FONT SIZE=3D2>Date: Sat, 6 Aug 2005 22:40:37 -0400</FONT>
<BR><FONT SIZE=3D2>From: Dan Malek &lt;dan@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Marcelo Tosatti =
&lt;marcelo.tosatti@cyclades.com&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3DUS-ASCII; =
format=3Dflowed</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Aug 6, 2005, at 7:27 PM, Marcelo Tosatti =
wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; It already is exported, declared as</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; =
commproc.h:extern&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cpm8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*cpmp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Pointer =
to </FONT>
<BR><FONT SIZE=3D2>&gt; comm processor */</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; and many drivers use the pointer =
directly.</FONT>
</P>

<P><FONT SIZE=3D2>We shouldn't be doing this.&nbsp; All drivers should =
ioremap() any peripheral spaces they use and not make any assumptions =
someone else has done that already.&nbsp; We've been making such =
changes in the 82xx/83xx/85xx CPM2 drivers.&nbsp; If it isn't =
convenient to find the #defines for the ioremap(), we should change =
that.&nbsp; When I originally wrote all of this code, it was long ago =
when we didn't have some of the abstractions and it seemed any =
shortcuts for performance were desired :-)</FONT></P>
<BR>

<P><FONT SIZE=3D2>&gt; arch/ppc/8260_io/ drivers also use the same =
convention.</FONT>
</P>

<P><FONT SIZE=3D2>If there are any drivers in here, they either aren't =
used or on their way out.&nbsp; The only things that should remain are =
common support functions.</FONT></P>
<BR>

<P><FONT SIZE=3D2>Thanks.</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>-- =
Dan</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 2</FONT>
<BR><FONT SIZE=3D2>Date: Sat, 6 Aug 2005 23:36:16 -0400</FONT>
<BR><FONT SIZE=3D2>From: Dan Malek &lt;dan@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Aristeu Sergio Rozanski Filho =
&lt;aris@cathedrallabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;d74e24bbf82e4cedd3358465343d28ae@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3DUS-ASCII; =
format=3Dflowed</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Aug 6, 2005, at 7:42 PM, Aristeu Sergio Rozanski =
Filho wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; but not with EXPORT_SYMBOL(). I noticed this =
while compiling i2c stuff </FONT>
<BR><FONT SIZE=3D2>&gt; as module. also, I think it's better add a =
function to do this instead </FONT>
<BR><FONT SIZE=3D2>&gt; doing EXPORT_SYMBOL() in a variable.</FONT>
</P>

<P><FONT SIZE=3D2>Right.&nbsp; We should just ioremap() :-)</FONT>
</P>

<P><FONT SIZE=3D2>Thanks.</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>-- =
Dan</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 3</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 01:31:10 -0300</FONT>
<BR><FONT SIZE=3D2>From: Marcelo Tosatti =
&lt;marcelo.tosatti@cyclades.com&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Dan Malek &lt;dan@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;20050807043110.GA6316@dmt.cnet&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3Dus-ascii</FONT>
</P>

<P><FONT SIZE=3D2>On Sat, Aug 06, 2005 at 10:40:37PM -0400, Dan Malek =
wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; On Aug 6, 2005, at 7:27 PM, Marcelo Tosatti =
wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;It already is exported, declared as</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; =
&gt;commproc.h:extern&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cpm8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*cpmp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Pointer =
to </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;comm processor */</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;and many drivers use the pointer =
directly.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; We shouldn't be doing this.&nbsp; All drivers =
should ioremap() any </FONT>
<BR><FONT SIZE=3D2>&gt; peripheral spaces they use and not make any =
assumptions someone else </FONT>
<BR><FONT SIZE=3D2>&gt; has done that already.&nbsp; We've been making =
such changes in the </FONT>
<BR><FONT SIZE=3D2>&gt; 82xx/83xx/85xx CPM2 drivers.&nbsp; If it isn't =
convenient to find the </FONT>
<BR><FONT SIZE=3D2>&gt; #defines for the ioremap(), we should change =
that.&nbsp; When I originally </FONT>
<BR><FONT SIZE=3D2>&gt; wrote all of this code, it was long ago when we =
didn't have some of </FONT>
<BR><FONT SIZE=3D2>&gt; the abstractions and it seemed any shortcuts =
for performance were </FONT>
<BR><FONT SIZE=3D2>&gt; desired :-)</FONT>
</P>

<P><FONT SIZE=3D2>OK makes sense (yep it was even discussed =
already).</FONT>
</P>

<P><FONT SIZE=3D2>Aris, sounds like you should proceed with =
cpm_get_cpmp() and change all other drivers using it also.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;arch/ppc/8260_io/ drivers also use the same =
convention.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; If there are any drivers in here, they either =
aren't used or on their </FONT>
<BR><FONT SIZE=3D2>&gt; way out.&nbsp; The only things that should =
remain are common support </FONT>
<BR><FONT SIZE=3D2>&gt; functions.</FONT>
</P>

<P><FONT SIZE=3D2>OK!</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 4</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 17:15:55 +0800</FONT>
<BR><FONT SIZE=3D2>From: &quot;JohnsonCheng&quot; =
&lt;johnsoncheng@qnap.com.tw&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: A configure error for samba3 on ppc</FONT>
<BR><FONT SIZE=3D2>To: &lt;linuxppc-embedded@ozlabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;20050807091603.CE57667F29@ozlabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; =
charset=3D&quot;us-ascii&quot;</FONT>
</P>

<P><FONT SIZE=3D2>When I configure samba3.0.10 on ppc as following =
command:</FONT>
</P>

<P><FONT SIZE=3D2>CC=3Dpowerpc-linux-gcc AR=3Dpowerpc-linux-ar =
RANLIB=3Dpowerpc-linux-ranlib ./configure -host=3Dpowerpc-linux</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>I got a configure error message as following:</FONT>
</P>

<P><FONT SIZE=3D2>Configure: error: cannot run test program while cross =
compiling</FONT>
</P>

<P><FONT SIZE=3D2>See 'config.log' for more details</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>I think this is a samba configure bug, do anybody =
know how to pass it?</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>Thanks,</FONT>
</P>

<P><FONT SIZE=3D2>Johnson Cheng</FONT>
</P>

<P><FONT SIZE=3D2>-------------- next part --------------</FONT>
<BR><FONT SIZE=3D2>An HTML attachment was scrubbed...</FONT>
<BR><FONT SIZE=3D2>URL: <A =
HREF=3D"http://ozlabs.org/pipermail/linuxppc-embedded/attachments/200508=
07/95f23597/attachment-0001.htm" =
TARGET=3D"_blank">http://ozlabs.org/pipermail/linuxppc-embedded/attachme=
nts/20050807/95f23597/attachment-0001.htm</A></FONT>
</P>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 5</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 11:39:52 -0400</FONT>
<BR><FONT SIZE=3D2>From: Dan Malek &lt;dan@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Marcelo Tosatti =
&lt;marcelo.tosatti@cyclades.com&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;09b0792f426f1d5883cf5d437723f075@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3DUS-ASCII; =
format=3Dflowed</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Aug 7, 2005, at 12:31 AM, Marcelo Tosatti =
wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Aris, sounds like you should proceed with =
cpm_get_cpmp() and change </FONT>
<BR><FONT SIZE=3D2>&gt; all other drivers using it also.</FONT>
</P>

<P><FONT SIZE=3D2>It depends how you define the semantics of this =
function call.</FONT>
<BR><FONT SIZE=3D2>Can you call it any (and all of the) time you need =
it, or does it actually perform an ioremap() and you only want to call =
it once?</FONT></P>

<P><FONT SIZE=3D2>I guess implemented properly it doesn't matter.&nbsp; =
On the first call it should do the ioremap() and on subsequent calls it =
just returns the mapping.&nbsp; This is one of those common functions =
that should be in commproc.c.</FONT></P>

<P><FONT SIZE=3D2>Thanks.</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>-- =
Dan</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 6</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 12:44:32 -0300</FONT>
<BR><FONT SIZE=3D2>From: Aristeu Sergio Rozanski Filho =
&lt;aris@cathedrallabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Dan Malek &lt;dan@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;20050807154432.GE5210@cathedrallabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3Dus-ascii</FONT>
</P>

<P><FONT SIZE=3D2>&gt; It depends how you define the semantics of this =
function call.</FONT>
<BR><FONT SIZE=3D2>&gt; Can you call it any (and all of the) time you =
need it, or does it </FONT>
<BR><FONT SIZE=3D2>&gt; actually perform an ioremap() and you only want =
to call it once?</FONT>
<BR><FONT SIZE=3D2>what about don't cache it and call ioremap() from =
driver? (I guess</FONT>
<BR><FONT SIZE=3D2>ioremap() already check if an area is already =
mapped, no?)</FONT>
</P>

<P><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>Aristeu</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 7</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 12:57:31 -0300</FONT>
<BR><FONT SIZE=3D2>From: Marcelo Tosatti =
&lt;marcelo.tosatti@cyclades.com&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Aristeu Sergio Rozanski Filho =
&lt;aris@cathedrallabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;20050807155731.GA2715@dmt.cnet&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3Dus-ascii</FONT>
</P>

<P><FONT SIZE=3D2>On Sun, Aug 07, 2005 at 12:44:32PM -0300, Aristeu =
Sergio Rozanski Filho wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; It depends how you define the semantics of =
this function call.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Can you call it any (and all of the) time =
you need it, or does it </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; actually perform an ioremap() and you only =
want to call it once?</FONT>
<BR><FONT SIZE=3D2>&gt; what about don't cache it and call ioremap() =
from driver? (I guess</FONT>
<BR><FONT SIZE=3D2>&gt; ioremap() already check if an area is already =
mapped, no?)</FONT>
</P>

<P><FONT SIZE=3D2>Yep, ioremap() should be doing virtual address =
caching already, no?</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 8</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 13:25:34 -0400</FONT>
<BR><FONT SIZE=3D2>From: Dan Malek &lt;dan@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Aristeu Sergio Rozanski Filho =
&lt;aris@cathedrallabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;2fcd8a329246b2f2c303e515dd0cb7bf@embeddededge.com&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3DUS-ASCII; =
format=3Dflowed</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Aug 7, 2005, at 11:44 AM, Aristeu Sergio Rozanski =
Filho wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; what about don't cache it and call ioremap() =
from driver? (I guess</FONT>
<BR><FONT SIZE=3D2>&gt; ioremap() already check if an area is already =
mapped, no?)</FONT>
</P>

<P><FONT SIZE=3D2>Either way.&nbsp; I'm actually leaning toward these =
&quot;pointer helper&quot;</FONT>
<BR><FONT SIZE=3D2>functions. :-)&nbsp; Something like get_cpmp(), or =
get_immr(), that will hide the details of the mapping, so you don't =
have to include and know which #defines to use as part of an ioremap() =
call.</FONT></P>

<P><FONT SIZE=3D2>It seems to be more clear to me, and I'm thinking =
about making the same changes to the CPM2 drivers.&nbsp; It also allows =
a performance versus compact code trade off, declaring these as inline =
functions or as real functions.</FONT></P>

<P><FONT SIZE=3D2>Thanks.</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>-- =
Dan</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 9</FONT>
<BR><FONT SIZE=3D2>Date: Sun, 7 Aug 2005 12:18:29 -0700</FONT>
<BR><FONT SIZE=3D2>From: Eugene Surovegin =
&lt;ebs@ebshome.net&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()</FONT>
<BR><FONT SIZE=3D2>To: Marcelo Tosatti =
&lt;marcelo.tosatti@cyclades.com&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;20050807191829.GA5375@gate.ebshome.net&gt;</FONT>
<BR><FONT SIZE=3D2>Content-Type: text/plain; charset=3Dus-ascii</FONT>
</P>

<P><FONT SIZE=3D2>On Sun, Aug 07, 2005 at 12:57:31PM -0300, Marcelo =
Tosatti wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; On Sun, Aug 07, 2005 at 12:44:32PM -0300, =
Aristeu Sergio Rozanski Filho wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; It depends how you define the =
semantics of this function call.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; Can you call it any (and all of the) =
time you need it, or does it </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; actually perform an ioremap() and you =
only want to call it once?</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; what about don't cache it and call =
ioremap() from driver? (I guess</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; ioremap() already check if an area is =
already mapped, no?)</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Yep, ioremap() should be doing virtual address =
caching already, no?</FONT>
</P>

<P><FONT SIZE=3D2>In general, ioremap() doesn't do any caching =
currently. Some subarchs do some limited caching, e.g. if BATs (classic =
PPC) or CAMs (e500) are available and were used previously for =
ioremap() mappings. </FONT></P>

<P><FONT SIZE=3D2>Some time ago I made a trivial ioremap cache patch =
(useful on 4xx, which doesn't have BATs nor CAMs), although it wass =
really a hack and it was never merged :).</FONT></P>

<P><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>Eugene</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT SIZE=3D2>Message: 10</FONT>
<BR><FONT SIZE=3D2>Date: Mon, 8 Aug 2005 09:53:32 +0800</FONT>
<BR><FONT SIZE=3D2>From: &quot;Debora Liu&quot; =
&lt;deboralh@fel.com.cn&gt;</FONT>
<BR><FONT SIZE=3D2>Subject: Re: Volunteers to test i2c-algo-8xx on =
v2.6?</FONT>
<BR><FONT SIZE=3D2>To: &quot;Marcelo Tosatti&quot; =
&lt;marcelo.tosatti@cyclades.com&gt;</FONT>
<BR><FONT SIZE=3D2>Cc: Linuxppc-embedded =
&lt;Linuxppc-embedded@ozlabs.org&gt;</FONT>
<BR><FONT SIZE=3D2>Message-ID: =
&lt;20050808014920.0373467F1E@ozlabs.org&gt;</FONT>
</P>

<P><FONT SIZE=3D2>Hello, Marcelo Tosatti</FONT>
</P>

<P><FONT SIZE=3D2>In message &lt;2005-08-07 08:34:52 =
marcelo.tosatti@cyclades.com&gt; you wrote:</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt;Does anyone volunteer to test this 8xx i2c =
driver?</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>I don't have kernel v2.6, but I have test my board =
with eldk-3.1.1 linux-2.4.25</FONT>
<BR><FONT SIZE=3D2>when my board kernel booting, I found one =
problem.</FONT>
<BR><FONT SIZE=3D2>eldk-3.1.1 linux-2.4.25 kernel include i2c, =
i2c-algo-8xx, pcf8563 driver.</FONT>
<BR><FONT SIZE=3D2>If one pcf8563 chip on my board, there are't =
problem.</FONT>
<BR><FONT SIZE=3D2>But if my board don't have pcf8563 chip, kernel stop =
as blow:</FONT>
<BR><FONT SIZE=3D2>Linux version 2.4.25 (liu@bighead) (gcc version =
3.3.3 (DENX ELDK 3.1.1 3.3.3-9))</FONT>
<BR><FONT SIZE=3D2>#4 =CE=E5 7=D4=C2 29 12:19:14 CST 2005</FONT>
<BR><FONT SIZE=3D2>m8xx_setup.c:Reserved 0x10000 memory at =
0xc0190000</FONT>
<BR><FONT SIZE=3D2>On node 0 totalpages: 8192</FONT>
<BR><FONT SIZE=3D2>zone(0): 8192 pages.</FONT>
<BR><FONT SIZE=3D2>zone(1): 0 pages.</FONT>
<BR><FONT SIZE=3D2>zone(2): 0 pages.</FONT>
<BR><FONT SIZE=3D2>Kernel command line: root=3D/dev/nftla1 =
ip=3D192.168.0.207:192.168.0.82:::sc855t:eth</FONT>
<BR><FONT SIZE=3D2>0:off</FONT>
<BR><FONT SIZE=3D2>Decrementer Frequency =3D 300000000/60</FONT>
<BR><FONT SIZE=3D2>Warning: real time clock seems stuck!</FONT>
<BR><FONT SIZE=3D2>Calibrating delay loop... 79.66 BogoMIPS</FONT>
<BR><FONT SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D HZ=3D100&nbsp;&nbsp; =
loops_per_jiffy=3D398336</FONT>
<BR><FONT SIZE=3D2>Memory: 30752k available (1144k kernel code, 356k =
data, 56k init, 0k highmem)</FONT>
<BR><FONT SIZE=3D2>Dentry cache hash table entries: 4096 (order: 3, =
32768 bytes)</FONT>
<BR><FONT SIZE=3D2>Inode cache hash table entries: 2048 (order: 2, =
16384 bytes)</FONT>
<BR><FONT SIZE=3D2>Mount cache hash table entries: 512 (order: 0, 4096 =
bytes)</FONT>
<BR><FONT SIZE=3D2>Buffer cache hash table entries: 1024 (order: 0, =
4096 bytes)</FONT>
<BR><FONT SIZE=3D2>Page-cache hash table entries: 8192 (order: 3, 32768 =
bytes)</FONT>
<BR><FONT SIZE=3D2>POSIX conformance testing by UNIFIX</FONT>
<BR><FONT SIZE=3D2>WDT_8xx: SWT not enabled by firmware, =
SYPCR=3D0xffffff88</FONT>
<BR><FONT SIZE=3D2>Linux NET4.0 for Linux 2.4</FONT>
<BR><FONT SIZE=3D2>Based upon Swansea University Computer Society =
NET3.039</FONT>
<BR><FONT SIZE=3D2>Initializing RT netlink socket</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starting =
kswapd</FONT>
<BR><FONT SIZE=3D2>Journalled Block Device driver loaded</FONT>
<BR><FONT SIZE=3D2>i2c-core.o: i2c core module version 2.6.1 =
(20010830)</FONT>
<BR><FONT SIZE=3D2>i2c-dev.o: i2c /dev entries driver module version =
2.6.1 (20010830)</FONT>
<BR><FONT SIZE=3D2>i2c-algo-8xx.o: i2c mpc8xx algorithm module version =
2.6.1 (20010830)</FONT>
<BR><FONT SIZE=3D2>i2c-rpx.o: i2c MPC8xx module version 2.6.1 =
(20010830)</FONT>
<BR><FONT SIZE=3D2>i2c-proc.o version 2.6.1 (20010830)</FONT>
<BR><FONT SIZE=3D2>CPM UART driver version 0.04</FONT>
<BR><FONT SIZE=3D2>ttyS0 at 0x0280 is on SMC1 using BRG1</FONT>
<BR><FONT SIZE=3D2>ttyS1 at 0x0380 is on SMC2 using BRG2</FONT>
<BR><FONT SIZE=3D2>pty: 256 Unix98 ptys configured</FONT>
<BR><FONT SIZE=3D2>PCF8563 Real-Time Clock Driver $Revision: 1.3 $ =
wd@denx.de</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>I modify i2c-algo-8xx.c cpm_iic_write(), then no =
problem,</FONT>
<BR><FONT SIZE=3D2>my board defined by CONFIG_SVM8xx</FONT>
</P>

<P><FONT SIZE=3D2>#ifdef CONFIG_SVM8xx</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; while(!(i2c-&gt;i2c_i2cer &amp; =
0x12))</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(time_after(jiffies, tmo)) {</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmo =3D =
0;</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>
<BR><FONT SIZE=3D2>#else</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while(!(i2c-&gt;i2c_i2cer &amp; 0x12 || =
time_after(jiffies, tmo))); /* Bus</FONT>
<BR><FONT SIZE=3D2>#endif</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =
=3D =3D =3D =3D =3D =3D =3D</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT SIZE=3D2> </FONT>
<BR><FONT =
SIZE=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1Debora =
Liu</FONT>
<BR><FONT =
SIZE=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1deboralh@fel.co=
m.cn</FONT>
<BR><FONT =
SIZE=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1200=
5-08-08</FONT>
</P>
<BR>
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>------------------------------</FONT>
</P>

<P><FONT =
SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Linuxppc-embedded mailing list</FONT>
<BR><FONT SIZE=3D2>Linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" =
TARGET=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded<=
/A></FONT>
</P>

<P><FONT SIZE=3D2>End of Linuxppc-embedded Digest, Vol 12, Issue =
25</FONT>
<BR><FONT =
SIZE=3D2>*************************************************</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C59C1B.AECD5730--
