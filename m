From: baccala@freesoft.org
Message-Id: <199902110602.AAA23709@lists.linuxppc.org>
Date: Thu, 11 Feb 1999 01:03:01 -0500 (EST)
Subject: zimage relocation
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi -

I'm having trouble with the recent (~ 1.5 weeks ago) changes to
arch/ppc/boot/misc.c, relating to MBX image relocation.  On my IBM 860
laptop, the relocation never used to run ('cause I wasn't using
ramdisks), but now it does, and the image doesn't decompress properly.

If I comment out this section of code in misc.c, everything works fine:

if ( (( (unsigned long)zimage_start <= 0x01000000 ) && initrd_start)
         || needs_reloc)
{
        memcpy ((void *)PAGE_ALIGN(-PAGE_SIZE+(unsigned long)end_avail-zimage_size),
                 (void *)zimage_start, zimage_size );
        zimage_start = (char *)PAGE_ALIGN(-PAGE_SIZE+(unsigned long)end_avail-zimage_size);
        end_avail = (char *)zimage_start;
        puts("relocated to:  "); puthex((unsigned long)zimage_start);
        puts(" ");
        puthex((unsigned long)zimage_size+(unsigned long)zimage_start);
        puts("\n");
}

Clearly, the machine is responding to
needs_reloc, since my initrd_start is 0, no ramdisk.  needs_reloc was
set by the Motorola detect code.  So what does the Motorola detect
actually do, why would it be triggered on my IBM 860, and what should
be done about it?
-- 
					-bwb

					Brent Baccala
					baccala@freesoft.org

-------------------------------------------------------------------------
To receive periodic news about what's happening at freesoft.org, send
email to "announce@freesoft.org", with "SUBSCRIBE" as the message, i.e:
		echo SUBSCRIBE | mail announce@freesoft.org
-------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
