From: kbhend <kbhend@business.wm.edu>
To: "Kevin Buettner" <kev@primenet.com>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb broken under linuxppc r5 tools
Date: Mon, 2 Aug 1999 12:01:01 -0400
Content-Type: text/plain
References: <990801202455.ZM22552@redrock.lan>
MIME-Version: 1.0
Message-Id: <99080212045500.00464@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kevin,

In case this helps, here is a snippet of my frustrating gdb session:

Here is some sample output from gdb if it helps:

(gdb) list awt_allocate_colors
823                 awt_data->color_data->awt_icmLUT
824                             [awt_data->color_data->awt_numICMcolors++] = 0xff000000;
825             }
826         }
827         return 1;
828     }
829
830     #define red(v)          (((v) >> 16) & 0xFF)
831     #define green(v)        (((v) >>  8) & 0xFF)
832     #define blue(v)         (((v) >>  0) & 0xFF)
(gdb) # this is not the right place
(gdb) print awt_allocate_colors
$7 = {int (AwtData *)} 0xf46500 <awt_post_java_mouse_event+1056>
(gdb) # 0xf46500 is not the right address
(gdb) b awt_allocate_colors
Breakpoint 1 at 0xf46500: file ../../../../src/linux/native/sun/awt/color.c, line 828.
(gdb) # this coincides with the source shown above
(gdb) # but now look what I found from running x/20i repeatedly
(gdb) x/10i
0xf4728c 0xf4728c <awt_allocate_colors>: stwu    r1,-5280(r1)
0xf47290 <awt_allocate_colors+4>:       mflr    r0
0xf47294 <awt_allocate_colors+8>:       stw     r30,5272(r1)
0xf47298 <awt_allocate_colors+12>:      stw     r31,5276(r1)
0xf4729c <awt_allocate_colors+16>:      stw     r0,5284(r1)
0xf472a0 <awt_allocate_colors+20>:      mr      r31,r1
0xf472a4 <awt_allocate_colors+24>:
    bl  0xf472a8 <awt_allocate_colors+28>
0xf472a8 <awt_allocate_colors+28>:      mflr    r30
0xf472ac <awt_allocate_colors+32>:      lwz     r0,-32(r30)
0xf472b0 <awt_allocate_colors+36>:      add     r30,r0,r30
(gdb) # this is the true beginning of awt_allocate_colors at 0xf4728c
(gdb) # so part of gdb knows 0xf4728c is awt_allocate_colors
(gdb) # but another part thinks it is at 0xf46500
(gdb) # here is something else funny
(gdb) b awt_color_match
Note: breakpoint 1 also set at pc 0xf46500.
Breakpoint 2 at 0xf46500: file ../../../../src/linux/native/sun/awt/color.c, line 828.
(gdb) print awt_color_match
$8 = {int (int, int, int, AwtData *)} 0xf46500 <awt_post_java_mouse_event+1056>
(gdb) # awt_color_match is a completely different routine but
(gdb) # gdb has mapped it to the infamous 0xf46500
(gdb) # aaaarrrggghhhh!
(gdb)

This only seems to happen in shared libraries.  Breakpoints at main in the main
routine work fine.

So gdb is completely unusable as it is when debugging shared libs.  It seems to
map many different routines to the same address.   I hope this snippet helps.

Kevin H.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
