To: Troy Benjegerdes <hozer@drgw.net>
Cc: Gabriel Paubert <paubert@iram.es>, Matt Porter <mmporter@home.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel restructure + MVME/MTX OpenPIC support
References: <Pine.LNX.4.04.9901101614300.926-100000@narn.local.drgw.net>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 11 Jan 1999 13:01:49 -0600
In-Reply-To: Troy Benjegerdes's message of Sun, 10 Jan 1999 16:24:13 -0600 (CST)
Message-ID: <m267advdk2.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> writes:

> I have just finished some early testing of this.
> 
> The patch is available on
> ftp://ftp.microux.com/pub/linux/linuxppc-rework-troy.patch.gz
> 
> Here's what I put in the REAME:
> 
> This is my set of integrated patches to the Linux kernel, which are based on
> Corey Minyard's linuxppc-rework3.diff patches, along with Gabriel Paubert's
> Preploader (which I have integrated into arch/ppc/preploader) and Raven MPIC
> support for Motorola MTX/MVME boards.
> 
> This works on my MTX board, but only with CONFIG_PREPLOADER (the preploader
> has a config option ;) ) because the raven needs to have it's PCI memory
> space remapped or it isn't accessible.
> 
> Pmac should work, along with APUS. I think I may have broken MBX support..
> Can someone check this out and fix this?
> 
> These patches were made from my local CVS archive agains 2.2.0-pre6.
> Please let me know if you have any additions, etc. 
> 

Is there anybody that could do the MBX work and test things out?  That
is the biggest hole missing.  I'd like to see all the 8xx and MBX stuff
be put into the new framework, but I don't have the experience to do
it.  I'm also a little short of time right now since I'm remodelling
my house.

Also, a couple of small things that probably need to be fixed:

 * The __initfunc()  needs to be removed from all the xxx_setup_residual
   function calls, since that is called all the time.

 * The patch to idle.c needs to look something like:

--- linux-2.2p4.orig/arch/ppc/kernel/idle.c     Mon Jan  4 16:59:13 1999
+++ linux-2.2p4/arch/ppc/kernel/idle.c  Mon Jan  4 16:49:13 1999
@@ -301,7 +301,14 @@
                        hid0 &= ~(HID0_NAP | HID0_SLEEP | HID0_DOZE);
                        hid0 |= (powersave_nap? HID0_NAP: HID0_DOZE) | HID0_DPM;
                        asm("mtspr 1008,%0" : : "r" (hid0));
-                       msr |= MSR_POW;
+
+                       /* set the POW bit in the MSR, and enable interrupts
+                          so we'll wake up sometime! */
+                       _nmask_and_or_msr(0, MSR_POW | MSR_EE);
+
+                       /* Disable interrupts again so restore_flags will
+                          work. */
+                       _nmask_and_or_msr(MSR_EE, 0);
                }
                restore_flags(msr);
        default:


-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
