Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCF6367B22
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 01:13:09 +1000 (EST)
Date: Wed, 4 May 2005 16:22:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Conn Clark <clark@esteem.com>
Message-ID: <20050504192238.GA3461@logos.cnet>
References: <20050502204259.GB4065@logos.cnet> <4277BF8F.8040206@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4277BF8F.8040206@esteem.com>
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

Hi,

On Tue, May 03, 2005 at 11:14:39AM -0700, Conn Clark wrote:
> Marcelo Tosatti wrote:
> >Hi 8xx folks,
> 
> <SNIP>
> 
> >
> >Actually, CONFIG_PIN_TLB slowdowns the system, as expected (there are only 
> >28 usable TLB's instead of 32).
> >
> >
> >v2.6 CONFIG_PIN_TLB:
> >I-TLB userspace misses: 162113
> >I-TLB kernel misses: 135911
> >D-TLB userspace misses: 289452
> >D-TLB kernel misses: 257039
> >
> >v2.6 without CONFIG_PIN_TLB:
> >I-TLB userspace misses: 160828
> >I-TLB kernel misses: 134746
> >D-TLB userspace misses: 253557
> >D-TLB kernel misses: 227383
> >
> >
> 
> Considering that the TLB kernel misses are higher with tlb pinning it 
> appears as though the pinned TLBs are not marked as valid.

Yep

> 
> >The following BDI output shows the pinned, 8MByte data page mapping 
> >present,
> >at 0xc0000000.
> >
> >BDI>rds 826
> >SPR  826 : 0x00007f00        32512
> >BDI>rms 792 0x0c001C00
> >BDI>rms 824 1
> >BDI>rds 824
> >SPR  824 : 0xc00000f0  -1073741584
> >BDI>rds 825
> >SPR  825 : 0x00000fe0         4064
> >BDI>rds 826
> >SPR  826 : 0x00007fff        32767       <- "0x00007fff" was 0x00007f00" 
> >initially. I tried enabling 
> >				             usermode access without
> >					     success.
> >
> >There are several 4Kb mappings inside the range covered by this 8Mb TLB 
> >entry, for example: 
> >
> >BDI>rms 792 0x0c000200
> >BDI>rms 824 1
> >BDI>rds 824
> >SPR  824 : 0xc0224f17  -1071493353
> >BDI>rds 825
> >SPR  825 : 0x002241e0      2245088
> >BDI>rds 826
> >SPR  826 : 0x00007f00        32512
> >
> >And more, without so much detail:
> >SPR  824 : 0xc0224f17  -1071493353
> >SPR  824 : 0xc01fbf17  -1071661289
> >SPR  824 : 0xc0246f17  -1071354089
> >SPR  824 : 0xc023ff17  -1071382761
> >SPR  824 : 0xc7e35f17  - 941400297
> >SPR  824 : 0xc0244f17  -1071362281
> >SPR  824 : 0xc023ef17  -1071386857
> >
> >Note that protection (SPR 826) is exactly the same as the 8Mbyte page 
> >protection. 
> >Why is the translation mechanism rejection the pinned mappings? 
> >
> >Dan, have you ever seen this work? Am I misunderstanding how the pinned
> >entries are supposed to work? 
> 
> When you load the Mx_EPN of the pinned area is the EV bit being set?

Yep.


"MD_RAM1" (SPR 826) is set:  

SPR  826 : 0x00007fff        32767       <- "0x00007fff" was 0x00007f00"
					     
Bits 17 and 18 are set. Their meaning is: "Change bit for DTLB entry" and 
"Entry valid flag" respectively. 
Bits 19...23 are also set, they represent supervisor access. Note that 
bit 23 "supervisor access type" is set: 0 is read-only, 1 is read-write.

so everything looks OK here.

"MD_RAM0":

SPR  825 : 0x00000fe0         4064

Bits 20...26 are set. 

20-22: 8Mbyte page set.
23-26: APGI (access protection group in 1's complement) set. It is 
zero (1111 in 1's complement).
27: guarded memory not set.

"MD_CAM":

SPR  824 : 0xc00000f0  -1073741584

Bits 24-27 are set. 

24-26 is "page size" (111 = 8Mb) and 27 indicates "shared page" 
(ASID comparisong disabled). 

The 8Mbyte page is used at boot, from "start_here" until "MMU_init()" 
gets called... 

The manual says, section "9.3 Address Translation" 

"When TLB logic detects that a new effective page number (EPN) overlaps 
one in the TLB (when taking into account page sizes, subpage validity flags,
user/supervisor state, etc. the new EPN is written and the old one is 
invalidated." 

I'm trying to boot a kernel which does not create kernel pte's 
from 0xc000000 till 0xc080000. 
