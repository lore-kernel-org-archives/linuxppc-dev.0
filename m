Message-ID: <3B850AE1.E665920F@mvista.com>
Date: Thu, 23 Aug 2001 08:53:37 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <subodh@best.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Off-topic] Installing hardhat Journeyman edition on non-redhat
 machine
References: <200108230551.WAA24572@shell9.ba.best.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:
>
> Hello,
>
> I know this is off-topic, has anybody been successful in installing the
> 8xx compiler from MontaVista hardhat CDs on a non-redhat machine?
>
> Yes I have been through the documentation and couldn't find something that
> would work. Can someone give me some clue...
>
> I installed the gcc, from i586.rpm, but it is installing the powerpc
> compiler and not the ppc cross-compiler.
>
> Any hints....
>
> /Subodh
>

I do not understand the question.

The "CD" layout of Hard Hat Linux is fairly simple:

(referencing from: ftp://ftp.mvista.com/pub/Journeyman/cd2/  and
assuming you want 8xx)

The install directory contains symbolic links for a specific board.
Lets assuming EP-RPXLite for right now.  The would be
"install/embeddedplanet-rpxlite/"

Under that directory are two sub directories "apps" and "tools".  The
items in the "apps" directory are target rpms, that are expected to be
run on the target, installed on the host in
/opt/hardhat/devkit/ppc/8xx/target.

In the "tools" directory are the host tools, cross compilers/linker, and
other tools.

Under the tools directory you will see:

hhl-cross-ppc_8xx-filesystem-2.0-hhl2.0.1.noarch.rpm@
hhl-cross-ppc_8xx-lsp-embeddedplanet-rpxlite-2.4.2_hhl20-hhl2.0.0.noarch.rpm@
hhl-cross-ppc-filesystem-2.0-hhl2.0.1.noarch.rpm@
hhl-host-filesystem-2.0-hhl2.0.2.noarch.rpm@
hhl-host-hhl_install-2.0-hhl2.0.1.noarch.rpm@
hhl-host-ldd-1.0-hhl2.0.1.noarch.rpm@
hhl-host-setperm-1.0.0-hhl2.0.1.noarch.rpm@
redhat62/
redhat70/

The cross compilers/linkers for a given host are under the
subdirectory.  In this case you want redhat62 (or 70..  if you are not
installing on redhat, I would suggest using the redhat62 since it was
linked to older libraries that seem more compatable with other systems.)

Under that directory are all of the cross compiling "tools".  Install
what you need.  They are all .i386.rpm.  (Use alien or rpm2cpio if it's
a debian system...)

.....

Now as I stated earlier these are just symbolic links in here.. if you
back up to the cd2 directory, you will see a ppc_8xx/ directory.  This
has the same structure as the install directory and is where the actual
files live.  (I would suggest you install from the symbolic links
though, as there may be conflicting files in the raw architecture
directories, so the symbolic links are there to setup a default.)

--Mark Hatle
Software Architect
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
