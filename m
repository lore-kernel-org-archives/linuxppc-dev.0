Return-Path: <vbendeb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 8E7D1DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Oct 2008 14:57:46 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so761479wag.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 02 Oct 2008 21:57:44 -0700 (PDT)
Message-ID: <f608b67d0810022157q464687e6i8162d8f9f6b319dd@mail.gmail.com>
Date: Thu, 2 Oct 2008 21:57:44 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Stefan Roese" <sr@denx.de>
Subject: Re: EMAC2 in ibm_newemac driver
In-Reply-To: <200810020751.42821.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0810012138w64ba5ecbg1f88fff505c820b7@mail.gmail.com>
	<200810020751.42821.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 1, 2008 at 10:51 PM, Stefan Roese <sr@denx.de> wrote:
> On Thursday 02 October 2008, vb wrote:
>>
>
> The ibm_newemac driver in the DENX repository has absolutely no changes to the
> kernel.org version.
>

I am comparing between  2.6.26.5 and your tree, these are the
differences I referred to.

>> I am trying to debug it, but  am wondering if anyone had more than two
>> interfaces going on this architecture and if so - what are the
>> gotchas.
>
> The AMCC Glacier 460GT eval board uses all 4 EMAC's with RGMII. IIRC, then you
> need to configure the GPIO multiplexing differently (compared to Canyonlands
> 460EX) to fully support all 4 EMAC's on 460GT. This is done in U-Boot. I
> suggest that you check this configuration first.
>

Stefan, you are a gentleman and a scholar: this is exactly where my
problem was. Thank you for saving me from wasting lots of time trying
to figure out what's 'wrong' with the driver.

Now, comparing glacier GPIO settings with the 460Gx datasheet (rev
1.07 of May 29) it seems that the datasheet is wrong and suggests
using of ALT2 mode for the RGMII2 gpio pins(does not work) as opposed
ALT1 used in glacier (and actually working apart from a problem I
still am seeing with the TX). Do you remember anything about this?

TIA,
vadim

> Best regards,
> Stefan
>
