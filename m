Date: Thu, 27 Apr 2000 23:39:59 -0400
From: Clint Hepner <chepner@cs.dartmouth.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: VRAM detection in controlfb.c
Message-ID: <20000427233956.A604@cs.dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently added another 2MB of VRAM to my PM8500
with control video, and was dismayed when linux wouldn't
recognize it.  I remembered some discussion on this
issue about a month ago, but I haven't seen anything
since then.

I got the most recent version of the stable kernel,
2.2.15_pre20, and poked around a bit to try to understand
what was going on.  In the end, I just hardcoded the value
of bank2 after line 725 in controlfb.c to 1, to
override the kernel's failure to detect the memory
in bank 2. It worked; I can now drive my 17" monitor at
1280x1024 @16bpp.

My question is, is the problem only with detecting the
VRAM, or could there be problems addressing the VRAM as
well if the kernel isn't able to detect it on its own.

(On a slightly unrelated issue, is control capable of
resolutions greater than 1280x1024? I've never seen
any documentation on it.  MacOS doesn't give me the option
of going higher, but I'm not sure if that means anything.)

Clint Hepner
Dartmouth College

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
