Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 9A103DDFBD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 23:57:21 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2175466ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 06:57:12 -0700 (PDT)
Message-ID: <fa686aa40806120657k4d692595hac04f1739eb0b88d@mail.gmail.com>
Date: Thu, 12 Jun 2008 07:57:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB
In-Reply-To: <20080612132936.GB21060@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806111143.08905.david.jander@protonic.nl>
	<200806111144.44218.david.jander@protonic.nl>
	<48501725.9080907@freescale.com>
	<200806121233.13089.david.jander@protonic.nl>
	<20080612132936.GB21060@ld0162-tx32.am.freescale.net>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 7:29 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Thu, Jun 12, 2008 at 12:33:12PM +0200, David Jander wrote:
>> > > +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>> > >   /*
>> > >    * Enable big endian and don't care about SDMA FC.
>> > >    */
>> > >   FW(fecp, fun_code, 0x78000000);
>> > > +#else
>> > > + /*
>> > > +  * Set DATA_BO and DESC_BO and leave the rest unchanged
>> > > +  */
>> > > + FS(fecp, dma_control, 0xc0000000);
>> > > +#endif
>>
>> I have tried, but it is almost impossible, since both FEC types use a struct
>> named "fec_t" which very different betwen both types. That means that the code
>> would have enormous amounts of "if" statements all over.
>> Any suggestion?
>
> OK, I missed that this was FEC-specific code and not general fs-enet.
>
> 8xx/512x multiplatform is already unsupported due to core differences,
> but make sure that 82xx/512x multiplatform doesn't get broken.

Yeah, but the amount of #ifdefs required in this drivers adds a
maintenance burden.  I think I'd rather see it either refactored or
cloned.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
