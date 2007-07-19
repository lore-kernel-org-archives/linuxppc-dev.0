Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E19DDDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 06:16:11 +1000 (EST)
Message-ID: <469FC682.9050206@freescale.com>
Date: Thu, 19 Jul 2007 15:16:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 30/61] fsl_soc: Update the way get_brgfreq() finds things
	in the device tree.
References: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
	<8DC2DA02-3D10-4D14-AC91-E34AEA68E04F@kernel.crashing.org>
	<469E408F.1080300@freescale.com>
	<624A5740-A6D3-4AF3-8AA7-100D0FFFF045@kernel.crashing.org>
In-Reply-To: <624A5740-A6D3-4AF3-8AA7-100D0FFFF045@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Jul 18, 2007, at 11:32 AM, Scott Wood wrote:
>> Kumar Gala wrote:
>>> Does 'fsl,cpm' really mean anything useful?
>>
>> Yes.  It's can't be used on its own to show the complete  programming 
>> model, but there are lots of common things that it does  indicate.
>>
>> get_brgfreq() uses it to locate nodes which have an fsl,brg- frequency 
>> property.
> 
> I think we should introduce 'fsl,cpm' in a second pass once its clear  
> what all the common points are.  We can than also see if QE fits into  
> it at that point.

Upon further thought (and upon being clearly outvoted), I agree -- 
what's common among CPMs today may not be among future CPMs/QEs.  In the 
absence of a commitment from marketing to call it something else if 
certain things change, it's no more meaningful than "xx"-type names.

>> The CPM binding is changed in so many other ways that are much  harder 
>> to make backward compatible that I don't really see much  point in 
>> doing so here.
> 
> Can you enumerate some of the other changes.

The hardest would probably be the PCI node, whose reg property 
definition changed (the previous tree was including other things, such 
as DMA controllers, in the PCI register resource).  The CPM node also 
had its reg property changed, though I don't think anything was using it 
yet.  The old way of specifying the 8272ads BCSR (in the /memory node) 
is just too broken to leave in the device tree.

The old compatible names and custom properties could be left in for a 
little while for existing boards, though.

-Scott
