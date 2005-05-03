Return-Path: <clark@esteem.com>
Received: from mail5.hsphere.cc (mail5.hsphere.cc [216.157.145.25])
	by ozlabs.org (Postfix) with SMTP id 8C970679F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 May 2005 04:29:25 +1000 (EST)
Message-ID: <4277BF8F.8040206@esteem.com>
Date: Tue, 03 May 2005 11:14:39 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050502204259.GB4065@logos.cnet>
In-Reply-To: <20050502204259.GB4065@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Marcelo Tosatti wrote:
> Hi 8xx folks,

<SNIP>

> 
> Actually, CONFIG_PIN_TLB slowdowns the system, as expected (there are only 
> 28 usable TLB's instead of 32).
> 
> 
> v2.6 CONFIG_PIN_TLB:
> I-TLB userspace misses: 162113
> I-TLB kernel misses: 135911
> D-TLB userspace misses: 289452
> D-TLB kernel misses: 257039
> 
> v2.6 without CONFIG_PIN_TLB:
> I-TLB userspace misses: 160828
> I-TLB kernel misses: 134746
> D-TLB userspace misses: 253557
> D-TLB kernel misses: 227383
> 
> 

Considering that the TLB kernel misses are higher with tlb pinning it 
appears as though the pinned TLBs are not marked as valid.


> The following BDI output shows the pinned, 8MByte data page mapping present,
> at 0xc0000000.
> 
> BDI>rds 826
> SPR  826 : 0x00007f00        32512
> BDI>rms 792 0x0c001C00
> BDI>rms 824 1
> BDI>rds 824
> SPR  824 : 0xc00000f0  -1073741584
> BDI>rds 825
> SPR  825 : 0x00000fe0         4064
> BDI>rds 826
> SPR  826 : 0x00007fff        32767       <- "0x00007fff" was 0x00007f00" initially. 
> 				             I tried enabling usermode access without
> 					     success.
> 
> There are several 4Kb mappings inside the range covered by this 8Mb TLB entry, 
> for example: 
> 
> BDI>rms 792 0x0c000200
> BDI>rms 824 1
> BDI>rds 824
> SPR  824 : 0xc0224f17  -1071493353
> BDI>rds 825
> SPR  825 : 0x002241e0      2245088
> BDI>rds 826
> SPR  826 : 0x00007f00        32512
> 
> And more, without so much detail:
> SPR  824 : 0xc0224f17  -1071493353
> SPR  824 : 0xc01fbf17  -1071661289
> SPR  824 : 0xc0246f17  -1071354089
> SPR  824 : 0xc023ff17  -1071382761
> SPR  824 : 0xc7e35f17  - 941400297
> SPR  824 : 0xc0244f17  -1071362281
> SPR  824 : 0xc023ef17  -1071386857
> 
> Note that protection (SPR 826) is exactly the same as the 8Mbyte page protection. 
> 
> Why is the translation mechanism rejection the pinned mappings? 
> 
> Dan, have you ever seen this work? Am I misunderstanding how the pinned
> entries are supposed to work? 

When you load the Mx_EPN of the pinned area is the EV bit being set?


> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


-- Conn

*****************************************************************
Blessed be the heretic, for he causes some to think and unites
the rest against him.
*****************************************************************

Conn Clark
Engineering Assistant                clark@esteem.com
Electronic Systems Technology Inc.        www.esteem.com

Stock Ticker Symbol                ELST
