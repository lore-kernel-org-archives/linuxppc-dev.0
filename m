Return-Path: <cajus.hahn@de.abb.com>
Received: from nse3.abb.com (nse3.abb.com [129.35.204.69])
	by ozlabs.org (Postfix) with ESMTP id C302567F89
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 18:21:19 +1000 (EST)
In-Reply-To: <20050812080113.AA881352B36@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OF41EC9A74.A4DE3DB8-ONC125705B.002CB094-C125705B.002DE3E7@de.abb.com>
From: cajus.hahn@de.abb.com
Date: Fri, 12 Aug 2005 10:21:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx: i2c-algo-8xx - fixed timeout detection and transmission
	errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





My description seems to be a little misleading.
WITHOUT the force_reinit() my SPI driver reports transmission errors if the
I2C bus has longer disturbances.
WITH the force_reinit() my SPI driver works fine.
This sounds like the I2C allocates a new buffer for every timed-out
transmision. If all I2C buffers are full, the SPI buffers get overwritten
!?
I did not really trace back the problem, this is only my suspicion.
Because the  force_reinit() resets all the buffer pointer to their init
values the problem with the SPI does not occur.

Cajus



Message from Wolfgang Denk <wd@denx.de>@denx.de received on 12.08.2005
10:01
                                                                                                                                        
                                                                                                                                        
                12.08.2005        Wolfgang Denk <wd@denx.de>@denx.de                                                                    
                  10:01                                                                                                                 
                                  Sent by wd@denx.de                                                                                    
                                                                                                                                        
                                                                                                                                        

                                                                                                                                      
                                                                                                                                      
                               To:       Cajus Hahn/DEAPR/ABB@ABB_DE01                                                                
                               cc:       linuxppc-embedded@ozlabs.org                                                                 
                               Subject:  Re: 8xx: i2c-algo-8xx - fixed timeout detection and transmission errors                      
                                                                                                                                      



In message
<OF29EF0D8D.F0A40A5C-ONC125705B.0028FA70-C125705B.002AF212@de.abb.com> you
wrote:
>
> Then I set the SCL line to ground to simulate a longer bus disturbance.
> After some timeouts my SPI bus, yes the SPI bus, reportet transmission
> errors. Both bus-interfaces use the CPM. It looks like the SPI buffer
gets
> garbaged by the I2C interface.

This is "normal". We see similar problems even with  perfectly  legal
operations  on  the CPM. The SPI is running at lowest priority on the
CPM, and anything that  causes  higher  CPM  load  will  starve  SPI.
Obviously  your  operation  causes  the  CPM  to go into some strange
state.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are certain things men must do to remain men.
             -- Kirk, "The Ultimate Computer", stardate 4929.4
