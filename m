Date: Fri, 16 Jun 2000 13:27:09 +0200
From: Olaf Hering <olh@suse.de>
To: Brad Midgley <brad@turbolinux.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: paul-rsync: make zImage fails
Message-ID: <20000616132709.B27795@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <394988C9.92470C6F@denise.shiny.it> <Pine.LNX.4.20.0006152313080.15387-100000@mail.turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.20.0006152313080.15387-100000@mail.turbolinux.com>; from brad@turbolinux.com on Thu, Jun 15, 2000 at 11:19:07PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 15, Brad Midgley wrote:

>
> it's been a long time since i've gotten a chrp image to work, but the
> current sources can't do it:
>
> main.c: In function `chrpboot':
> main.c:43: conflicting types for `_start'
> main.c:29: previous declaration of `_start'
>
> is it an unfortunate name collision, or is one of these right and one
> wrong?
>
>  extern char _start[], _end[];
>    ...
>  extern char _start;

--- linux.nokconf/arch/ppc/chrpboot/main.c      Thu Jun 15 20:31:48 2000
+++ linux.chrp/arch/ppc/chrpboot/main.c Thu Jun 15 23:18:47 2000
@@ -40,9 +40,9 @@
     void *dst;
     unsigned char *im;
     unsigned initrd_start, initrd_size;
-    extern char _start;
+   /* extern char _start;

-    printf("chrpboot starting: loaded at 0x%x\n\r", &_start);
+    printf("chrpboot starting: loaded at 0x%x\n\r", &_start); */

     if (initrd_len) {
        initrd_size = initrd_len;


works fine here.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
