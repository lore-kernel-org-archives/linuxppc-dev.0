Message-ID: <3B8D49E2.47EB3421@acm.org>
Date: Wed, 29 Aug 2001 13:00:34 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Michael Washburn <mwashbur@stny.rr.com>,
	linxuppc-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Building, Installing and Running Samba on Walnut (405gp)
References: <003f01c13088$ccd23be0$94438209@endicott.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------4A15752C677CBA724E91ED25"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------4A15752C677CBA724E91ED25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Michael Washburn wrote:
>
> I have HHL2.0 installed on a Redhat 6.2 host and need to get Samba running
> for a IBM PPC405GP (Walnut) System. Is there a good source of information
> available on how to go about doing this? Does someone have a configuration
> file that sets up for this environment?
>
> I've looked through the man pages and How-To's for Samba and can't seem to
> find this information. At the moment, I've got the samba sources installed
> at /opt/hardhat/devkit/lsp/ibm-walnut/samba-2.2.1a directory.
>


Included is a file I wrote to make sure I could duplicate the build
again.  Although it does not go into installing.  I don't know how to
build rpm's or anything fancy I just know Makefiles and get things going
that way.

Not included in the directions are that for this or MySQL, can't
remember which, I had to build for x86 and then copy some "helper"
programs over which generated files during the build.  If you get
something like "can't execute blah" I would try this.

BTW I never did get MySQL to compile for the walnut is there anyone out
there who has?  So right back at you!  ;-)

Another question: Do most people build on the walnut or their custom
board?  I have not done this at all yet.

Hope this helps,
Ira Weiny
iweiny@acm.org
--------------4A15752C677CBA724E91ED25
Content-Type: text/plain; charset=us-ascii;
 name="building-samba"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="building-samba"

DHT instructions on building Samba for the walnut platform.

Samba uses the autoconf set of tools.  However, we must specify the
cross-compiler and the PPC processor to configure such that it will
cross-compile.  This is a bit tricker since Samba uses more advanced features
of the autoconf tools.

1) start a clean shell.  (make sure it does not have LD_LIBRARY_PATH or other
   shell variables which might affect the build)
2) Unpack the samba tarball if necessary.
3) move the directory it created to xxx-walnut.  This will aid in the
   integration of this to the build hierarchy.
   (for example: mv samba-version samba-version-walnut)
4) run the configure command with cross-compiling options

   $ ./configure --target=ppc \
       --includedir=/opt/hardhat/devkit/ppc/4xx/powerpc-hardhat-linux/include

   4a) The include directory above can of course be altered to point to the
       headers for the walnut platform, wherever they may reside.

5) cd to the "source" directory
6) alter the Makefile to use ppc_4xx-gcc in the Monta Vista directories
   6a) find the line "CC = gcc"
   6b) change it to "CC = /opt/hardhat/devkit/ppc/4xx/bin/ppc_4xx-gcc"
   6c) (optional) alter the CFLAGS to do better optimization

7) type "make" in the source subdir


The trouble I had with Samba was I tried to configure it for a cross compile
with the configure script.  This worked ok except that the configure scripts
build test programs and run them on your machine to see how things work.  When
I specified the cross compile, many options were set to "cross".  Especially
damaging where the sizeof() long, int, short, etc, which were left undefined in
the resulting configuration.  It would probably be better to allow the cross
configure to occur and then fill in these values.  However, Samba seems to be
one of the more stable things we have right now (Thu Jul 26 10:17:30 PDT 2001)
so I will leave it at that...  ;-)




--------------4A15752C677CBA724E91ED25--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
