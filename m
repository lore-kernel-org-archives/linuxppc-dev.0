Message-ID: <3715166A.FD1AF78F@wanadoo.fr>
Date: Thu, 15 Apr 1999 00:27:54 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
Subject: [Patch] linuxppc gnuplot segfaults in save
Content-Type: multipart/mixed;
 boundary="------------49E6C97083552248A1E53DB6"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------49E6C97083552248A1E53DB6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, 

I think I sent this already to the LinuxPPC developers some time ago,
but I had a look into the latest gnuplot-3.7-2.ppc.rpm, and the bug is
still there:

Bug: 
gnuplot-3.7 on LinuxPPC gives a segmentation fault when the command
'save' or 'save set' is used.

Repeat by: 
root[88]#/usr/bin/gnuplot

        G N U P L O T
        Linux version 3.7
        patchlevel 0
        last modified Thu Jan 14 19:34:53 BST 1999
etc.

Terminal type set to 'x11'
gnuplot> save 'foo.gnu'
Segmentation fault

Patch: 
See below. One just has to split an fprintf command into two.
It seems that the fprintf in the LinuxPPC libraries does not support
such long format strings. In gnuplot-3.6, at the corresponding place
there were 10 fprintf commands, one for each line.

In principle, it would be nice if this were included in the gnuplot
sources, but since it seems to be a ppc specific problem, it would be
sufficient to include the patch in the gnuplot-3.7-x.src.rpm for
LinuxPPC (Tom?). 

Or could someone find out what's wrong with the fprintf function in
LinuPPC? Note that this is not specific for one version of glibc. I
tried it on several from glibc-961212 to glibc-2.1.1-3a. Same result.

--
Martin
--------------49E6C97083552248A1E53DB6
Content-Type: text/plain; charset=us-ascii;
 name="gnuplot_save.patch"
Content-Disposition: inline;
 filename="gnuplot_save.patch"
Content-Transfer-Encoding: 7bit

--- misc.c.ori	Thu Dec 10 19:33:22 1998
+++ misc.c	Sun Feb  7 00:16:08 1999
@@ -645,17 +645,18 @@
 set pointsize %g\n\
 set encoding %s\n\
 set %spolar\n\
-set %sparametric\n\
+set %sparametric\n",
+	    loff, roff, toff, boff,
+	    pointsize,
+	    encoding_names[encoding],
+	    (polar) ? "" : "no",
+	    (parametric) ? "" : "no");
+    fprintf(fp, "\
 set view %g, %g, %g, %g\n\
 set samples %d, %d\n\
 set isosamples %d, %d\n\
 set %ssurface\n\
 set %scontour",
-	    loff, roff, toff, boff,
-	    pointsize,
-	    encoding_names[encoding],
-	    (polar) ? "" : "no",
-	    (parametric) ? "" : "no",
 	    surface_rot_x, surface_rot_z, surface_scale, surface_zscale,
 	    samples_1, samples_2,
 	    iso_samples_1, iso_samples_2,

--------------49E6C97083552248A1E53DB6--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
