Message-ID: <368106DF.F355F4AF@andrew.cmu.edu>
Date: Wed, 23 Dec 1998 10:06:07 -0500
From: Randy Gobbel <gobbel@andrew.cmu.edu>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: linuxppc-dev@lists.linuxppc.org, apenwarr@foxnet.net, eric@aib.com
Subject: Re: workaround for broken 'make xconfig' on ppc
References: <Pine.LNX.4.04.9812222301100.28200-100000@narn.local.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:
> 
> After using make xconfig on i386 earlier today, I finally decided to
> figure out why it's broke on PPC. I found that there's something not
> working right in scripts/tkgen.c where 'global CONFIG_SOUND' isn't being
> put into the tk script in the 'update_mainmenu' function.
> 
> This cause the script to bomb with a 'can't find variable $CONFIG_SOUND'
> error.
> 
> This doesn't show up on i386 since CONFIG_SOUND isn't the last item, like
> it is on PPC.
> 
> By adding the following to linux/arch/ppc/, make xconfig now works:
> 
> -----
> 
> mainmenu_option next_comment
> comment 'make Xconfig is broken'
> bool 'Xconfig is broken' CONFIG_BROKEN_XCONFIG
> endmenu

I submitted a fix for this a while ago, not sure why it hasn't been
checked in (I don't have write access to vger).  Here's the patch.  I
have tested this on both PPC and x86, and it works for me--I have not
had any problem with make xconfig for a while.  If someone could check
this in to vger I'd appreciate it (and so would a bunch of other
people).

-Randy

Index: scripts/tkgen.c
===================================================================
RCS file: /cvsroot/linux/scripts/tkgen.c,v
retrieving revision 1.22
diff -c -r1.22 tkgen.c
*** tkgen.c     1998/07/26 06:09:03     1.22
--- tkgen.c     1998/11/11 22:39:21
***************
*** 913,918 ****
--- 913,919 ----
     * correct.
     */
    printf("proc update_mainmenu {w}  {\n");
+   clear_globalflags(scfg);
    for(cfg = scfg; cfg != NULL; cfg = cfg->next)
      {
        switch (cfg->tok)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
