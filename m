Date: Sun, 7 Feb 1999 19:19:05 -0600 (EST)
From: Jeff Zahourek <jeffzahourek@cjnetworks.com>
Reply-To: jeffzahourek@cjnetworks.com
To: linuxppc-dev@lists.linuxppc.org
Subject: atyfb.c detecting vram size incorrectly for XClaim 3D 8MB
Message-ID: <Pine.LNX.3.96.990207185451.1793A-100000@thor.valhalla.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I have found the following small problem with
linux/drivers/video/atyfb.c in the 2.2.0-pre9 kernel source from the
vger tree and in the 2.2.1 kernel source from kernel.org.

Beginning at line 2571 (vger tree) is the following conditional which 
adds 4 MB to the variable(?) info->total_vram. Commenting this out and 
replacing with a ";" results in no lies being told about the size of
the available vram. BootX no longer reports 12MB, rather a correct 8MB
of SGRAM, and OF booting results in kernel reporting the 4MB that is 
actually initialised. This is not really useful in itself but it does 
reveal that the vram-size of Rage Pro (GI_CHIP_ID) cards is not being 
properly sensed. I don't know why anyone would set a bogus value here, 
but that is what is being done. Perhaps someone smarter than me can
figure out what to change to get the vram size properly recognized 
during initialisation. I have simply copied the code which sets the vram 
size from the default supplied with kernel arguments to always initalise 
the card to 8MB. Since this is the beauty of open source for the amateur  
schmuck, I'm quite happy. Geert may want to investigate and actually fix 
this so it does the right thing. I'm not having much luck muddling
through.

Offending code

    if (Gx == GI_CHIP_ID) {
        if (aty_ld_le32(CONFIG_STAT1, info) & 0x40000000)
          info->total_vram += 0x400000;
    }

What I did

    if (Gx == GI_CHIP_ID) {
        if (aty_ld_le32(CONFIG_STAT1, info) & 0x40000000)
/*          info->total_vram += 0x400000;               */
/*  replace line above with the following ugliness      */
/*  to avoid passing the video=atyfb:vram:8192 argument */
/*  to kernel at boot time. I really dislike that.      */
            info->total_vram = 0x800000;
            i = i & ~(gtb_memsize ? 0xF : MEM_SIZE_ALIAS);
            i |= gtb_memsize ? MEM_SIZE_8M_GTB : MEM_SIZE_8M;
            aty_st_le32(MEM_CNTL, i, info);
    }

I'm certain this will be properly fixed soon, but maybe nobody has
noticed this specific minor problem with the code.

{]>===-                       {]>===-                         {]>===- 
Jeff Zahourek                            Because without beer, things
jeffzahourek@cjnetworks.com              do not seem to go as well.
http://www.cjnetworks.com/~jeffzahourek/                 -- Anonymous


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
