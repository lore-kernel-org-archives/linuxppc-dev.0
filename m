From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14269.42715.336106.140568@gargle.gargle.HOWL>
Date: Fri, 20 Aug 1999 15:04:59 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch for powercomputing keyboards
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all.  I've put together a hack that allows the CapsLock key on
PowerComputing keyboards to work reasonably as a control key.

I was trying to tackle two problems.  One is that 'a' was being generated
under X when releasing the capslock key.  This apparently went away when I
switched to Xfree68_fbdev.

However, the current code in 2.2.10 generates a down and up when capslock is
pressed and the 0x80 generated when it is released is not used.  To get
capslock to work correctly as a soft key, the capslock up has to be
interpreted correctly.  Since it returns 0x80, same as 'a' up, this makes it
more complicated.

What I did is create a little state machine that watches 'a' and capslock.  It
will generate the 0xb9 when capslock is released, the way a sane keyboard
should work.  The only place where things can get confused is if you press
capslock, press 'a', and then release capslock.  I made the assumption that
'a' would always be released first, since I had to guess at something.

With this patch in place, I can remap the capslock to be a control key and
everything behaves fine.

At the moment, I think this patch is incompatible with Apple hard-locking
keyboards. 

So anyone with a Powercomputing keyboard, please try this out and let me know
what you think.  The patch is against Linus' 2.2.10.  If it seems good, I
think it also will need a configuration, unless someone has a suggestion on
how to make it play nicely with Apple keyboards.

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

--------------------------------
*** mac_keyb.c.orig	Sun Jun  6 11:05:00 1999
--- linux/drivers/macintosh/mac_keyb.c	Sat Aug 14 01:06:21 1999
***************
*** 320,328 ****
--- 320,397 ----
  static void
  input_keycode(int keycode, int repeat)
  {
+ 	static int pcc_caps_state = 0;
  	struct kbd_struct *kbd;
  	int up_flag;
  
+ 	/* Kludge to try to fix capslock behavior for powercomputing
+ 	   keyboards.  On these, 0xb9 is returned on alternating
+ 	   capslock down events.  capslock up returns 0x80 - the same
+ 	   as A.  Fun fun.  */
+ 	/* This is a state machine to untangle capslock up
+ 	   and 'a' up on powercomputing keyboards */
+ 	switch (keycode) {
+ 	case 0x39:
+ 	case 0xb9:
+ 	  switch (pcc_caps_state) {
+ 	  case 0:
+ 	    pcc_caps_state = 2;
+ 	    break;
+ 	  case 1:
+ 	    pcc_caps_state = 3;
+ 	    break;
+ 	  case 4:
+ 	    pcc_caps_state = 5;
+ 	    break;
+ 	  default:
+ 	    break;
+ 	  }
+ 	  keycode = 0x39;	/* Change to capslock down */
+ 	  break;
+ 	case 0x00:
+ 	  switch (pcc_caps_state) {
+ 	  case 0:
+ 	    pcc_caps_state = 1;
+ 	    break;
+ 	  case 2:
+ 	  case 4:	/* We guessed right in returning A up previously */
+ 	    pcc_caps_state = 3;
+ 	    break;
+ 	  default:
+ 	    break;
+ 	  }
+ 	  break;
+ 
+ 	  /* This is the broken 0x80 return code from capslock
+ 	     or A.  We always assume A release first. */
+ 	case 0x80:
+ 	  switch (pcc_caps_state) {
+ 	  case 0:
+ 	  case 1:		/* A up */
+ 	    pcc_caps_state = 0;
+ 	    break;
+ 	  case 2:		/* CapsLock up */
+ 	    pcc_caps_state = 0;
+ 	    keycode = 0xb9;
+ 	    break;
+ 	  case 3:		/* Assume A up - we don't really know */
+ 	    pcc_caps_state = 4;
+ 	    keycode = 0x80;
+ 	    break;
+ 	  case 4:		/* Now assume CapsLock up */
+ 	    pcc_caps_state = 0;
+ 	    keycode = 0xb9;
+ 	    break;
+ 	  case 5:		/* Return an A up */
+ 	    pcc_caps_state = 4;
+ 	    keycode = 0x80;
+ 	    break;
+ 	  }
+ 	  break;
+ 	default:
+ 	  break;
+ 	}
+ 		  
   	kbd = kbd_table + fg_console;
  	up_flag = (keycode & 0x80);
  	keycode &= 0x7f;
***************
*** 383,400 ****
  		 * is pressed/released. Also, makes sure that the
  		 * LED are handled.  atong@uiuc.edu
  		 */
! 		 switch (keycode) {
! 		 /*case 0xb9:*/
! 		 case 0x39:
! 			handle_scancode(0x39, 1);
! 			handle_scancode(0x39, 0);
! 		 	mark_bh(KEYBOARD_BH);
! 		 	return;
! 		 case 0x47:
! 		 /*case 0xc7:*/
! 		 	mark_bh(KEYBOARD_BH);
! 		 	break;
! 		 }
  	}
  
  	handle_scancode(keycode, !up_flag);
--- 452,473 ----
  		 * is pressed/released. Also, makes sure that the
  		 * LED are handled.  atong@uiuc.edu
  		 */
! 		
! 		/* 0xb9 and 0x39 commented out because they don't let
! 		   capslock work as anything else */
! 		switch (keycode) {
! 		  /*case 0xb9:*/
! 		  /*		 case 0x39:
! 				 handle_scancode(0x39, 1);
! 				 handle_scancode(0x39, 0);
! 				 mark_bh(KEYBOARD_BH);
! 				 return; */
! 		case 0x39:
! 		case 0x47:
! 		  /*case 0xc7:*/
! 		  mark_bh(KEYBOARD_BH);
! 		  break;
! 		}
  	}
  
  	handle_scancode(keycode, !up_flag);


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
