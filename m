Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id 715A867A39
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 04:22:16 +1100 (EST)
Message-ID: <005601c6420b$a99add50$6401a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
References: <927594BA71733F4BAA815162B79A3F513B2958@ala-mail04.corp.ad.wrs.com>
	<BAB64425-65CD-4311-9A93-004EBA27729A@kernel.crashing.org>
	<004901c64207$a31403c0$6401a8c0@CHUCK2>
	<84F54A3B-0B2A-45B5-968D-68266C6EDEDA@kernel.crashing.org>
Subject: Re: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 12:22:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
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

> 
> On Mar 7, 2006, at 10:53 AM, Mark Chambers wrote:
> 
>>> I'm dealing with this exact same situation and having a discussion  
>>> on  lkml regarding the proper way to do this.  In your case, do  
>>> you care  what addresses the FPGA is assigned at?
>>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114140791428032&w=2
>>
>> Why does the PCI device have to have a fixed address?   And how do
>> you load an FPGA from user space - mmap?
> 
> In my case it does because we have other devices (DSPs) that are hard  
> coded to know where in PCI address space the FPGA is.
> 

Ah, ok.  So I'm guessing we're talking about DSP bus-master operations
where the DSP is putting out physical PCI space addresses that the
MMU can't help map.  I've run into a similar problem where I'd like to
be able to have a DSP do CPM/BD-like operations from SDRAM, but
it's exceedingly difficult to get the physical address of user-space data.

Well, FWIW, seems to me that something like what Greg K-H referred to,
where you pre-reserve space in PCI land, and then put the device there
when it becomes available, is the way to go.  Otherwise you have this
un-managed hole in PCI space allocation that might cause other problems 
with true hot-swap PCI, or break with kernel revisions.

Mark
