To: "Sylvain Munaut" <tnt@246tnt.com>
Cc: "ppc linux embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting rid of static IO mapping
References: <40EC2DC8.5020400@246tNt.com>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Wed, 07 Jul 2004 19:41:28 -0400
In-Reply-To: <40EC2DC8.5020400@246tNt.com> (Sylvain Munaut's message of
 "Wed, 7 Jul 2004 13:07:20 -0400")
Message-ID: <wn5llhvgzbr.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 7 Jul 2004, tnt@246tnt.com wrote:

>
> Hi
>
> I'll try to re-explain my problem more clearly. Maybe some one will
> see a solution.
>
> I'm trying to avoid any static io mapping. So no use of
> setup_io_mapping. I also setup a handler for ppc_md.progress to have
> early debug.
> This progress function makes use of the UART, so at every call the
> uart must be mapped and I have to know where.

I'm NOT sure what are you trying to avoid. a typical setup_io_mapping
function is:


static void __init
my_card_map_io(void)
{
    io_block_mapping(MY_IO_VIRT_ADDR_1, MY_IO_PHYS_ADDR_1,
                     MY_IO_1_SIZE, PAGE_XXX);

    io_block_mapping(MY_IO_VIRT_ADDR_2, MY_IO_PHYS_ADDR_2,
                     MY_IO_2_SIZE, PAGE_XXX);

    ...
}


1. you HAVE TO provide the virt address and the phys
   address. io_block_mapping will not do it for you.


2. io_block_mapping will try to use available bats. if none avail, it
   will use pages. So you're NOT hardcoding the BAT values.


3. By CONVENTION, in your platform_init(), you should use bat3 to map
   the io space needed for your uart. Also by convention, you should
   reuse that same addresses in your setup_io_mapping(). So your UART
   is located at the SAME address BEFORE (via BAT3) and AFTER (using
   whatever io_block_mapping can use) the call to load_up_mmu().


I think you should probably explain what are you trying to achieve
before we can give you better suggestions.


--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
