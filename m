Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.2.115]) by ozlabs.org (Postfix) with ESMTP id 267232BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Nov 2004 10:21:56 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iASNLhYL013099
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Nov 2004 00:21:43 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41AA5D99.1000103@246tNt.com>
Date: Mon, 29 Nov 2004 00:22:01 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20041127213940.72317.qmail@web53501.mail.yahoo.com>
In-Reply-To: <20041127213940.72317.qmail@web53501.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Cache coherency with BestComm issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Roger

> By experimenting I have found that the BestComm and FEC work without
>the cache flush provided CPU_FTR_MAYBE_CAN_NAP is removed from the
>cputable (nap disables snooping) and that CPU_FTR_NEED_COHERENT is
>added to the cputable (turns on "M" bit in BAT/PTE so that the XLB has
>a chance of seeing a global transaction).
>  
>
Thanks for the info.

The nap thing was indeed obvious ... The proper way to deactivate it 
would be in lite5200.c
I added the powersave_nap = 1; as an example on how to allow it to nap. 
I'll probably
comment it out by default with a note.

For the CPU_FTR_NEED_COHERENT, are you sure it's required ?
 From my understanding of the G2Core manual, the M bit must be set if 
you want the G2Core
to assert the global signal when it access memory. Here, we don't care 
since only
the G2Core is snooping on the bus. So that should not be required ...


    Sylvain
