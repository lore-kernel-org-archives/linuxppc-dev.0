Return-Path: <mgreer@mvista.com>
Message-ID: <4239BADE.4060208@mvista.com>
Date: Thu, 17 Mar 2005 10:14:06 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "S. van Beek" <nlv11891@natlab.research.philips.com>
References: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
In-Reply-To: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff672
 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

S. van Beek wrote:

> Hello there,
>  
> This is our first post on this list, hi all!
> We're two Dutch students working with a Virtex-II pro ff672 board from 
> Memec with the Communications 2 module. We've compiled a simple kernel 
> wich comes with MontaVista Linux 3.1 (2.4.20) with ethernet and a 
> serial port. It mounts its root filesystem over NFS and everything 
> seems to work nicely. The next step we wanted to make was 
> adding support for the Flash on the com board. We added the IP to the 
> hardware and loaded the new bitstream in the FPGA. Next thing, we 
> enabled support for MTD devices in the kernel. After that, the kernel 
> did not seem to boot anymore. It stopped at the message 'Now booting 
> the kernel'. So we read some documentation about debugging. We 
> recompiled this kernel with the -g -ggdb options and removed the -O 
> (optimalization) flag. Then we did not even see the ppc boot loader 
> messages anymore when trying to boot. So we tried to compile the first 
> kernel (with only serial and ethernet support) -wich worked fine 
> before- with debugging and it gave us the same result.. no output at all.
> Can anyone give us some hints on what we can try more to find out what 
> is going wrong?

There are lots of possible problems that may be causing this but my 
guess is that you are accessing some piece of hardware that you don't 
have ioremap'd/io_block_mapping'd.  IOW, you don't have a virt->phys 
translation set up for the hardware register you're trying to access.  
If you can find a COPS/JTAG debugger and your board has a connector, set 
it up and run your kernel again.  When it hangs stop the processor and 
dump the 'log_buf' that's in memory (you can get the address from your 
System.map file).  That's where printk msgs are logged before the 
console is set up.  In there you will likely see a panic msg and a 
register dump.  That should point you to where things went wrong.

If you don't have access to a debugger like that, you could try running 
KGDB.  If the kernel is running long enough to reach the initial 
breakpoint and you have correctly configured your code so that KGDB will 
work, that can be big help too.

Mark
