Message-ID: <39B529F9.654F7A88@mvista.com>
Date: Tue, 05 Sep 2000 10:14:33 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HARDHAT: hhl-relocation... how to use it?
References: <006d01c0171a$66f9a840$0a00010a@paoloweb>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The hhl-relocation program is a wrapper which is used for relocation
gcc.

GCC has many hard coded paths in it.  We have a system to bypass those
hard coded paths using environment variables.  During the RPM install,
if you chose to install other then the default prefix (if do an rpm -qip
gcc* you'll see it is relocatable) a small script is run to adjust the
default prefix inside of hhl-relocation, and then rename all of the gcc
executables (gcc, g++, etc) to *.real.  It then sets up a sym link from
"gcc" to hhl-relocation.  When you run a symlinked program,
hhl-relocation intercepts the call, sets the environment variables, and
then calls the program + .real.

It does preform relocation, but no it cannot reconfigure the standard
directory to run relocated.  You must use rpm to do that.

--Mark

Paolo Scaffardi wrote:
>
> I suppose hhl-relocation can be used to reconfigure the standard directory
> of the compiler toolkit but it seems it cannot be run (it looks for
> hhl-relocation.real).
>
> Any suggestion?
>
> Thanx,
> Paolo.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
