Date: Sat, 15 Nov 2003 23:43:42 +0100
From: Olaf Hering <olh@suse.de>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031115224342.GA16897@suse.de>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200311152230.hAFMUwT32990@makai.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sat, Nov 15, David Edelsohn wrote:

> >>>>> Olaf Hering writes:
>
> Olaf> 2.6 has a function parse_header(), its part of gunzip and used for
> Olaf> initramfs as example. I got an oops, exception 600, sig 7. I think that
> Olaf> means unaligned access.
>
> Olaf> +               memcpy(buf, s, 7 + j); /* s might be unaligned, gcc will optimized the call to lswi on ppc */
>
> 	lswi specifically accepts unaligned addresses.

The asm diff looks like that:

--- initramfs-8.s       2003-11-15 23:41:12.000000000 +0100
+++ initramfs-7+j.s     2003-11-15 23:41:36.000000000 +0100
@@ -165,16 +165,18 @@
        addi 28,1,56
        addi 27,1,8
 .L85:
+       mr 4,31
+       li 5,8
+       mr 3,28
        slwi 29,30,2
+       bl memcpy
+       addi 30,30,1
        mr 3,28
        li 4,0
        li 5,16
-       addi 30,30,1
-       lswi 9,31,8
-       stswi 9,28,8
+       addi 31,31,8
        bl simple_strtoul
        cmpwi 0,30,11
-       addi 31,31,8
        stwx 3,29,27
        ble+ 0,.L85
        lwz 0,44(1)


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
