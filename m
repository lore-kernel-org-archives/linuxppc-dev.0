Mime-Version: 1.0
Message-Id: <p04320401b615fad098d5@[172.21.170.210]>
In-Reply-To: <14831.41519.899373.33270@argo.linuxcare.com.au>
References: <Pine.LNX.4.21.0010191246070.6734-100000@like.mine.nu>
 <p04320400b61508915079@[172.21.170.210]>
 <14831.41519.899373.33270@argo.linuxcare.com.au>
Date: Fri, 20 Oct 2000 09:46:25 -0400
To: paulus@linuxcare.com.au
From: Scott Hankin <shankin@rational.com>
Subject: Re: 2.4.0-test10 boot failure on Powerbook G3
Cc: phandel@cise.ufl.edu, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:38 PM +1100 10/20/00, Paul Mackerras wrote:
>Scott Hankin writes:
>
>>  It turned out that the pc was in do_install_cmap, and lr was in
>>  atyfb_set_var.  The latter calls the former near the end of the
>>  routine (check out drivers/video/atyfb.c:2940) but as to why it's
>>  bombing, I have no clue.
>
>Looking at the code for that routine:
>
>static void do_install_cmap(int con, struct fb_info *fb)
>{
>     struct fb_info_aty *info = (struct fb_info_aty*)info;
>
>that first statement doesn't make sense, change it to:
>
>     struct fb_info_aty *info = (struct fb_info_aty*) fb;
>
>and that should fix it.
>
>BTW, I now have copies of my rsync trees at penguinppc.org, which will
>hopefully have more bandwidth available than ppc.samba.org did.  The
>tree at penguinppc.org::linux-pmac-devel has this bug fixed.

Thanks, Paul, Ben and Peter for the friendly responses.

Yes, that line does look a little odd.  I did finally get things
working by using the BitKeeper archives for my build (the penguinppc
site is currently unavailable) and it came up fine.

Is there an easy way to compare the current source tree with the
previous version?  Is there a way to get the previous version and
brute force it?  I got in this mess partly because using rsync means
you can't go back.  Had I been able to go back to test9 easily, I
would have, and waited for the fix.  But as it was, I ended up going
back to 2.2.17, largely because it was available.

There was a silver lining to all this: my current setup now boots and
runs cleaning with both 2.2.17 final and 2.4.0-test10 with devfs
mounted at boot.

Forgive what must surely seem like trivial problems; I am only slowly
becoming informed about kernel organization and distribution.  Many
thanks to all.

- Scott

-----------------------------
Scott Hankin (shankin@rational.com)  In the beginning, there was nothing, then
Rational Software                    God said, "Let there be light."  And there
20 Maguire Road                      was light.  There was still nothing, but
Lexington, MA 02421                  you could see it a lot better.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
