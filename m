Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF69C679EA
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Apr 2006 05:07:56 +1000 (EST)
Message-ID: <444A7EF8.8010709@orkun.us>
Date: Sat, 22 Apr 2006 14:07:36 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
References: <20060421165732.CD0EB3526B7@atlas.denx.de>
In-Reply-To: <20060421165732.CD0EB3526B7@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: White <white@from-b.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <20060421055142.11025.qmail@mx1.aruba.it> you wrote:
>   
>> No, I have a cramfs on flash and the kernel uses it directly from flash,
>> extracting what it needs to execute. I'm not using initrd then, I have to
>> update in situ, while running.
>>     
>
> This cannot be done reliably. You have to make the file system  idle,
> i. e. unmount it.
>   
I agree, even if you make the executables involved in the update 
statically linked (so library dependencies are removed), kernel can 
choose to reload any running executables page and it would end up with a 
bogus page in memory. This is particularly true if you do not have swap 
which you could try to lock executable in swap. Also, you cannot 
reliably depend on file system cache to contain all the executable code 
you would need to complete update either.

Regards,
Tolunay
