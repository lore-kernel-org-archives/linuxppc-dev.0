Date: Fri, 04 May 2001 23:50:41 -0400
Subject: raw keyboard input
From: David Landrith <dave@landrith.com>
To: Linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B718F0D1.5CF%dave@landrith.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am working on writing a console text editor in C++ using the ncurses
library, and I am now at the following impasse:

One of my goals in making another console text editor is to make one that is
as easy to use as bbedit or nedit.  This includes, for example, shift-arrow
keys for selecting text; ctrl-left for word left, ctrl-right for word right,
etc.  (I believe that in principle there is no reason why a console text
editor can't be every bit as functional and as easy as a really slick gui
text editor like bbedit or nedit--hey, it's all monospaced text anyway,
right?).

So I've gotten to a point in my program where I need to discriminate between
a control character and a shift control character.  Of course, ncurses does
not do this (it does not even distinguish between KEY_LEFT and KEY_SLEFT on
my computer).  It seems to me that I have the following options to choose
from:

1.  Use code like that in showkey, where I completely take over the keyboard
and console and write my own input handler.  This poses too many problems to
list here.

2.  Rewrite lib_getch in ncurses.  This is more feasible than #1, but it
still seems to be major overkill, since I will then have to incorporate a
great many of the ncurses files into my program (wouldn't it be nice if you
can simply include ncurses.priv.h and fifo_defs.h)

3. Find some way to allow me to simply call kgetch or the fifo functions in
lib_getch directly (this appears to me to be the functions I need to use to
grab the raw key inputs).  This would be a major hack job.

4. Somehow modify the kmap file so that it reflects different values for
control character and shift control characters.  (I do not even know where
to begin with this one.)

5. Somehow modify the terminfo database so that it reflects different values
for control character and shift control characters.  (I do not even know
where to begin with this one.)

Numbers 4 and 5 seem to me to be the cleanest way to go about this.  Of
course, there may be some way to accomplish this that I do not even conceive
of yet.

I'd appreciate any help you all can give me.

Best,

Dave

-------------------------------------------------------------
  David King Landrith                      (v) 617-359-6206

  One useless man is a disgrace, two are called a law firm,
  and three or more become a congress -- John Adams
-------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
