Date: Sat, 15 Nov 2003 23:24:30 +0100
From: Olaf Hering <olh@suse.de>
To: Alan Modra <amodra@bigpond.net.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031115222430.GA13820@suse.de>
References: <20031115210449.GA10105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20031115210449.GA10105@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sat, Nov 15, Olaf Hering wrote:

>
> Alan,
>
> 2.6 has a function parse_header(), its part of gunzip and used for
> initramfs as example. I got an oops, exception 600, sig 7. I think that
> means unaligned access.

This might be a useable workaround.

--- ../linuxppc-2.5_2.6.0-test9-bk.orig/init/initramfs.c        2003-10-18 17:25:50.000000000 +0200
+++ init/initramfs.c    2003-11-15 23:09:57.000000000 +0100
@@ -100,11 +100,11 @@ static void __init parse_header(char *s)
 {
        unsigned long parsed[12];
        char buf[9];
-       int i;
+       int i, j = 1;

        buf[8] = '\0';
        for (i = 0, s += 6; i < 12; i++, s += 8) {
-               memcpy(buf, s, 8);
+               memcpy(buf, s, 7 + j); /* s might be unaligned, gcc will optimized the call to lswi on ppc */
                parsed[i] = simple_strtoul(buf, NULL, 16);
        }
        ino = parsed[0];


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
