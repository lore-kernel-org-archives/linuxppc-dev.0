Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1A4B068A84
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 08:34:29 +1100 (EST)
Message-ID: <43EA634F.5040004@ovro.caltech.edu>
Date: Wed, 08 Feb 2006 13:31:59 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Buhler, Greg" <greg.buhler@viasat.com>
Subject: Re: Example PPC-4xx DMA scatter/gather usage
References: <68997D3094017740BB875EB2A425A6EA02C1C11D@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <68997D3094017740BB875EB2A425A6EA02C1C11D@VCAEXCH01.hq.corp.viasat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

Buhler, Greg wrote:
> Does anyone have any example code they could provide me that shows 
> correct usage of the Linux 2.6.x PPC-4xx scatter/gather DMA 
> functionality? None of the mainline kernel tree sources or module 
> sources seem to use this functionality.
> 
> I am working on a driver that runs on an embedded PPC-405gp running 
> linux 2.4.21.  The driver relies extensively on the PPC’s DMA controller 
> using all 4 channels simultaneously.  After some research I determined 
> that the version of the dma code that was in 2.4.21 had been 
> significantly modified in more recent kernel trees. As a result I have 
> merged in the 2.6.x version of this code, but am running into some 
> trouble with sg transfers.  Specifically, after setting up an sgl the 
> way I used to with the 2.4.21 kernel, and then kicking off the transfer, 
> nothing seems to get transferred. When I attempt to remove sg elements 
> from the sgl, the kernel complains saying that I’m trying to remove an 
> element from an already empty sgl.
> 
> Any help, advice, or examples would be greatly appreciated. Thanks.

Hey Greg,

I haven't tried to use any of the kernel source for DMA control.
I started by writing a simple driver that provides a page of
SDRAM (basically copied the nopage driver from Rubini's 3rd Ed).
Then wrote another driver that provided access to the DCRs.
Using the DCR driver and page driver, I manually loaded the
DMA controller DCRs and triggered transfers.

I know its not something that you'd use in real-life, but
it allowed me to manually think-out what needs to be done
for DMA transfers, and allowed me to control when the transfer
occurred, so that I could capture PCI bus transactions.
It wouldn't take too much to manually setup an S-G DMA with
a couple of smaller-than-a-page transfers.

Let me know if you want the code, for the SDRAM page driver,
and DCRs driver and I'll email it to you.

Once you have the DMA S-G programming interface confirmed, then go
back to the DMA API and see if that conforms to the requirements.
I need to finish some single DMA benchmarks using the manual
method (to check the EBC performance), and then I'll start
looking at the proper way to use DMA within kernel drivers.

Please send updates to the list on your progress.

Cheers
Dave
