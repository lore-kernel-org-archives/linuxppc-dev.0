Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Sat, 21 Oct 2000 15:22:16 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: geert@linux-m68k.org
Cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: Video driver bug
Message-ID: <20001021152216.A706@ibrium.se>
References: <20001017002037.A26630@ibrium.se> <Pine.LNX.4.10.10010171332540.394-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10010171332540.394-100000@cassiopeia.home>; from geert@linux-m68k.org on Tue, Oct 17, 2000 at 01:37:58PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 17, 2000 at 01:37:58PM +0200, Geert Uytterhoeven wrote:

> Alternatively you can get the info once and store it in a config file in the
> user's homedir. If it later turns out to be invalid (e.g. due to dual-head
> issues, or because you changed your video card), you can offer to reprobe when
> restarting MOL the next time.

OK, I'll settle for this solution. It is good to force manual confirmation
of each video mode anyway.

However, I discovered another bug in aty128fb.c. The aty_128_encode_var
sets var->activate to zero (preventing FB_ACTIVATE_TEST from
working). A simple fix:

+   int activate;
    aty128_encode_var(var, &par, info);

-   if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
+   if ((activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
        return 0;

(the bug is present in both 2.2 and 2.4).

Cheers,

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
