Date: Mon, 3 Feb 2003 10:44:52 -0700 (MST)
From: daRonin <daronin@digimerc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: external cinema 22" display
In-Reply-To: <20030202213541.GC22344@haar.ae.gatech.edu>
Message-ID: <Pine.LNX.4.50L0.0302031032090.1676-100000@daronin.digimerc.com>
References: <20030120155921.GA22300@haar.ae.gatech.edu>
 <1043086974.2456.9.camel@tsunami.lan.stampflee.com> <20030202213541.GC22344@haar.ae.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  I finally got my Cinema display working on TiBook G4 with Radeon M6 LY
in it.

 It would seem that radeonfb doesn't even look for CRT port on M6 LY.

 At the line 1058 of radeonfb.c (v 0.1.6):
 <snip>
        switch (rinfo->arch) {
                case RADEON_M6:
                case RADEON_M7:
                case RADEON_M9:
                        rinfo->dviDisp_type = MT_LCD;
                        break;

   <snip>

  The code just assumes that if I have RADEON_M6 all I've got is LCD. So I
added another command line option called "crt" and added a line:

<snip>

        switch (rinfo->arch) {
                case RADEON_M6:
                case RADEON_M7:
                case RADEON_M9:
                        /* modified by daRonin */
                        if (force_crt) radeon_get_moninfo(rinfo);
                        else rinfo->dviDisp_type = MT_LCD;
                        break;

<snip>

  After this my cinema display started working properly, though still
throughing me into 640x480-8@70 mode.

 So I added an fbset command in my rc scripts. I still had to play with
timings quite a bit. For one I had to set vsync to high, otherwise the
monitor wouldn't even come up in any resolution.

  I also got this working only with my ebuild Gentoo kernel (2.4.20-r2), I
tried 2.4.20-ben4 and 2.4.20-ben5. In both of those, after my
modifications the cinema display worked, but the LCD didn't blank, instead
it went white. I played around with the code, but couldn't find the source
of the problem...

  If anyone is interested I can send them the modified radeonfb.c as well
as the timings for 1600x1024-60...

  Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
