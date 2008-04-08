Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 65CA2DDF03
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 00:55:56 +1000 (EST)
Message-ID: <47FB8751.3040301@ru.mvista.com>
Date: Tue, 08 Apr 2008 18:55:13 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
References: <11684073371547-git-send-email-htejun@gmail.com>
	<47FA4FD2.8060808@ru.mvista.com> <47FB85CB.2070506@gmail.com>
In-Reply-To: <47FB85CB.2070506@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:

>>    A very late comment but nevertheless... :-)

> Better late than never.

    :-)

>>    Those functions are going to break on 32-bit platforms with 
>> extended physical address (well, that's starting with Pentiums which 
>> had 36-bit PAE :-) AND devices mapped beyond 4 GB (e.g. PowerPC 44x).  
>> You should have used resource_size_t for the 'offset' parameter. As 
>> this most probably means that libata is broken on such platforms, I'm 
>> going to submit a patch...

    It's broken with drivers using MMIO, I meant to say.

> Yeah, right please go ahead.  But I wonder whether any BIOS was actually 
> crazy enough to map mmio region above 4G on 32bit machine.

    This is a *hardware* mapping on some non-x86 platforms (like PPC 44x or 
MIPS Alchemy). The arch/ppc/ and arch/mips/ kernels have special hooks called 
from ioremap() which help create an illusion that the PCI memory space on such 
platforms (not only it) is mapped below 4 GB; arch/powerpc/ kernel doesn't do 
this anymore -- hence this newly encountered issue.

WBR, Sergei
