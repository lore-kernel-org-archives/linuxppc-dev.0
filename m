In-Reply-To: <36A733F6.79E148C7@univ-rennes1.fr>
Date: Fri, 22 Jan 1999 11:44:35 +0100
To: costabel@wanadoo.fr, linuxppc-dev@lists.linuxppc.org,
        cort@persephone.cs.nmt.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: pre8(vger) kills button 3 on 1-button mouse
Message-Id: <19990122114435.018460@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I found the reason why the keyboard is no longer sending different
keycodes for left and right option key. In my patches, I was setting the
keyboard to the highest possible handler ID for a normal keyboard (that
is 3 or 5 instead of 1) but this is wrong: at handler 5, the Apple
Extended Keyboard will not send different codes.

The kernel fix is in mac_keyb.c, line 647, replace:

	/* Enable full feature set of the keyboard
	   ->get it to send separate codes for left and right shift,
	   control, option keys */
	for(i = 0;i < keyboard_ids.nids; i++) {
	    if (adb_try_handler_change(keyboard_ids.id[i], 5))
	    	printk("ADB keyboard at %d, handler set to 5\n", keyboard_ids.id[i]);
	    else if (adb_try_handler_change(keyboard_ids.id[i], 3))
	    	printk("ADB keyboard at %d, handler set to 3\n", keyboard_ids.id[i]);
	    else
	    	printk("ADB keyboard at %d, handler 1\n", keyboard_ids.id[i]);
	}

by

	/* Enable full feature set of the keyboard
	   ->get it to send separate codes for left and right shift,
	   control, option keys */
	for(i = 0;i < keyboard_ids.nids; i++) {
    if (adb_try_handler_change(keyboard_ids.id[i], 3))
	    	printk("ADB keyboard at %d, handler set to 3\n", keyboard_ids.id[i]);
	    else
	    	printk("ADB keyboard at %d, handler 1\n", keyboard_ids.id[i]);
	}


In the meantime, you can get back the previous behaviour from userland with:

mousemode 2 3

Sorry for the inconvenient !




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
