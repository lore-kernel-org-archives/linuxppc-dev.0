Message-Id: <200109061612.MAA12144@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Date: Thu, 6 Sep 2001 12:04:01 -0400
References: <85256ABF.0054965D.00@pine.cspi.com>
In-Reply-To: <85256ABF.0054965D.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,
I was in the process of writing the same message you wrote. I would be more
than willing to test the patch. Right now here is what I do in misc-simple.c

  /*
         * Find a place to stick the zimage and initrd and
         * relocate them if we have to. -- Cort
         */
        avail_ram = (char *)PAGE_ALIGN((unsigned long)_end);
        puts("zimage at:     "); puthex((unsigned long)zimage_start);
        puts(" "); puthex((unsigned long)(zimage_size+zimage_start));
puts("\n");
        if ( ((unsigned long)zimage_start  >= 0xf0000000) ||
              ((unsigned long)zimage_start <= 0x00800000) )


Is there a better way than testing against 0xf0000000 to tell if you are in
FLASH memory. I'd like something more generic or at least less hardcoded.
Anyway, send me any code you want tested and Ill let you know how it behaves.


On Thursday 06 September 2001 11:23 am, you wrote:
> On Thu, Sep 06, 2001 at 10:55:46AM -0400, Brian Waite wrote:
> > I am playing with the MVME5100 and I am having a bit of trouble with
>
> booting
>
> > using bugboot and an initrd. I get a message at bootup saying initrd > 16
>
> MB
>
> > and then as it is booting it gets an oops in mem_init.
>
> [snip]
>
> > My question is is the failure due to the bootloader not relocating the
>
> initrd
>
> > or is it that ClearPageReserved() is being called when the initrd is in
> > FLASH? Any ideas?
>
> Right now, we only see if we need to relocate the initrd if we need to
> relocate
> the kernel.  I'll go and fix this (I think gemini has the right idea).

--
Thanks

Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
