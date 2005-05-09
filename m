Return-Path: <richard.danter@ntlworld.com>
Received: from queue01-winn.mailhost.ntl.com (mailhost.ntl.com [212.250.162.8])
	by ozlabs.org (Postfix) with ESMTP id 2A1EC679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 13:04:16 +1000 (EST)
Received: from aamta04-winn.mailhost.ntl.com ([212.250.162.8])
	by mta08-winn.mailhost.ntl.com with ESMTP id
	<20050509121918.EXTY21532.mta08-winn.mailhost.ntl.com@aamta04-winn.mailhost.ntl.com>
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 May 2005 13:19:18 +0100
Received: from [192.168.1.10] (really [82.4.184.52])
	by aamta04-winn.mailhost.ntl.com with ESMTP id
	<20050509121918.UHEO1352.aamta04-winn.mailhost.ntl.com@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 May 2005 13:19:18 +0100
Message-ID: <427F553A.1060506@ntlworld.com>
Date: Mon, 09 May 2005 13:19:06 +0100
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: linux-2.6.10, ppc8280, odd ARP request
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am seeing an odd ARP request from an 8280 when using any of the FCC's 
as eth0. Using SCC1 as eth0 seems fine.

My board boots using U-Boot. It tftp loads the kernel image via FCC2, so 
I know the FCC's are working (I have tested the others too). This part 
is fine, but once the kernel has loaded it tries to NFS mount the root 
filesystem. When it gets to the point of looking up the RPC port it 
first sends an ARP request for the server. When eth0 is any of the FCC's 
I see a 59 byte packet on the wire (using ethereal). The server either 
does not see the packet or just ignores it so there is no reply to the 
board.

When I boot using SCC1 as eth0 the ARP request sent is 60 bytes long. It 
is replied to and the NFS mount works.

I noticed that U-Boot also sends an ARP request before the tftp download 
starts and it is 60 bytes long using both SCC and FCC ports. But as far 
as I know, ARP requests can be varying length (the last few bytes seem 
to be just padding).

Has anyone else seen anything like this? Any pointers where I should look?

Many thanks,
Rich
