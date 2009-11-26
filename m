Return-Path: <albert_herranz@yahoo.es>
Received: from smtp103.mail.ukl.yahoo.com (smtp103.mail.ukl.yahoo.com
	[77.238.184.35]) by ozlabs.org (Postfix) with SMTP id C2F251007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 02:33:19 +1100 (EST)
Message-ID: <4B0E9FBC.1090900@yahoo.es>
Date: Thu, 26 Nov 2009 16:33:16 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>	
	<fa686aa40911221528y1980a95bw1dc8aa75a86c061e@mail.gmail.com>
	<1259212736.16367.271.camel@pasglop>
In-Reply-To: <1259212736.16367.271.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sun, 2009-11-22 at 16:28 -0700, Grant Likely wrote:
>>> +unsigned int flipper_pic_get_irq(void)
>>> +{
>>> +       void __iomem *io_base = flipper_irq_host->host_data;
>>> +       int irq;
>>> +       u32 irq_status;
>>> +
>>> +       irq_status = in_be32(io_base + FLIPPER_ICR) &
>>> +                    in_be32(io_base + FLIPPER_IMR);
>>> +       if (irq_status == 0)
>>> +               return -1;      /* no more IRQs pending */
>> NO_IRQ_IGNORE 
> 
> Why no just 0 ? (aka NO_IRQ)
> 

I didn't know about 0 (I thought that was another valid interrupt).
I was used to -1 to tell that no IRQs were pending (at least from the ARCH=ppc days) :)

> Or do you know you are getting lots of spurrious that you don't want to
> account ?
> 

No, this is not the case here.

> Cheers,
> Ben.
> 

Thanks,
Albert
