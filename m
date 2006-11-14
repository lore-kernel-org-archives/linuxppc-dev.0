Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id B5E3267CAC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 08:32:27 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 5A54A46759
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 10:32:27 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 4806546753
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 10:32:27 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8Q00101P4JTI00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 15 Nov 2006 10:32:27 +1300 (NZDT)
Date: Wed, 15 Nov 2006 10:32:18 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: Possibly OT: bdi2000 virtual memory on 2.6 kernel
In-reply-to: <3F51F683-985D-461F-99B1-3F729388B6CD@embeddedalley.com>
To: Dan Malek <dan@embeddedalley.com>
Message-id: <455A35E2.5000303@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <45593537.1010604@tait.co.nz>
	<3F51F683-985D-461F-99B1-3F729388B6CD@embeddedalley.com>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Nov 13, 2006, at 10:17 PM, Robin Gilks wrote:
> 
>> Debugging a 2.6.18 kernel on a powerpc target
> 
> Which processor, specifically?
> What do your MMU XLAT and PTBASE configuration
> lines look like?
> 
> Thanks.
> 
>     -- Dan
> 
Hi Dan

Running a 859T processor with the following bdi2000 config lines
MMU     XLAT
PTBASE  0xf0
WSPR    149     0x0082000F


in .config (for the kernel build) I have
CONFIG_BDI_SWITCH=y

Memory dumping 0xf0 - its pointing to abatron_pteptrs which contains the 
  pointer to swapper_pg_dir as expected so it all looks OK.

What I'm NOT doing is using a hardware breakpoint to get beyond the 
decompress stage and then loading the vmlinux image before proceeding. 
I'm just loading up vmlinux in ddd, allowing uboot to tftp the kernel 
binary in and decompressing it and then just letting it rip. This 
approach seems OK as far as maintaining breakpoints across multiple runs 
goes, so I assume its OK.

-- 
Robin



=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
