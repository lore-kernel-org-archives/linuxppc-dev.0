From: Joe Green <jgreen@mvista.com>
To: greyham@research.canon.com.au (Graham Stoney),
        pavel_roskin@geocities.com (Pavel Roskin)
Subject: Re: Unpacking the mvista kernel RPMs
Date: Mon, 10 Apr 2000 09:18:30 -0700
Content-Type: text/plain
Cc: jason_wohlgemuth@gilbarco.com (Wohlgemuth Jason),
        linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
References: <20000410031456.0B51D3C960@elph.research.canon.com.au>
In-Reply-To: <20000410031456.0B51D3C960@elph.research.canon.com.au>
MIME-Version: 1.0
Message-Id: <00041010295400.03098@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 09 Apr 2000, Graham Stoney wrote:
> Pavel Roskin writes:
> > By the way, I found a newer kernel (March, 23) in
> > ftp://ftp.mvista.com/pub/CDK/updates/1.0/ppc_8xx/SRPMS/
>
> How does one go about unpacking one of these RPMs?
>
> I tried ftp'ing the rpm and going:
> % rpm -i hhl-kernel-2.2.13-7.src.rpm
> % rpm -bp /usr/src/redhat/SPECS/hhl-kernel-2.2.13.spec
> ...
> ccp: configs/%{_hhl_kernel_configs}: No such file or directory
> Bad exit status from /var/tmp/rpm-tmp.689 (%prep)

First of all, if you just want to build a kernel, you can use the
kernel-source RPM rather than the SRPM.  This installs a kernel source
tree that is preconfigured to use the cross-development tools.  You
only need to use the SRPM if you want to rebuild the RPMs.

For rebuilding the RPMs, you need to use the "rpmconfig" support.  I've
been meaning to write a README me about this.  We're defining our RPM
spec files in terms of macros that can be changed for different hosts
and targets, so that we can have a common source base for all.  You'll
have to bear with us a while if you want to work with this architecture
right now, because it's still developing.

To build the 2.2.13-7 kernel RPM, you need to install the
hhl-rpmconfig-0.0.2-1 RPM.  Then you need to configure RPM to include
the correct macro files.  When building on a Hard Hat Linux or Red Hat
Linux system, I do this by creating a .rpmrc file in my home directory
that contains the following:

macrofiles:  /usr/lib/rpm/macros:/opt/hardhat/config/rpm/hosts/i686-pc-linux-gnu:/opt/hardhat/config/rpm/targets/%{_target}:~/.rpmmacros

That should all be one line; not sure how it will come out in email.

The /opt/hardhat/config/rpm/hosts/i686-pc-linux-gnu macro file will
provide host-specific macros.  The
/opt/hardhat/config/rpm/targets/%{_target} specification will select a
target macro file based on the target specified when invoking rpm.  For
the 8xx target, we use the rpm option "--target ppc_8xx-hardhat-linux".

I hope this helps.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
