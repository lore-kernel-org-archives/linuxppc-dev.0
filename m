Message-ID: <3AA4C159.C8FBD015@opensource.se>
Date: Tue, 06 Mar 2001 11:52:09 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling bash
References: <3AA3EFDB.1B1A4508@intel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> How does one cross-compile bash?

I have successfully cross-compiled many applications
on my x86 host.

First you need a cross-compiled libc.
Then you need to tell "configure" some things
to make it use your compiler/libc.
You also might need to pass other configuration values
that are impossible to autodetect if crossc-ompiling.

I use a wrapper around configure to pass some values to it.
Here are some values from my wrapper, some might not be needed
for bash, but maybe for other packages..

some bash specific variables:

export bash_cv_func_sigsetjmp=present
export bash_cv_job_control_missing=present
export bash_cv_sys_named_pipes=present
export bash_cv_sys_siglist=yes
export bash_cv_ulimit_maxfds=yes
export bash_cv_under_sys_siglist=yes
export bash_cv_type_rlimit=long

and some powerpc specific stuff:

export ac_cv_c_bigendian=yes
export ac_cv_c_char_unsigned=no
export ac_cv_sizeof_long_long=8
export ac_cv_sizeof_long=4
export ac_cv_sizeof_int=4
export ac_cv_sizeof_short=2
export ac_cv_sizeof_unsigned_long=4
export ac_cv_sizeof_unsigned_int=4

I also export the following variables from my wrapper:
They pretty much depend on what you compile for and where
your compiler is, you'll have to figure out them yourself.

export CC CXX CFLAGS CPP LDFLAGS AR RANLIB HOSTCC HOST_CC BUILD_CC

I have a patch for bash-2.04 that makes it possible to crosscompile.
But it is too big to be sent to this public list.

Ask nice and I will send it to you.. =)

Cheers /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
