From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14831.41519.899373.33270@argo.linuxcare.com.au>
Date: Fri, 20 Oct 2000 12:38:55 +1100 (EST)
To: Scott Hankin <shankin@rational.com>
Cc: phandel@cise.ufl.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test10 boot failure on Powerbook G3
In-Reply-To: <p04320400b61508915079@[172.21.170.210]>
References: <Pine.LNX.4.21.0010191246070.6734-100000@like.mine.nu>
	<p04320400b61508915079@[172.21.170.210]>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Scott Hankin writes:

> It turned out that the pc was in do_install_cmap, and lr was in
> atyfb_set_var.  The latter calls the former near the end of the
> routine (check out drivers/video/atyfb.c:2940) but as to why it's
> bombing, I have no clue.

Looking at the code for that routine:

static void do_install_cmap(int con, struct fb_info *fb)
{
    struct fb_info_aty *info = (struct fb_info_aty*)info;

that first statement doesn't make sense, change it to:

    struct fb_info_aty *info = (struct fb_info_aty*) fb;

and that should fix it.

BTW, I now have copies of my rsync trees at penguinppc.org, which will
hopefully have more bandwidth available than ppc.samba.org did.  The
tree at penguinppc.org::linux-pmac-devel has this bug fixed.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
