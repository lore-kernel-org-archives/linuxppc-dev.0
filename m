Date: Fri, 12 Nov 1999 07:35:12 -0600 (CST)
From: Dave Weis <djweis@plconline.com>
To: Brendan Simon <bsimon@ctam.com.au>
cc: linux-embedded <linux-embedded@waste.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxEmbedded: minimal network system packages.
In-Reply-To: <382B4396.57669F9B@ctam.com.au>
Message-ID: <Pine.LNX.4.10.9911120727580.12110-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



On Fri, 12 Nov 1999, Brendan Simon wrote:
> I want to be able to run FTP (client only), HTTP server, SNMP agent and
> TELNET server.
> What packages do I need to compile (cross-compile) to get these working
> Things I think I need are :
> * init

> * mount (do I NEED this ?)
> * ifconfig (do I NEED this ?)

read through the source for the two packages above. ifconfig on my machine
is 33k but if your config will be locked down, you can sum it up as

socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, SIOCSIFADDR, 0xbffffb78)       = 0
ioctl(4, SIOCSIFNETMASK, 0xbffffb68)    = 0

to set the address and netmask of the loopback interface. 

read the source of the utils or strace them. if you have a few utils like
mount and ifconfig you can combine them into one program to cut down on
overhead and check the argv[0] to see what name they were called with and
change behavior based on that.

dave


-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231

When they took the Fourth Amendment, I was quiet because I didn't deal drugs.
When they took the Fifth Amendment, I was quiet because I was innocent.
When they took the Second Amendment, I was quiet because I didn't own a gun.
Now they've taken the First Amendment and I can't say anything.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
