Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id 2F0FCDDED8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 05:06:29 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i21so201786wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 12:06:28 -0700 (PDT)
Message-ID: <fa686aa40707121206n7e75e770q742adb3659f35e79@mail.gmail.com>
Date: Thu, 12 Jul 2007 13:06:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: XSysAce driver cant mount DOS part
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17206@hsv1dafpew02.das.gov.sanm.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
	<fa686aa40707121116l1d76078aq82926eb861720474@mail.gmail.com>
	<939D37AEB47F1F49B88FAB6599B6023501A17206@hsv1dafpew02.das.gov.sanm.corp>
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

On 7/12/07, Robertson, Joseph M. <joseph.robertson@sanmina-sci.com> wrote:
>  RE: Tree.
>  Its the mainline 2.6.17.1, with
>  denx ppc patches from 4.0.0?  IIRC.
>  I redid the patch set for the xsysace to get a known baseline.
>  Its a custom build system, which I developed over the years, ported to use
> a ppc405 crosscompiler I made from
>  CrossTool-0.42. Its very similar to uClinux, but with a simpler config
> system.
>  The compiler is gcc.3.4.1 with glibc 2.3.3 (yeah we use glibc).

Heh, so do I.  So do a lot of people.  glibc *is* for embedded
systems, regardless of what some may say.  :-)

>  The XsysAce patch is in the normal place, only change I made was to define
> the major number.
>  And I moved xbasic_types.c/h to another folder onthe path since xilinx_iic
> drivers uses it too, and I was getting redefine errors.
>  One thing I just thought of was I did not run the 'normal' config stuff,
> any deps in there?
>  I can go look at the kconfigs and see.
>
>  RE: Xilinx SysAce driver
>  The HW group used Xilinx env 8.2.02i, and the project shows
> Sysace_compactflash driver:  sysace_v1_01_a

Okay, so that's the old driver.  There is a new driver that has
considerably better performance which you might want to try; but it
doesn't support insertion/removal yet.  It is about to be pulled into
mainline, but you can get it here too:

http://article.gmane.org/gmane.linux.kernel/526293/match=xsysace+c

>
>  The HW is a Virtex-4 with the embedded ppc405.  The Xsysace chip is
> supposed tobe using irq_intr = 2.
>
>  The system actually works fine using the Ext2 fs, but if we want to upgrade
> the fpga code, I need to be able to write to the dos part.

2.6.17 is rather old.  You might be hitting an old bug.  Virtex
support in the newer kernels is significantly better.  Have you
considered upgrading?  I've got a bunch of patches in my git tree that
add the TEMAC and other drivers to a more recent kernel.  My internal
tree is based on 2.6.22; I'll try to update my external tree to match
in the next day or so:

http://git.secretlab.ca/cgi-bin/gitweb.cgi?h=virtex-dev;p=linux-2.6.git;a=shortlog

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
