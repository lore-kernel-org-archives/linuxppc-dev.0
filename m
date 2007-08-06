Return-Path: <hancockr@shaw.ca>
Received: from pd3mo1so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id 34E26DDECE
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:35:49 +1000 (EST)
Received: from pd3mr4so.prod.shaw.ca
	(pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JMD00JIDIRJUL80@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 06 Aug 2007 16:35:43 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JMD008AKIRAZU10@pd3mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 06 Aug 2007 16:35:43 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JMD00CKGIR9A5T0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 06 Aug 2007 16:35:33 -0600 (MDT)
Date: Mon, 06 Aug 2007 16:35:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2:
	enforce	32bit	DMA	mapping"
In-reply-to: <1186439529.938.95.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <46B7A22D.4030909@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<1186351473.938.21.camel@localhost.localdomain>
	<20070806135124.GA2900@suse.de>
	<1186436848.938.75.camel@localhost.localdomain>
	<46B79F25.50205@s5r6.in-berlin.de> <46B79FD7.9020801@shaw.ca>
	<1186439529.938.95.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	stable@kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2007-08-06 at 16:25 -0600, Robert Hancock wrote:
>>> Anyway.  For now I will simply go with what 2.6.23-rc has and what
>>> 2.6.21 had:  No dma_set_mask anywhere in the 1394 subsystem.  We can
>>> revisit this whenever an actual need arises.
>> Not sure this is a very good idea. This seems rather likely to fail on
>> x86_64 machines with >4GB of RAM for example.. 
> 
> Would it ? Isn't the default DMA mask for PCI devices set to 32 bits
> anyway ? In which case, swiotlb will take care of the matter.
> 
> Cheers,
> Ben.

Hmm, that's true, yes. Suppose it shouldn't be a problem then.

I would agree, though, that sbp2 isn't really the place for setting 
this, since the DMA mask is presently a property of the device, not of 
the user..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
