Date: Wed, 12 Jan 2000 11:37:17 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: iweiny@pacbell.net
cc: linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: User level Macros for Endianess
In-Reply-To: <200001120832.AAA10014@batcave2.localdomain>
Message-ID: <Pine.LNX.3.96.1000112112213.10716F-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jan 2000 iweiny@pacbell.net wrote:

> Unfortunately I don't have an x86 Linux machine and he has been reluctant to
> change his code because he feels this is not the "proper" way to detect
> endianess across Linux's, Solaris, and possibly other UNIX's.

Well, if you really want it to be completely cross-platform, you could do
something like:


int a = 0x33323130;
char *b, d[5];
int c;

for (b=(char *)&a, c=0; c<4; c++,b++)
    {
	d[c]=*b;
    }
d[5]=0;



I believe that the Linux macros do this same basic thing, if memory
serves....  BTW, if you printf("%s", d) you'll get 3210 on big endian,
0123 on little.  You could also do it as short integers instead of
characters by subtracting 48 in the d[c]=*b line.

Just a sick thought.  :-)


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
