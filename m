Message-ID: <4048B287.6010501@246tNt.com>
Date: Fri, 05 Mar 2004 18:01:59 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux 2.6 on MPC5200. Early problems  + 2.4 questions
References: <40486C64.80803@246tNt.com>
In-Reply-To: <40486C64.80803@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got some updates on my problem.

Apparently it's not blocking at the cache activation. I just thought so
because apparently the 0xf000000 address is not mapped with the
not-cacheable flag and so the stw I used to power up/down the led on the
gpio was just waiting in the cache ...

My questions currently are :
 - Apparently 0xf0000000 is mapped to somewhere ( the MBAR ) but I don't
see where it's done ... And how do I tell it that it's IO and should not
be cached. Apparently on 2.4 it works but I don't see where is the piece
of code that just does that ...
 - The MPC5200 has 8 BAT, so shouldn't the CPU_FTR_HAS_HIGH_BATS feature
flag be set in the cputable.c of the 2.4 ? And also cfr my post on the
dev list about the code that clears those BAT. I thinks the wrong
register is used in head.S



Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
