Mime-Version: 1.0
Message-Id: <p06100203bd4c5e3aa6d9@[192.168.0.23]>
In-Reply-To: <p06100200bd4c49c3daeb@[192.168.0.23]>
References: <p06100200bd4c49c3daeb@[192.168.0.23]>
Date: Fri, 20 Aug 2004 22:05:24 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.6 hoses 2.4 on old-world?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Been running a 2.4 kernel on my PowerTowerPro for a long time. Over
>the months I've tried building 2.6.x, and succeeded for the first
>time last night with 2.6.8-rc1.

sorry, that's rc4 I'm using.

>Rebooted to the default 2.4 but I'm hosed: The first part of the boot
>starts, and sometime shortly after I get to the yellow Welcome to
>Yellowdog lettering, then I'm seeing a lot of "/dev/null, read-only
>file system" messages,

The problem is that something overwrote /dev/null as a regular file,
and the errors leading to boot failure were of the type "bad file
descriptor."

I remounted rw, deleted /dev/null, and recreated it. I can now boot
back into 2.4.

Question remains - is there something about 2.6 on old-world systems?
Is is not safe? Unstable? (I still haven't figured out why I lose
video with 2.6).

Steps:

make menuconfig
(do some config)
make
make modules_install
reboot

I admit to being somewhat confused, this is cleaner but less
informative than the 2.4 build procedure.

BTW depmod give me lots of unresolved symbols, mostly related to sound.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
