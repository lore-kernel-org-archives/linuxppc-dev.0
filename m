Return-Path: <jeff@mock.com>
Message-ID: <476C722E.5010509@mock.com>
Date: Fri, 21 Dec 2007 18:10:54 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: "Wyse, Chris" <chris.wyse@windriver.com>
Subject: Re: GPIO causing bus error
References: <AF1602CB2550CE4381C0C75118A7856B020C60D7@ala-mail02.corp.ad.wrs.com>
In-Reply-To: <AF1602CB2550CE4381C0C75118A7856B020C60D7@ala-mail02.corp.ad.wrs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Slimm, Rob" <robert.slimm@windriver.com>, linuxppc-dev@ozlabs.org,
	support@amcc.com, "Wessel, Jason" <jason.wessel@windriver.com>,
	"Ayer, Charles" <Charlie.Ayer@windriver.com>,
	+linux-eng <linux-eng@mail.wrs.com>, +techfield <techfield@windriver.com>,
	linux-kernel <linux-kernel-pf@windriver.com>,
	linuxppc-embedded@ozlabs.org, "Read, Tricia" <tricia.read@windriver.com>,
	+linux-embedded <linux-embedded@mail.wrs.com>, "Touron,
	Emmanuel" <emmanuel.touron@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, I have a system that is pretty similar to yours.  Our boards have 
a 440GX and two Xilinx 2VP70's.  The FPGAs are loaded using slave serial 
mode (not jtag) from GPIO pins, but still pretty similar.

I haven't had any problems loading the FPGAs this way.

 From your description I can't tell when you load the FPGAs during the 
boot process.  Our approach is as follows:

A module is loaded that creates /dev/fpga. You can 'cat' a bitstream 
file to /dev/fpga and the driver will wiggle the GPIO pins appropriately 
to the load the bitstream in the FPGAs.  The script run at boot time 
will do something like:

    # zcat /etc/fpga_img.gz > /dev/fpga

At that point we load modules that create devices appropriate for the 
FPGA image and the system is off running a domain specific application. 
The process can be reversed to unload the drivers, load a new FPGA image 
and new drivers without rebooting.

One thing that comes to mind is that our GPIO pins are used for a number 
of disparate needs beyond FPGA loading.  I keep a semaphore for 
accessing the GPIO pins so that the different drivers that touch the 
GPIO pins don't step on each other.  Only one driver can touch the GPIO 
pins at a time.  Failing to do this in our application would definitely 
create occasional failures.

jeff


Wyse, Chris wrote:
> Hi,
>  
> I'm having trouble with an unusual problem.  I'm working on relatively 
> new hardware, so it's possible that there could be a hardware issue 
> involved. 
>  
> I have an FPGA on my PPC440GX board that gets loaded via JTAG during the 
> kernel boot process (Linux 2.6.10).  It uses the 440GX GPIO lines to 
> send the necessary JTAG commands to the FPGA to perform the initial 
> load.  This process is USUALLY functional, but on some of the boards 
> (which we produce), the GPIO write fails with a bus error.  On the 
> boards that fail, it only occurs after a cold boot, and only if the 
> board has been powered off for a few minutes.  A quick hard reboot will 
> not generate the problem.  When I issue the failing write to the GPIO 
> lines, some of the SDRAM gets corrupted.  I don't appear to be taking 
> any interrupts that might have corrupted the RAM.
>  
> I've checked the TLB entries, and it maps correctly to the PPC register 
> area.  Additionally, I can read and write to other registers using the 
> same TLB mapping WITHOUT any error.  I can also READ the GPIO lines 
> without an error - the error is only on the write.   I've checked the 
> SDR0_PFC0 bits to make sure everything is set properly (it is).  The bus 
> error indicates "PLB Timeout Error Status Master 2, Master 2 slave error 
> occurred" (Master 2 is the write-only data cache unit (DCU)) and "Write 
> Error Interrupt Master 2, Write error detected - master 2 interrupt 
> request is active".  I'm not sure why there would be any error in the 
> DCU, since the region I'm writing to is cache inhibited and guarded.
>  
> If I issue a soft reset of the GPIO subsystem, I can read and write to 
> the GPIO lines again.
>  
> The error does not occur on the first write to the GPIO.  I go through 
> the failing routine several times before it fails.  However, when it 
> fails, it consistently fails at the same spot, after the same number of 
> passes through the code.
>  
> I'm using RGMII ethernet on EMAC2 (Group 4), but the GPIO lines that I'm 
> using are not the Trace/GPIO lines (26-31) so I believe that they should 
> work fine (and they usually do).  Also, the errata mentions that 
> SDR0_PFC0[G11E] has no effect - but I'm not using GPIO 11 anyway.
>  
> Here are some relevant register values after the error:
>  
> SDR0_PFC0 :     0x083FFE00
> POB0_BESR0:     0x00008400
> POB0_BEARH:     0x00000001
> POB0_BEARL:     0x40000701
> GPIO0_OR  :     0x000400C0
> GPIO0_TCR :     0x00278AE0
> GPIO0_ODR :     0x00000000
> GPIO0_IR  :     0x00000000
>  
> I've attached two log files, that contain most of the 440 registers, one 
> for before the error and one after.  In the log files, the bus error has 
> been cleared, so use the values shown above.
>  
> I'm looking for some suggestions on what to try to debug/resolve this 
> issue.  I'm open to both hardware and software based suggestions.  Any 
> help would be greatly appreciated.
>  
>  
> Chris Wyse
> Senior Member of Technical Staff
> Embedded Technologies
> 860-978-0849 cell/office
> 413-778-9101 fax
> http://www.windriver.com <http://www.windriver.com/>
>  
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
