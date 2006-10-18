Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE031D7613@CA1EXCLV02.adcorp.kla-tencor.com>
References: <91B22F93A880FA48879475E134D6F0BE031D7613@CA1EXCLV02.adcorp.kla-tencor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <54EA2493-0567-4ED7-A987-DB45B34B2ADC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How does Linux treat memory above the "mem=" mark?
Date: Wed, 18 Oct 2006 08:42:53 -0500
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 17, 2006, at 1:04 PM, Howard, Marc wrote:

> Hi,
>
> I have a PPC440GX board with 512M of memory.  I use "mem=496M" boot
> argument to keep Linux from using the uppermost 16MB of memory.  That
> region of memory is instead used for hardware communications.
> Occasionally however the CPU will read/write this space as well.
>
> My questions concerns TLB entries.  How does Linux define this  
> region in
> the TLB?  Does it define this region as non-cacheable in the TLB?  If
> not, what is the correct way to define an area of memory that is  
> outside
> the OS's control as non-cacheable?

Linux will not touch the the memory from 496 to 512M.  If you want to  
have access to it you'll have to explicitly map it.  Depending on  
what type of mapping you use will get different page attributes.  For  
example of use ioremap() it will be marked non-cacheable/guarded (I  
forget if 44x adds any other attributes).

It sounds like you want to access the region as non-cacheable, you  
can than just use ioremap() to get the desired effect.

- k
