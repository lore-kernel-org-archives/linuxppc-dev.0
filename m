Date: Sun, 25 Apr 1999 14:13:35 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Reply-To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Sean Harding <sharding@oregon.uoregon.edu>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: platinumfb in 16 bit?
In-Reply-To: <Pine.SGI.4.10.9904241618570.78856-200000@gutenberg.uoregon.edu>
Message-ID: <Pine.LNX.3.96L.990425140416.2193G-100000@unix45.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 24 Apr 1999, Sean Harding wrote:

> On Sat, 24 Apr 1999, Hollis R Blanchard wrote:
> 
> > I don't suppose I could beg/plead someone into fixing platinumfb for 16 bit
> > color? The problem has been around for while (I posted about it a while ago,
> 
> Try the attached file. That's what I've been using, and it works fine. I
> submitted this change long ago and apparently it never made it in. I'm not
> entirely sure that it's correct, so it would be nice to know if it works
> for others too.

This worked perfectly. This is great. Is this patch going to get into the
official kernel soon?

For those of you who missed it:
- before patch, screwed up palette in 16 bit (but 8 bit works)
- after patch, good palette in 16 bit (and 8 bit still works)
[this only affects platinumfb]

$ diff platinumfb.c platinumfb.c-2.2.6 
434c434
<       /*int scale;*/
---
>       int scale;
447c447
<       /*scale = (info->current_par.cmode == CMODE_16) ? 3 : 0;*/
---
>       scale = (info->current_par.cmode == CMODE_16) ? 3 : 0;
450,452c450,452
<       out_8(&cmap_regs->lut, red);    /* send one color channel at    */
<       out_8(&cmap_regs->lut, green);  /* a time...                    */
<       out_8(&cmap_regs->lut, blue);
---
>       out_8(&cmap_regs->lut, red<<scale);     /* send one color channel at*/
>       out_8(&cmap_regs->lut, green<<scale);   /* a time...            */
>       out_8(&cmap_regs->lut, blue<<scale);

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
