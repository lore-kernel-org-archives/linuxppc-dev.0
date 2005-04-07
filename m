Return-Path: <wolfgang.grandegger@bluewin.ch>
Received: from popmail.space.net (popmail.Space.Net [195.30.0.14])
	by ozlabs.org (Postfix) with SMTP id 08FF467A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 18:26:21 +1000 (EST)
Message-ID: <4254FB38.9040202@bluewin.ch>
Date: Thu, 07 Apr 2005 11:19:52 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Joshua Lamorie <jpl@xiphos.ca>
References: <42545228.9060003@xiphos.ca>
In-Reply-To: <42545228.9060003@xiphos.ca>
Content-Type: text/plain; charset=us-ascii
Cc: rtai@rtai.org, linuxppc-embedded@ozlabs.org
Subject: Re: Unhandled relocation of type 11
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm not a linker expert but some time ago I got the gcc soft floating
library working for 8xx and 4xx in kernel space. The problem was with
PIC. Maybe your library is built with PIC and it's required without. You
may want to have a look to:

  ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2

Wolfgang.


On 04/06/2005 11:18 PM Joshua Lamorie wrote:
> Please excuse this cross-post, but I think it is of interest to both 
> RTAI and Linux PPC folks.
> 
> I am making a kernel module (an RTAI task) that needs floating point 
> support so I'm using IBMs perflib floating-point libraries (on a 
> Virtex-II Pro, aka ppc405).
> 
> This is actually built from Matlab/simulink real-time workshop output (I 
> can't use rtai-lab because I don't think lxrt is available for ppc)... 
> so there end up being many object files to link.
> 
> So, in the end I have a linker command as follows.
> 
> powerpc-405-linux-gnu-ld -r -m elf32ppclinux -L/some/directories
> matlab_root/rtw/c/libsrc/rt_zcfcn.o other.o inputs.o -o module_output.o
> perflibs/fpopt/libppcfp.a
> 
> Then I go to insert the module and....
> /var/shm # insmod test001_build_rtmodule.o
> Warning: loading test001_build_rtmodule.o will taint the kernel: non-GPL 
> license - Proprietary
>   See http://www.tux.org/lkml/#export-tainted for information about 
> tainted modules
> test001_build_rtmodule.o: Unhandled relocation of type 11 for __fixdfsi
> test001_build_rtmodule.o: Unhandled relocation of type 11 for __fixdfsi
> 
> Hrmm... so any ideas on what type 11 is?  I can see from the code in 
> modutils that this value is inside rel->r_info, such as R_PPC_ADDR32 or 
> R_PPC_ADDR16_HA.
> 
> But where do I get more info about where r_info gets assigned?  Do I 
> need to link libppcfp.a in a particular way?
> 
> Any hints would be appreciated.
> 
> Thanks in advance.
> 
> Joshua
> 
