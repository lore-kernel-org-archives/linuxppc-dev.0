Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3466BDDF9F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 03:30:16 +1000 (EST)
Date: Fri, 27 Apr 2007 10:30:08 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] SystemACE driver - abstract register ops
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
In-Reply-To: <528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <20070427173010.620DE4B8073@mail25-fra.bigfish.com>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, Stefan Roese <sr@denx.de>,
	linuxppc-embedded@ozlabs.org, Rick Moleres <rick.moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I wanted to say that I am VERY excited about all the great work that is 
happening here. As some of you know I am currently working on setting up 
a Linux kernel git tree that contains a multitude of Xilinx drivers such 
as IIC, SPI, GPIO, SYSACE, EMAC, EMACLITE, UARTLITE versions, FLASH as 
well support for the MicroBlaze processor.
In addition I pulled Grant's virtex-dev branch (with TEMAC and SYSACE). 
I will integrate those as soon as I'm done with the other work. I am 
already eying the FrameBuffer driver from Andrei.

The end goal is to have a kernel tree that contains ALL Xilinx drivers 
and the multitude of drivers that are being created/updated and 
contributed here. Having such a kernel available will simplify the 
process of bringing up a new system. The hope is that contributors will 
adopt the idea of having a "Xilinx" kernel and will start using that 
tree as a "base reference".

At this point the Xilinx kernel branch is based on version v2.6.20 with 
the uc0 patch applied, as well as the various LynuxWorks patches that 
support MicroBlaze and add the mentioned drivers. The LynuxWorks code 
has been cleaned up to not contain the proprietary hardcoded sections to 
make it more acceptable to the Open Source community. I'm sure there's 
more work to be done, but it's a start.

Once the git server is up and running we will be adding new drivers they 
become available and integrate patches and updates along the way.

Unfortunately, I spend a lot of my time now working the politics of 
getting a git server up and running and convincing management that this 
actually _is_ a good idea. It's slow going and there's a lot of meetings 
and discussions going on. But I'm still hopeful. As a backup I'm trying 
to get a kernel.org/git account so I can publish the tree there.

I will post news here as they unfold. In the meantime it would be very 
interesting to hear ideas and suggestions from you. Concerns that people 
have. Pitfalls to look out for etc.

Thanks,
    Wolfgang



Grant Likely wrote:
> On 4/27/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
>> Grant,
>>
>> Thanks for your work on the SystemACE driver - I'll be porting/merging
>> this across to MicroBlaze very shortly.
> 
> Very cool; I hope it works well.
> 
>> Given that SysACE can be hooked up in any number of ways, bit widths,
>> endians, PPC/Microblaze, can you please offer your comments on the
>> attached patch?
> 
> Okay, after getting over my initial mirth about working on the *exact*
> same thing and finishing it at the *exact* time that you sent me your
> patch, I think I'm ready to make useful comments.  :-)
>>
>> It introduce a private ace_reg_ops structure, with various member
>> functions for the different kinds of accesses to the HW.
>>
>> This patch should not change the functionality of your original driver
>> at all, it's just groundwork for what's to come.
>>
>> I recognise that it adds indirection into the various access paths, and
>> potentially a little bloat.  Whether this is better than #if
>> 1...#else...#endif is debatable.
> 
> I'm not to concerned with the added redirection.  On my 405 designs, I
> find that bus overhead has a far greater impact than any of the
> processing paths in the driver, so this shouldn't be a problem.
> Besides, when we finally move to arch/powerpc, it will become very
> feasable to have a single kernel image that will boot on multiple
> ppc405 FPGA configurations; just change the device tree passed in.
> 
>> Similar issues will arise for most (all?) of the Xilinx drivers that we
>> will share between PPC and MicroBlaze.  Hopefully we can converge on a
>> nice consistent and clean way of handling these dual arch drivers.
> 
> I agree 100%
> 
> For your reading pleasure, I've attached the bus attachment changes
> that I've made in my tree.  I hope to get this driver accepted into
> mainline during the 2.6.22 merge window; so please get any comments
> you have back to me ASAP.
> 
> Cheers,
> g.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
