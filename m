Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <421E06B9.2000504@nortel.com>
References: <421E06B9.2000504@nortel.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 15:33:38 +1100
Message-Id: <1109306018.14992.52.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: looking for help with scomc/scomd registers on 970
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-24 at 10:54 -0600, Chris Friesen wrote:
> Not strictly linux related, but I thought someone might know the answer.
> 
> I've got a request from someone that wants to be able to flush the L2 on 
> the 970.
> 
> The user manual has a procedure to do this, but it involves first 
> flipping the cache to direct-mapped mode by setting SCOM register 
> 0x43000 bit 0x8000.  The only thing is, I can't find any linux code that 
> ever touches the SCOM stuff, and the manual has no examples of *reading* 
> from the SCOM area, just writing to it, so I'm not entirely sure how to 
> do that.
> 
> A google search found the following snippet of darwin code:
> 
> 
> lis r8,cFIR ; Get the Core FIR register address
> ori r8,r8,0x8000 ; Set to read data
> sync
> mtspr scomc,r8 ; Request the Core FIR
> mfspr r25,scomd ; Get the source
> mfspr r8,scomc ; Get back the status (we just ignore it)
> sync
> isync	
> 			
> 
> 
> This implies that bit 0x8000 needs to be set to specify a read command, 
> and that we need to read the status after the read.  Does anyone know if 
> this is in fact the case?

I think so. Also, there are some erratas with early 970's where the
stuff is shifted one bit. The Darwin source is a good reference for
that.

> Also, in that code they make reference to early chip revisions that 
> returned scom reads shifted by one bit.  Does anyone know which versions 
> are affected?

I think all non-FX.

Ben.
