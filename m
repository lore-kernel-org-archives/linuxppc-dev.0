Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1117000809.6395.92.camel@gaston>
References: <1117000809.6395.92.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0015d371e12596fecdefd971b4fb1e5a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 25 May 2005 01:08:06 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Somewhere, at some point, prior to VM setup, we need to forcibly map
>> virtual to physical addresses.  These are going to be "hard coded"
>> mappings, that's exactly how ioremap_bot is set.  This is why
>> io_block_mapping was created in the first place.  Somehow you have
>> to specify this mapping before you have a VM allocator to give it to
>> you. :-)
>
> No, you just need to have ioremap_bot (which is in fact "top" not
> "bottom", bad naming) initialized to something sane. This is currently
> done in MMU_init() but could probably be initialized statically 
> instead.
> I do just that on ppc64 and thus can ioremap at any time without 
> needing
> to allocate vmalloc space. The vmalloc space is automatically "cap'd" 
> by
> ioremap_bot anyway.

Can one of you explain why this is necessary.  I believe it I just dont 
understand.  I think this is one of the abuses of io_block_mapping().  
People, myself included, realize some of the caveats implied by calling 
io_block_mapping().

- kumar
