Message-ID: <4047B907.5070902@embeddededge.com>
Date: Thu, 04 Mar 2004 18:17:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Richard Williams <richard_williams@stratexnet.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
References: <A3240F62EF3C2749B1A25D3BC9548F4103EED2@ExchWENZ02.wenz.global.vpn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Williams wrote:

> I just tried this using pread....

No, no.

Open /dev/mem and use mmap() to map your physical address:

   mmap(NULL, <page_size_bytes>, (PROT_READ|PROT_WRITE), MAP_SHARED, mem_fd, phys_addr);


Then, use the pointer returned from mmap() as the base of your
registers.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
