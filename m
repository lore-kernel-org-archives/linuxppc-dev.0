Return-Path: <thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
To: slof@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru
Cc: gkurz@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [SLOF PATCH 0/2] fbuffer: Improve the speed of the cursor drawing
Date: Tue, 28 Jul 2015 12:19:53 +0200
Message-Id: <1438078795-14360-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz recently already did a great work by introducing the
invert-region helpers to speed up the drawing of the cursor.
This made the grub2 command prompt and editor mode usable.
However, the editor mode of grub2 is still sluggish - because
grub2 always redraws the whole line (with cursor enabled!) when
you enter a character, and since cursor and character drawing
is still not super-fast in SLOF, this sums up to a noticable delay.

So I tried to speed up the drawing a little bit and came up
with the following patches. I've used a little "benchmark"
in Forth to see how the patches improve the drawing:

 1 buffer: etest-buf
 : etest
   erase-screen
   41 etest-buf c!
   1b emit 5b emit [char] H emit
   cursor-on
   milliseconds
    20 0 do 3a 0 do etest-buf 1 terminal-write drop loop cr loop
   milliseconds
   swap -
   ." Duration: " .d ." ms" cr
 ;

Without my patches, the etest function takes 1.8 s to draw.
With the first patch applied, the function take ca. 1.2 s.
With both patches applied, the function only takes ca. 0.8 s !

The first patch changes invert-region to use a bigger
access width if possible. And the second patch simply
decreases the size of the cursor from a full-character
size rectangle to an underscore-like cursor instead...
not sure whether this is acceptable, but at least I
think it looks as good as the original cursor.

Apart from my patches, I think grub2 should also disable
the cursor when redrawing a whole line in the editor.
However, I do not have much clue about the grub2 sources
yet ... is anybody familiar with this and could give some
pointers?

Thomas Huth (2):
  fbuffer: Improve invert-region helper
  fbuffer: Use a smaller cursor

 board-js2x/slof/helper.fs | 13 ++++++++-----
 board-qemu/slof/helper.fs | 14 ++++++++++----
 slof/fs/fbuffer.fs        |  5 +++--
 3 files changed, 21 insertions(+), 11 deletions(-)

-- 
1.8.3.1
