Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr2.xs4all.nl (smtp-vbr2.xs4all.nl [194.109.24.22])
	by ozlabs.org (Postfix) with ESMTP id 82FB5DDF62
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 19:54:44 +1100 (EST)
Message-ID: <47F1F84E.8030001@aimvalley.nl>
Date: Tue, 01 Apr 2008 10:54:38 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Ethernet Jumbo Frames
References: <D61182AC8012EA4EBC531B3AF23BE109582F00@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109582F00@tranzeo-mail2.12stewart.tranzeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Darcy Watkins <DWatkins@tranzeo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


We've done it for our 2.4 based kernel that runs on a Freescale MPC8270.
10/100/1000 doesn't really make any difference. For us the trick was to
support receving jumbo frames in multiple RX BufDescriptors (because our
MPC8270 FCC eth driver pre-allocates 2k buffers per RX BD).
For transmitting hardly any changes were necessary.

 From linux (driver) standpoint there should be no problems,
the question is whether your ethernet MAC (IBM EMAC) properly supports it.

hth,
N. van Bolhuis.



Darcy Watkins wrote:
> Has anyone on this list ever been given a requirement to implement
> support for ethernet frames larger than the standard MTU of 1500?  ...
> 
> ... for normal 10/100 Ethernet?   ... not gigabit.
> 
> The application is to support certain encapsulation protocols without
> imposing smaller than 1500 byte MTU restrictions on the innermost
> protocol.
> 
> I have been tasked to investigate this for a system based on PPC405EP.
> Can it be done using the IBM EMAC, Linux drivers, etc?
> 
> Regards,
> 
> Darcy
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


-- 
This message has been scanned for viruses and is believed to be clean
