Date: Sat, 7 Oct 2000 13:38:51 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: olh@suse.de
Subject: Video driver bug
Message-ID: <20001007133851.A994@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Certain 2.4 video drivers (aty128, aty, platinum, tdfx, iga)
appear to be buggy. More specifically, the problem is the
following:

In the set_disp function, info->dispsw is initialized and disp->dispsw
is given the address of info->dispsw:

	static void aty128_set_disp(..)
	{
	  switch(bpp) {
	    case 8:
	        info->dispsw = accel ? fbcon_aty128_8 : fbcon_cfb8;
	        disp->dispsw = &info->dispsw;
	        break;
	   ...
	}

The problem is that the info struct is shared by all virtual consoles.
Thus if the video mode is set on a console which is not active, the
active console will be affected too. This typically results in a kernel
panic (the wrong set of console output functions is used).

This problem is observable if one starts MOL from the console. MOL
changes the video mode on an inactive console in order to extract
certain video mode parameters (like rowbytes).

One way to fix the bug is changing set_disp to the following:

	static void aty128_set_disp(..)
	{
	  switch(bpp) {
	    case 8:
	        disp->dispsw = accel ? &fbcon_aty128_8 : &fbcon_cfb8;
	        break;
	   ...
	}

This is how the code used to look like (before 2.3.43-pre5).
Does anyone know why this was changed?


Cheers,

/Samuel



----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
