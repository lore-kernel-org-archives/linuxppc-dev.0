Date: Thu, 2 Sep 1999 15:29:02 -0400 (EDT)
From: David King <dsmk@imp.bu.edu>
Message-Id: <199909021929.PAA21753@imp.bu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: USB mouse kernel patch for Lombard gpm multiple mice support
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I've been lurking on this list for tips on getting my Lombard to work
nicely under Linux.  Using the latest stable samba rsync sources I've been 
able to build a kernel which does accelerated X, ethernet, sleeping, and 
USB.   The only thing left preventing me from being comfortable was one
quirk.

Unlike other mouse drivers, the USB mouse device driver can only be 
openned if a mouse is attached.  This makes using gpm in multiple mouse mode
on a laptop difficult as sometimes I'd like to work without the USB mouse
attached.  It seemed wrong to have to restart gpm to make this change so
without further ado here is my kernel patch to drivers/usb/mouse.c

-David
dsmk@imp.bu.edu

*** mouse.c.19990902    Wed Jul 28 20:37:13 1999
--- mouse.c     Thu Sep  2 14:42:45 1999
***************
*** 6,11 ****
--- 6,16 ----
   *
   * Brad Keryan 4/3/1999
   *
+  * (dsmk) David King 9/2/1999 - rewrote mouse detect logic so that client 
+  * programs such as gpm can open the mouse device even though there is
+  * currently no mouse detected.  This enables one to use gpm's multiple 
+  * mouse software with USB mice with hotswapping on my Powerbook G3 1999.
+  * 
   * version 0.20: Linus rewrote read_mouse() to do PS/2 and do it
   * correctly. Events are added together, not queued, to keep the rodent sober.
   *
***************
*** 128,135 ****
  {
        struct mouse_state *mouse = &static_mouse_state;
  
!       if (!mouse->present)
!               return -EINVAL;
        if (mouse->active++)
                return 0;
        /* flush state */
--- 133,144 ----
  {
        struct mouse_state *mouse = &static_mouse_state;
  
!       /* no longer bomb out when mouse is not present.  Instead 
!        * we wait producing no data until a mouse is present
!        * -dsmk 9/2/1999
!        */
!       /*if (!mouse->present)
!         return -EINVAL; */
        if (mouse->active++)
                return 0;
        /* flush state */
***************
*** 139,145 ****
        MOD_INC_USE_COUNT;
  
        /* start the usb controller's polling of the mouse */
!       mouse->irq_handle = usb_request_irq(mouse->dev, usb_rcvctrlpipe(mouse->d
ev, mouse->bEndpointAddress), mouse_irq, mouse->bInterval, NULL);
  
        return 0;
  }
--- 148,158 ----
        MOD_INC_USE_COUNT;
  
        /* start the usb controller's polling of the mouse */
!       /* only do this if we have a mouse already
!        * -dsmk 9/2/1999
!        */
!       if (mouse->present) 
!         mouse->irq_handle = usb_request_irq(mouse->dev, usb_rcvctrlpipe(mouse-
>dev, mouse->bEndpointAddress), mouse_irq, mouse->bInterval, NULL);
  
        return 0;
  }
***************
*** 305,311 ****
--- 318,333 ----
        mouse->bEndpointAddress = endpoint->bEndpointAddress;
        mouse->bInterval = endpoint->bInterval;
  
+       /* if we did not have a mouse before then we need to set up an
+        * irq if someone already has the mouse active
+        * -dsmk 9/2/1999
+        */
+       if (! mouse->present && mouse->active) {
+         mouse->irq_handle = usb_request_irq(mouse->dev, usb_rcvctrlpipe(mouse-
>dev, mouse->bEndpointAddress), mouse_irq, mouse->bInterval, NULL);
+       }
+ 
        mouse->present = 1;
+ 
        return 0;
  }

----
 David King, Boston University Distributed Systems Programmer at large
 dsmk@bu.edu
 (617) 353-8250 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
