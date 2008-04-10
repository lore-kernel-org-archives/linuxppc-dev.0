Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EF505DDF5A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 04:25:37 +1000 (EST)
Message-ID: <47FE5B76.40409@ru.mvista.com>
Date: Thu, 10 Apr 2008 22:24:54 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
References: <11684073371547-git-send-email-htejun@gmail.com>	<47FA4FD2.8060808@ru.mvista.com>
	<47FB85CB.2070506@gmail.com> <47FB8751.3040301@ru.mvista.com>
	<47FE46AC.5000901@ru.mvista.com>
	<59A939C7-75AF-4C0F-8199-4C31D174AEA9@kernel.crashing.org>
In-Reply-To: <59A939C7-75AF-4C0F-8199-4C31D174AEA9@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>>>>>   Those functions are going to break on 32-bit platforms with  
>>>>> extended physical address (well, that's starting with Pentiums  
>>>>> which had 36-bit PAE :-) AND devices mapped beyond 4 GB (e.g.  
>>>>> PowerPC 44x).  You should have used resource_size_t for the  
>>>>> 'offset' parameter. As this most probably means that libata is  
>>>>> broken on such platforms, I'm going to submit a patch...

>>>   It's broken with drivers using MMIO, I meant to say.

>>   Oops, I meant PCI drivers here, at least for the time being. And  it 
>> looks like that was a false alarm. :-]

>>>> Yeah, right please go ahead.  But I wonder whether any BIOS was  
>>>> actually crazy enough to map mmio region above 4G on 32bit machine.

>>>   This is a *hardware* mapping on some non-x86 platforms (like PPC  
>>> 44x or MIPS Alchemy). The arch/ppc/ and arch/mips/ kernels have  
>>> special hooks called from ioremap() which help create an illusion  
>>> that the PCI memory space on such platforms (not only it) is mapped  
>>> below 4 GB; arch/powerpc/ kernel doesn't do this anymore -- hence  
>>> this newly encountered issue.

>>   I thought that pcim_iomap() used devm_ioremap() or something --  
>> which of course turned to be wrong. devm_ioremap() alone is yet safe  
>> since there are no users for it amongst PPC 44x platform device  
>> drivers...

> but there is no reason not to make it work properly.  For example I  
> believe libata uses devm_* and the fsl SATA driver (non-PCI) will need  
> to work in cases similar to the 44x.

    Well, as for sata_fsl, it calls of_iomap() which does The Right Thing.

> - k

WBR, Sergei
