Message-ID: <D73A25AA6E54D511AD74009027B1110F2C829F@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'nanogui@linuxhacker.org'" <nanogui@linuxhacker.org>
Subject: IRQ's
Date: Wed, 8 May 2002 16:42:51 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was hoping that someone with experience with IRQ's could give me a little
advice.  I am working on a touch screen driver that uses IRQ4 on an 823e
board.  I have the following code to assign it.

/*
 *  Make IRQ4 edge sensitive.
 */
immap->im_siu_conf.sc_siel |= 0x00800000;

if( request_8xxirq(SIU_IRQ4, tpanel_pendn_intr, 0,  "tpanel", NULL) != 0 )
	  printk("Could not allocate tpanel IRQ\n");

I have verified with a scope that when I touch the screen IRQ4 goes low, but
the handler tpanel_pendn_intr is never called.  Is there anything else
involved in assigning and using an IRQ?  I would appreciate any advice
anyone could give.
Steve

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
