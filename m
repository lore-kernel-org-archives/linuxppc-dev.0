Date: Fri, 30 Jul 1999 08:03:24 -0500
From: Alain Birtz <abz@videotron.ca>
Subject: Bug or hidden feature ?
To: linuxppc-dev@lists.linuxppc.org
Message-id: <37A1A29B.43C7AE75@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



/*
In the code below, the second loop print char exactly is the same place
as the first loop. The only change is the char printed. Hit 3 time a key

A strange thing happen when the last half end of the line hold only
blanck space character.
Normally the blank must erase the underscore. This not happen.
Instead the remaining of the line (after the underscore) is erased.

This seem happen only in the X term window
Tested in Gnome terminal (linucPPC R5)
Is it an hidden feature ? Or is there something wrong with the code ?
*/


// gcc -I/usr/include/ncurses tst_addch.c -g -o tst -lncurses

#include <curses.h>

int main()
{
 int r, c;

 initscr();

 for (r = 0; r < LINES; r++)   /* fill screen of letter, so we can see
what happen */
  {
  for (c = 0; c < COLS; c++)
   mvaddch(r, c, 'A'+ r);
  }
 refresh();
 getchar();

// FIRST LOOP

 for (r = 2; r < LINES - 2; r++)  /* write in middle of the screen */
  {
  for (c = 3; c < COLS / 2; c++)
   if (c < COLS / 5)
    mvaddch(r, c, '*');
   else
    mvaddch(r, c, '_');  /* first loop -> use underscore */
  }
 refresh();
 getchar();

// SECOND LOOP

 for (r = 2; r < LINES - 2; r++)  /* write in same place */
  {
  for (c = 3; c < COLS / 2; c++)
   if (c < COLS / 5)
    mvaddch(r, c, '/');
   else
    mvaddch(r, c, ' ');  /* second loop -> use blanck space char */
  }
 refresh();
 getchar();

 endwin();
 exit(0);
}

// the second loop is same as the first loop, except for the char
printed
// the underscore is not replaced by the blank char
// but the remainning of the line (after the unserscore) is erased
// if the terminal window is small, this not happen


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
