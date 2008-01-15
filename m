Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Tue, 15 Jan 2008 14:04:01 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: lipeng@ict.ac.cn
Subject: Re: Problems with serial and DHCP when booting from NFS
Message-ID: <20080115140401.360db284@zod.rchland.ibm.com>
In-Reply-To: <1233217.1191761200384592967.JavaMail.nabble@isper.nabble.com>
References: <1233217.1191761200384592967.JavaMail.nabble@isper.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jan 2008 00:09:52 -0800
lipeng@ict.ac.cn wrote:

> Hi all,
> 
> I am porting a MontaVista Linux for PPC405 and encountering some problems. I hope someone can help me find it out.

You didn't say what kernel you're using, or what you're porting to
(arch/ppc or arch/powerpc).

> 1. About the serial port. I have solved this problem, but I don't know why. If I set "Initial Kernel Command String" as "console=ttyS0,19200 ip=on nfsroot=[my_nfsroot] rw", after outputing "Now booting the kernel" in the booting process, the booting kernel seems hanging there. In fact, when I checked the log of DHCP server, I found the PPC had already sent DHCP requests. It can be infered that the kernel had been booted but serial had something wrong, so no other information was output after "Now booting the kernel". If I set "Initial Kernel Command String" as "ip=on nfsroot=[my_nfsroot] rw", the booting information will appear on the terminal window correctly after "Now booting the kernel". I don't know why. I use Uart Lite and the baud rate is 19200.

uartlite doesn't show up as ttyS0 IIRC, so your initial console setting
was wrong.

> 2. About the DHCP. The kernel is boot from NFS, so I enabled the DHCP. From the information on terminal window, I knew that DHCP requests were always time out and the client kept retrying. But when I checked the log of DHCP server, I found the server had already offered IP to the client kernel. It seems the client kernel has some problem to receive the DHCP offer, has anyone encountered similar problems? How to solve this problem?

I've seen that on a board I have.  Haven't debugged it yet
because I had to unhook everything to paint the room it was in.  I
think it's something to do with an initialization race in the EMAC
driver or some other place.

josh
