Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 236A1DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Oct 2007 04:25:15 +1000 (EST)
In-Reply-To: <87ve9nw2ft.fsf@macbook.be.48ers.dk>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Device tree and external RTC
MIME-Version: 1.0
Message-ID: <OFF5EAF9C9.4E27AE67-ON8825736A.0064875E-8825736A.00652EB0@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 4 Oct 2007 11:25:10 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: Peter Korsgaard <jacmet@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,

Peter Korsgaard <jacmet@gmail.com> wrote on 10/04/2007 04:21:10 AM:

> >>>>> "Bruce" == Bruce Leonard <Bruce_Leonard@selinc.com> writes:
> 
> 
> You need to add #address/size-cells to the I2C node, E.G.:
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> 
> 
> You need to set compatible and reg, E.G.
>          rtc@54 {
>             device_type = "rtc";
>             compatible = "stm,m41t00";
>             reg = <54>;
>          };
> 
> And it should get picked up automatically by
> fsl_soc.c:of_find_i2c_driver().
> 
> Notice that you will need to use galak's git tree

Thanks for the info.  It's this sort of thing that isn't clearly 
documented anywhere, and until I'm REALLY familiar with the kernel knowing 
where to look is a challenge.

A follow on question though.  I've looked at the patch and it seems to be 
just adding 6 lines to an existing array in fsl_soc.c.  However, I can't 
seem to find any array in fsl_soc.c that contains lines that the patch 
indicates should already be there (i.e., there's nothing in fsl_soc.c that 
has the word "ricoh" in it which the patch indicates it should).  Is my 
fsl_soc.c already out of date?  Will the patch apply?  I've got 2.6.22.

Bruce
