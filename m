Message-ID: <3ABA7131.DADAE7BA@mvista.com>
Date: Thu, 22 Mar 2001 16:40:01 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Todd M. Tomaino" <ttomaino@coe.neu.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NTSC Video on the 823
References: <Pine.SV4.4.10.10103221257340.26535-100000@Radians.coe.neu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Todd M. Tomaino" wrote:

> I followed the readme instructions for adding the VideoTest.c and Vid823.c
> files with the following header comments:

Where did you find these files?

> + * Started with Dan's LCD code, created NTSC Video Driver (4/2000)
> + * Chuck Spaur (chuck@spaur.com)

Although I wrote the first LCD driver, it has been fortunately discarded
and written as a proper frame buffer driver by others (at least Joe
Green).  I have no idea what Chuck did to the original driver when
he created this one.


> made it to here !!!
> Open error -19

Where is this "Open error -19" coming from?  There is lots more
code executed than your little snippet shows.


> void initVideo(IMAGEINFO *p_image)
> {
>         int     num_pages, i, j;
>         u_char  *fbuf, *cp;
>         printf("made it to here !!!\n");
> =====>>>if ((p_image->display_fd = open("/dev/vid", O_RDWR)) < 0) {
>                 perror("video open");
>                 exit(2);

Either your open is actually successful and further in the program
there is some error, or the driver is failing in the open function
and printing that error above.  It looks like some NULL pointer
dereference.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
