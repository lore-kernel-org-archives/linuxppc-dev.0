Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3447D680DF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 09:14:57 +1000 (EST)
Date: Thu, 11 Aug 2005 16:14:54 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050811231454.GA5796@gate.ebshome.net>
References: <c3d0340b050811154148164691@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050811154148164691@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 03:41:21PM -0700, Shawn Jin wrote:
> Hi,
> 
> I'm porting linux 2.6.11.4 to a custom SoC with ppc440 core. The UART
> is 16550 compatible. U-Boot is already running fine.
> 
> When the kernel is booting, it gets to the point where console_init()
> is called, which calls individual early console initialization
> functions. In my case it's serial8250_console_init(). Before
> register_console() is called in serial8250_console_init(), everything
> seems fine because the debugging logs are printed on the serial port.
> But once register_console() is called, the serial port continues
> spitting out ?. See the following message. What's wrong?
> 
> Any hints are appreciated!
> 
> Boot reached stage 4                                                            
> Boot reached stage 5                                                            
> Boot reached stage 6                                                            
> OK                                                                              
> Boot reached stage 7                                                            
> Boot reached stage 8                                                            
> ## Current stack ends at 0x01FC6B80 => set upper limit to 0x00800000            
> ## cmdline at 0x007FFF00 ... 0x007FFF10                                         
> bd address  = 0x01FC6F90                                                        
> memstart    = 0x00000000                                                        
> memsize     = 0x02000000                                                        
> flashstart  = 0x00000000                                                        
> flashsize   = 0x00000000                                                        
> flashoffset = 0x00000000                                                        
> sramstart   = 0x00000000                                                        
> sramsize    = 0x00000000                                                        
> bootflags   = 0x00000000                                                        
> intfreq     =    400 MHz                                                        
> busfreq     =    266 MHz                                                        
> ethaddr     = 00:00:00:00:00:00                                                 
> IP addr     = 0.0.0.0                                                           
> baudrate    = 115200 bps                                                        
> Boot reached stage 14                                                           
> No initrd                                                                       
> ## Transferring control to Linux (at address 00000000) ...                      
> Boot reached stage 15                                                           
> id mach(): done                                                                 
> MMU:enter                                                                       
> MMU:hw init                                                                     
> MMU:mapin                                                                       
> MMU:setio                                                                       
> MMU:exit                                                                        
> setup_arch: enter                                                               
> setup_arch: bootmem                                                             
> arch: exit                                                                      
> ??????                                              

Try disabling early text debugging (all that "MMU:..." stuff).

-- 
Eugene
