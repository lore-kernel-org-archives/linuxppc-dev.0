Message-ID: <384433732.977423922543.JavaMail.root@web625-wrb.mail.com>
Date: Thu, 21 Dec 2000 13:38:42 -0500 (EST)
From: Matthew Locke <mlocke@onemain.com>
To: <govindan@tejasnetworks.com>, linuxppc-dev@lists.linuxppc.org,
        damm@kierayapc01.p.y.ki.era.ericsson.se, dhinds@pcmcia.sourceforge.org
Subject: RE: Problem with PCMCIA and RPXCLASSIC
CC: gopi@tejasnetworks.com
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Mathew Locke,

>The pcmcia-3.1.22 has compilation problems as the mpc8xx_bdinfo >is not
>defined.  It is used only for the frequency, hence we hard >coded it to
>40MHz(which is our boards operating freq).

yeah, i forgot to export that in my patch.

>Then we gave _IO_BASE = 0x80000000
>This still did not work and the kernel panics.  We had to >comment out
>a line in ll_rw_blk.c( where and outb_p is called)..
>After this the kernel comes up.

So, IO_BASE = 0x80000000 does work, ll_rw_blk.c is an unrelated bug.

>Wpe suspect some goof up in the file: >arch/ppc/kernel/m8xx_setup.c
>Here ATA_FLASH is defined to 1.(and the comment is:
>  /* Define this to make a PCMCIA ATA Flash card work.
>  */
>)
>But with this define, the function rpx_pcmcia_config() doesnt >get
>called at all.

It may be a little confusing, but since it works for me I doubt there is a
goof up. The confusing part is that there is code in there to bypass card
services for ATA cards.  Instead of deleting it, I left it so that people
who don't want the overhead of card services (my guess is that it doesn't
really affect perfomance that much) don't have to use it.

>Does anyone have a patch for this file?

you have the patch that works.

>Also, what should be the values in the config.opts for this?

config.opts is not used for the 8xx.

you can send me a microdrive and I will figure out what the problem is.

>I HAVE READ IN THE MAILING LIST from Dan dated TUE 02, may 2000
>that he has successfully used IBM Micro drive with MPC860 PCMCIA.
>has anybody got the detail information ?

I don't think Dan uses card services.  He has code in the kernel that
connects the ide driver directly to the 8xx pcmcia controller.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
