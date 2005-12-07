Return-Path: <dwilson@dslextreme.com>
Received: from mail5.dslextreme.com (mail5.dslextreme.com [66.51.199.81])
	by ozlabs.org (Postfix) with SMTP id 338AC6884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 15:58:21 +1100 (EST)
Message-ID: <200512062059330484.282740E4@smtp.dslextreme.com>
In-Reply-To: <C7B817D4-457A-414A-BA2B-4A80DF0FA3E0@kernel.crashing.org>
References: <Pine.LNX.4.44.0511300013110.32230-100000@gate.crashing.org>
	<200511292318160218.0499BB92@smtp.dslextreme.com>
	<C7B817D4-457A-414A-BA2B-4A80DF0FA3E0@kernel.crashing.org>
Date: Tue, 06 Dec 2005 20:59:33 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Cc: ppc list <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC85xx i2c interface bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/6/2005 at 11:24 AM Kumar Gala wrote:

> Dan,
> 
> I'm in agreement with your change for the 2.4 kernel.  It looks like  
> the 2.6 kernel driver is handing TXAK correctly.  The following is a  
> snippet from the 2.6 driver:
> 
>          if (length) {
>                  if (length == 1)
>                          writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA  
> | CCR_TXAK);
>                  else
>                          writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA);
>                  /* Dummy read */
>                  readb(i2c->base + MPC_I2C_DR);
>          }
> 
>          for (i = 0; i < length; i++) {
>                  if (i2c_wait(i2c, timeout, 0) < 0)
>                          return -1;
> 
>                  /* Generate txack on next to last byte */
>                  if (i == length - 2)
>                          writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA  
> | CCR_TXAK);
>                  /* Generate stop on last byte */
>                  if (i == length - 1)
>                          writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
>                  data[i] = readb(i2c->base + MPC_I2C_DR);
>          }
> 
> 
> If I'm reading it correctly it matches your changes.  If you dont  
> mind looking at this and verifying that you agree that we are setting  
> TXAK as expected.
> 
> - kumar
> 

Kumar,

Yes, the 2.6 code looks good to me too.  Thanks much for your help!

Dan.
