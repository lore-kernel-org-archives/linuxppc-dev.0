Message-ID: <3AD7FAF8.44670189@disca.upv.es>
Date: Sat, 14 Apr 2001 09:23:36 +0200
From: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: libc.so.6 error but not in Montavista
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to build a ramdisk for a TQM823L module using the LinuxPPC
(2.4.4) and CDK provided by DENX.

I have built the CDK withouth any problems and so the ramdisk.
But when I try to boot the system, I obtain the following error:
....
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 52k init
init: error in loading shared libraries: libc.so.6: cannot open shared
object fi
le: No such file or directory
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..

I have been searching the lists for a solution but it seems that people
with the same problem were using the Montavista version, not the DENX
one.
The proposed solution for Montavista is:
--------
If your shared libraries are (as usual) in the "/lib" directory, add the
following option to the GCC command line when linking your binary:
-Wl,-R/lib
--------
In fact, I don't know where to add this option.

The /lib/libc.so in the ramdisk shows the following code:
---------------------
/* GNU ld script
   Use the shared library, but some functions are only in
   the static library, so try that secondarily.  */
GROUP ( /LinuxPPC/CDK/lib/libc.so.6 /LinuxPPC/CDK/lib/libc_nonshared.a )
---------------------
I think that this isn't right.

Any help would be great.

--
----------------------------------------------------------------------
| David de Andrés Martínez   | Fault Tolerant Systems research Group |
|                            |                                       |
| Computer Science Engineer  | Email: ddandres@disca.upv.es          |
| Doctorate Student          | Phone: +34 96 387.75.74 Ext 75774     |
|                            | Fax: +34 96 387.75.79                 |
-------Address--------------------------------------------------------
|                 DISCA-EUI                                          |
|                 Universidad Politécnica de Valencia                |
|                 Campus de Vera #14                                 |
|                 Valencia E-46021                                   |
|                 Spain                                              |
----------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
