Return-Path: <geoff@infradead.org>
Message-ID: <1361405673.20172.38.camel@smoke>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
From: Geoff Levand <geoff@infradead.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Wed, 20 Feb 2013 16:14:33 -0800
In-Reply-To: <51201276.8020104@mail.ru>
References: <1360365046.495584377@f356.mail.ru> <511F652F.4090508@mail.ru>
 <51201276.8020104@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Phileas,

On Sun, 2013-02-17 at 00:12 +0100, Phileas Fogg wrote:
> I found new clues about the problem.
> 
> Normally the device tree memory segment is allocated at the top of the boot 
> memory region. The boot memory size on the PS3 console is 128MB.
> 
> root@ps3-linux:~# kexec -l loader.ps3
> segment[0].mem:0x131d000 memsz:262144
> segment[1].mem:0x135d000 memsz:36864
> segment[2].mem:0x7fff000 memsz:4096
> 
> And the device tree is located at address 0x7fff000, it's the last page of the 
> boot memory.
> 
> I changed the kexec-tools and made it store the device tree just after the 
> purgatory code which is located at address 0x135d000. Like here:
> 
> root@ps3-linux:~# kexec -l loader.ps3
> segment[0].mem:0x131d000 memsz:262144
> segment[1].mem:0x135d000 memsz:36864
> segment[2].mem:0x1366000 memsz:4096   <---- new address of device tree segment
> 
> And now the sha256 verification is always successful for the FreeBSD loader too.
> But still no idea what actually corrupts the device tree segment when it's 
> located at the top of the boot memory region. And why it happens on Linux 3.7 
> and Linux 3.8 but not on Linux 3.3.8.

Excellent work so far.

You may be able to use the Cell Processor's DABR (Data Address Breakpoint)
register to find out what code is writing to that memory area.  I have a
helper patch to setup the DABR register from kernel code here:

  http://git.kernel.org/?p=linux/kernel/git/geoff/ps3-linux.git;a=commitdiff;h=c46799f5c6ba7594cdaa248ec60a50c7ad1cdeaa

-Geoff
