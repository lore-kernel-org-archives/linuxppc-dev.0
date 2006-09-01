Return-Path: <mika.penttila@kolumbus.fi>
Received: from mail-gw1.turkuamk.fi (mail-gw1.turkuamk.fi [195.148.208.125])
	by ozlabs.org (Postfix) with ESMTP id 144BC67B7E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2006 18:58:38 +1000 (EST)
Message-ID: <44F7F376.4030203@kolumbus.fi>
Date: Fri, 01 Sep 2006 11:46:46 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
	free_area_init_nodes
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
	<20060821134638.22179.44471.sendpatchset@skynet.skynet.ie>
	<a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>
	<20060831154903.GA7011@skynet.ie>
	<a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com>
	<Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie>
	<a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com>
	<Pine.LNX.4.64.0609010928010.25057@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0609010928010.25057@skynet.skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, tony.luck@intel.com, linuxppc-dev@ozlabs.org, ak@suse.de,
	bob.picco@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Keith Mannthey <kmannth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>
> Right, it's all very clear now. At some point in the future, I'd like 
> to visit why SPARSEMEM-based hot-add is not always used but it's a 
> separate issue.
>
>> The add areas
>> are marked as RESERVED during boot and then later onlined during add.
>
> That explains the reserve_bootmem_node()
>
But pages are marked reserved by default. You still have to alloc the 
bootmem map for the the whole node range, including reserve hot add 
areas and areas beyond e820-end-of-ram. So all the areas are already 
reserved, until freed.

--Mika
