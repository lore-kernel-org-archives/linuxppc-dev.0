Message-ID: <3802B100.740FCB7B@drgw.net>
Date: Mon, 11 Oct 1999 22:54:40 -0500
From: Troy Benjegerdes <hozer@drgw.net>
MIME-Version: 1.0
To: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
Subject: Re: What's up with gcc 2.95.1 and "__va_arg_type_violation"
References: <99100721144003.26148@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Hendricks wrote:
> 
> Hi,
> 
> When attempting to run the latest build of the jdk, I get the following error
> message (but only on non-debug builds).
> 
> Unsatisfied Link error: __va_arg_type_violation
> 
> Figuring, I simply forgot some new piece of glibc 2.1.2, I used
> 
> nm -o `find /lib -name "*"` | grep va_arg_type
> 
> (for /lib, /usr/lib, /usr/local/lib, /opt/lib, etc)
> 
> and this damn routine simply does not exist on my machine.

Actually, this generally means you are attempting to pass a 'char' through
a va_args function. This is a "bad thing" since the char silently gets
converted to an integer, and the compiler can't type check it. I would like
for any character (or I think short int also) arguments to va_arg functions
and explicitly typecast them to a 32 bit value type in the function call.

Franz Sirl would be the guy to ask if you want to know the actually reasons
and full technical details for this.

-- 
--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
