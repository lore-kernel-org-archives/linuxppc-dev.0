Message-Id: <199901171016.FAA19021@smtp-gw.vma.verio.net>
Date: Sun, 17 Jan 1999 05:16:24 -0500 (EST)
From: baccala@freesoft.org
Subject: RS/6000 860 portable - display problem fixed
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="17433089-1804289383-916568212=:583"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--17433089-1804289383-916568212=:583
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi -

OK, I had a bit of a "breakthrough" with this code, and while it still
doesn't do everything I want (the "BIG_SCREEN" mode doesn't display
externally on my VGA display, only on the LCD), it's a far sight better
than 24 hours ago.  Basically, I took out everything that changed the
VGA controller's clock settings, reasoning that they were already set
correctly by the boot ROM, and ended up with a display I can finally
read.

Patch is attached, relative to arch/ppc/boot.  What's the chain of
command for ppc?  Should I commit this code to vger.rutgers.edu in the
expectation that it'll find it way into Linus' tree?
-- 
					-bwb

					Brent Baccala
					baccala@freesoft.org

-------------------------------------------------------------------------
To receive periodic news about what's happening at freesoft.org, send
email to "announce@freesoft.org", with "SUBSCRIBE" as the message, i.e:
		echo SUBSCRIBE | mail announce@freesoft.org
-------------------------------------------------------------------------

--17433089-1804289383-916568212=:583
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: patch

*** vreset.c    1998/06/10 07:21:33     1.6
--- vreset.c    1999/01/17 10:07:12
***************
*** 613,620 ****
  unlockS3(void)
  {
          int s3_device_id;
!       outw(0x3d4, 0x3848);
!       outw(0x3d4, 0x39a5);
        outb(0x3d4, 0x2d);
        s3_device_id = inb(0x3d5) << 8;
        outb(0x3d4, 0x2e);
--- 613,620 ----
  unlockS3(void)
  {
          int s3_device_id;
!       outw(0x3d4, 0x3848);            /* Unlock registers CR2D - CR3F */
!       outw(0x3d4, 0x39a5);            /* Unlock registers CR40 - CRFF */
        outb(0x3d4, 0x2d);
        s3_device_id = inb(0x3d5) << 8;
        outb(0x3d4, 0x2e);
***************
*** 667,686 ****
                outb(0x3D4, 0x32);
                outb(0x3D5, inb(0x3D5)&~0x10);
        } else {
!                 outw(0x3c4, 0x0806);            /* IBM Portable 860 */
!                 outw(0x3c4, 0x1041);
!                 outw(0x3c4, 0x1128);
!                 outw(0x3d4, 0x4000);
!                 outw(0x3d4, 0x3100);
!                 outw(0x3d4, 0x3a05);
!                 outw(0x3d4, 0x6688);
!                 outw(0x3d4, 0x5800);            /* disable linear addressing */
!                 outw(0x3d4, 0x4500);            /* disable H/W cursor */
!                 outw(0x3c4, 0x5410);            /* enable auto-centering */
                  outw(0x3c4, 0x561f);
!                 outw(0x3c4, 0x1b80);            /* lock DCLK selection */
!                 outw(0x3d4, 0x3900);            /* lock S3 registers */
!                 outw(0x3d4, 0x3800);
        } /* endif */
  }
  
--- 667,694 ----
                outb(0x3D4, 0x32);
                outb(0x3D5, inb(0x3D5)&~0x10);
        } else {
!                 /* S3 86CM65 Aurora 64V+    (s3_device_id 0x8812)
!                  *
!                  * Dual display LCD/CRT chip used in IBM RS/6000 portable 860s
!                  */
!                 outw(0x3c4, 0x0806);  /* SR8 - unlock registers SR9 - SR6F */
!                 outw(0x3d4, 0x3100);  /* CR31 - normal mode */
!                 outw(0x3d4, 0x3a05);  /* CR3A - 2 refresh cycles/horz line */
!                 outw(0x3d4, 0x6688);  /* CR66 - PCI bus disconnect enable */
!                 outw(0x3d4, 0x5800);  /* CR58 - disable linear addressing */
!                 outw(0x3d4, 0x4500);  /* CR45 - disable H/W cursor */
! #ifdef SMALL_SCREEN
!                 outw(0x3c4, 0x5410);  /* SR54/56 - enable centering */
                  outw(0x3c4, 0x561f);
! #else
!                 outw(0x3c4, 0x541f);  /* SR54-57 - enable expansion */
!                 outw(0x3c4, 0x551f);
!                 outw(0x3c4, 0x561f);
!                 outw(0x3c4, 0x577f);
! #endif
!                 outw(0x3d4, 0x3900);  /* CR39 - lock registers CR40 - CRFF */
!                 outw(0x3d4, 0x3800);  /* CR38 - lock registers CR2D - CR3F */
!                 outw(0x3c4, 0x0800);  /* SR8 - lock registers SR9 - SR6F */
        } /* endif */
  }

--17433089-1804289383-916568212=:583--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
