Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DF4767B33
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 07:51:34 +1000 (EST)
Date: Thu, 5 May 2005 11:11:40 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Conn Clark <clark@esteem.com>
Message-ID: <20050505141140.GA3072@logos.cnet>
References: <20050502204259.GB4065@logos.cnet> <4277BF8F.8040206@esteem.com>
	<20050504192238.GA3461@logos.cnet> <427A52A5.8020203@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <427A52A5.8020203@esteem.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CONFIG_PIN_TLB experiments
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> >>When you load the Mx_EPN of the pinned area is the EV bit being set?
> >
> >
> >Yep.
> >
> >
> >"MD_RAM1" (SPR 826) is set:  
> >
> >SPR  826 : 0x00007fff        32767       <- "0x00007fff" was 0x00007f00"
> >					     
> >Bits 17 and 18 are set. Their meaning is: "Change bit for DTLB entry" and 
> >"Entry valid flag" respectively. 
> >Bits 19...23 are also set, they represent supervisor access. Note that 
> >bit 23 "supervisor access type" is set: 0 is read-only, 1 is read-write.
> >
> >so everything looks OK here.
> >
> >"MD_RAM0":
> >
> >SPR  825 : 0x00000fe0         4064
> >
> >Bits 20...26 are set. 
> >
> >20-22: 8Mbyte page set.
> >23-26: APGI (access protection group in 1's complement) set. It is 
> >zero (1111 in 1's complement).
> >27: guarded memory not set.
> >
> >"MD_CAM":
> >
> >SPR  824 : 0xc00000f0  -1073741584
> >
> >Bits 24-27 are set. 
> >
> >24-26 is "page size" (111 = 8Mb) and 27 indicates "shared page" 
> >(ASID comparisong disabled). 
> >
> >The 8Mbyte page is used at boot, from "start_here" until "MMU_init()" 
> >gets called... 
> >
> >The manual says, section "9.3 Address Translation" 
> >
> >"When TLB logic detects that a new effective page number (EPN) overlaps 
> >one in the TLB (when taking into account page sizes, subpage validity 
> >flags,
> >user/supervisor state, etc. the new EPN is written and the old one is 
> >invalidated." 
> >
> >I'm trying to boot a kernel which does not create kernel pte's 
> >from 0xc000000 till 0xc080000. 
> >
> 
> Well, looking at the sources I currently have, 2.6.8 and 2.4.27, I 
> noticed that InstructionTLBMiss in 2.6 is missing some ifdefs that the 
> 2.4 has that pertain to TLB pinning. Otherwise the code appears 
> basically the same. 

Hi Conn,

Those changes shouldnt be pertinent... I believeCONFIG_PIN_TLB never worked 
on 2.4 either.
