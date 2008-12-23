Return-Path: <scottwood@freescale.com>
Message-ID: <495135A3.9090709@freescale.com>
Date: Tue, 23 Dec 2008 13:01:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jeff angielski <jeff@theptrgroup.com>
Subject: Re: cpm2-scc-uart on mpc8265 not working
References: <1229977289.19292.16.camel@penguin>	 <49500029.90809@freescale.com>
	<1230057813.11655.27.camel@penguin>
In-Reply-To: <1230057813.11655.27.camel@penguin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

jeff angielski wrote:
> I fixed up the DPRAM regions.  
> 
> I also fixed up the muram region which had not been updated for the
> mpc8265 - it still had the old mpc8272 definitions.
> 
> The kernel does not hang anymore but I still don't see anything on the
> serial port.  Using an o'scope I can see data on the line, it is just
> that bit period is about 560uS - way to slow.

U-boot needs to fill in the clock-frequency property in the brg node.

> 				data@0 {
> 					/*
> 					reg = <0x0 0x2000 0x9800 0x800>;
> 					*/
> 					compatible = "fsl,cpm-muram-data";
> 					reg = <0x0 0x6000 0x8000 0x1000 0xb000 0x1000>;

This is not correct -- you should only list the DPRAM regions that are 
usable for arbitrary data.  This is <0 0x4000>, assuming none of that 
has been allocated to microcode.

-Scott
