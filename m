Date: Thu, 29 Nov 2001 10:20:28 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
Message-Id: <20011129102028.7222155f.jpgarcia@execpc.com>
In-Reply-To: <15365.51839.327359.844495@gargle.gargle.HOWL>
References: <15365.51839.327359.844495@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Nov 2001 16:41:19 +1100 (EST)
Paul Mackerras <paulus@samba.org> wrote:
> So I am proposing to drop ppc_md.ide_init_hwif_ports and change the
> definition of ide_init_hwif_ports in include/asm-ppc/ide.h to the one
> above.
>
> Comments?

I'm not sure about details, so bare with my ignorance. :)

Will a call to ide.c:ide_register() then be using a generic ide_init_hwif_ports?

If so, since the pmac mediabay has a pmac port arrangement, it will need a modification.  It's call to ide_register() would be replaced with a direct call to pmac_ide_init_hwif_ports() followed by ide_register_hw().

While ide_pmac.c registers mediabay's inserted before booting, anything hotswapped is handled by mediabay.c.  There was a time (maybe still now) that some source trees made the pmac's entry in ppc.md_ide_init_hwif_ports generic, breaking the existing code in mediabay.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
