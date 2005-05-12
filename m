Return-Path: <richard.danter@ntlworld.com>
Received: from mta08-winn.mailhost.ntl.com (smtpout16.mailhost.ntl.com
	[212.250.162.16]) by ozlabs.org (Postfix) with ESMTP id D5B4067B24
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 21:31:54 +1000 (EST)
Received: from aamta07-winn.mailhost.ntl.com ([212.250.162.8])
	by mta08-winn.mailhost.ntl.com with ESMTP id
	<20050512113152.DGIG26549.mta08-winn.mailhost.ntl.com@aamta07-winn.mailhost.ntl.com>
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 May 2005 12:31:52 +0100
Received: from [192.168.1.10] (really [82.4.184.52])
	by aamta07-winn.mailhost.ntl.com with ESMTP id
	<20050512113152.JGDT1399.aamta07-winn.mailhost.ntl.com@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 May 2005 12:31:52 +0100
Message-ID: <42833E9B.3090608@ntlworld.com>
Date: Thu, 12 May 2005 12:31:39 +0100
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <427F553A.1060506@ntlworld.com>
In-Reply-To: <427F553A.1060506@ntlworld.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: linux-2.6.10, ppc8280, odd ARP request - solved
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Richard Danter wrote:
> 
> My board boots using U-Boot. It tftp loads the kernel image via FCC2, so 
> I know the FCC's are working (I have tested the others too). This part 
> is fine, but once the kernel has loaded it tries to NFS mount the root 
> filesystem. When it gets to the point of looking up the RPC port it 
> first sends an ARP request for the server. When eth0 is any of the FCC's 
> I see a 59 byte packet on the wire (using ethereal). The server either 
> does not see the packet or just ignores it so there is no reply to the 
> board.
> 
> When I boot using SCC1 as eth0 the ARP request sent is 60 bytes long. It 
> is replied to and the NFS mount works.
> 
> I noticed that U-Boot also sends an ARP request before the tftp download 
> starts and it is 60 bytes long using both SCC and FCC ports. But as far 
> as I know, ARP requests can be varying length (the last few bytes seem 
> to be just padding).

Looks like the problem may be with the setup of the FCC, particularly 
with working out what speed to run at. I connected my board to a 
100BaseT hub and it worked perfectly. It was failing when I was using an 
older 10BaseT hub. In both cases the hub is a Netgear and I have never 
had a problem with any other board or PC.

Odd how it effects Linux but not U-Boot. Seems to indicate a driver 
issue anyway.

Rich
