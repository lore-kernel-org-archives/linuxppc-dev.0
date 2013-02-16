Return-Path: <phileas-fogg@mail.ru>
Received: from smtp45.i.mail.ru (smtp45.i.mail.ru [94.100.177.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 40A2D2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 09:12:59 +1100 (EST)
Message-ID: <51201276.8020104@mail.ru>
Date: Sun, 17 Feb 2013 00:12:54 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Phileas Fogg <phileas-fogg@mail.ru>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <511F652F.4090508@mail.ru>
In-Reply-To: <511F652F.4090508@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I found new clues about the problem.

Normally the device tree memory segment is allocated at the top of the boot 
memory region. The boot memory size on the PS3 console is 128MB.

root@ps3-linux:~# kexec -l loader.ps3
segment[0].mem:0x131d000 memsz:262144
segment[1].mem:0x135d000 memsz:36864
segment[2].mem:0x7fff000 memsz:4096

And the device tree is located at address 0x7fff000, it's the last page of the 
boot memory.

I changed the kexec-tools and made it store the device tree just after the 
purgatory code which is located at address 0x135d000. Like here:

root@ps3-linux:~# kexec -l loader.ps3
segment[0].mem:0x131d000 memsz:262144
segment[1].mem:0x135d000 memsz:36864
segment[2].mem:0x1366000 memsz:4096   <---- new address of device tree segment

And now the sha256 verification is always successful for the FreeBSD loader too.
But still no idea what actually corrupts the device tree segment when it's 
located at the top of the boot memory region. And why it happens on Linux 3.7 
and Linux 3.8 but not on Linux 3.3.8.

regards
