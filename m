Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail2.matrix-vision.com (mail2.matrix-vision.com
	[85.214.244.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "template", Issuer "template" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7E5E5B6FAD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2011 19:53:21 +1000 (EST)
Message-ID: <4DDB7EA6.7000404@matrix-vision.de>
Date: Tue, 24 May 2011 11:47:18 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: PCI DMA to user mem on mpc83xx
References: <4DDA2509.6070702@matrix-vision.de>
	<20110523172727.GA21717@ovro.caltech.edu>
In-Reply-To: <20110523172727.GA21717@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira,

> On Mon, May 23, 2011 at 11:12:41AM +0200, Andre Schwarz wrote:
>> Ira,
>>
>> we have a pretty old PCI device driver here that needs some basic rework
>> running on 2.6.27 on several MPC83xx.
>> It's a simple char-device with "give me some data" implemented using
>> read() resulting in zero-copy DMA to user mem.
>>
>> There's get_user_pages() working under the hood along with
>> SetPageDirty() and page_cache_release().
>>
>> Main goal is to prepare a sg-list that gets fed into a DMA controller.
>>
>> I wonder if there's a more up-to-date/efficient and future proof scheme
>> of creating the mapping.
>>
>>
>> Could you provide some pointers or would you stick to the current scheme ?
>>
> This scheme is the best you'll come up with for zero-copy IO. I used
> get_user_pages_fast(), but otherwise my implementation was the same.
> These interfaces should be fairly future proof.
excellent - thanks.
Will stick to it then ...
> In the end, I realized that most of my transfers were 4 bytes in length,
> and zero copy IO was a waste of effort. I decided to use mmap instead.
>

I'm using 98% page sized (4KiB) scatter gather transfers summing up to 
~80MiB/sec sustained throughput.




Cheers,
André

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
