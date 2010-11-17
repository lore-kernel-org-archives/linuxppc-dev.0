Return-Path: <sam@ravnborg.org>
Date: Wed, 17 Nov 2010 21:24:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] of: Add support for linking device tree blobs into
	vmlinux
Message-ID: <20101117202434.GA20441@merkur.ravnborg.org>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
	<9129f0a21ea48fb2dcb89cea290e88f3e8c0d8a2.1289943240.git.dirk.brandewie@gmail.com>
	<20101117092751.GA19781@merkur.ravnborg.org>
	<20101117180723.GA7550@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101117180723.GA7550@angua.secretlab.ca>
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	microblaze-uclinux@itee.uq.edu.au, dirk.brandewie@gmail.com,
	arjan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > +
> > > +DTC = $(objtree)/scripts/dtc/dtc
> > > +
> > > +quiet_cmd_dtc = DTC	$@
> > Please avoid tabs in the output - all other uses spaces. (There is a tab between DTC and $@)
> > 
> > > +      cmd_dtc = $(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(src)/dts/$*.dts
> > 
> > Looks strange. How about:
> >       cmd_dtc = $(DTC) -O dtb -o $@ -b 0 $(DTS_FLAGS) $<
> > 
> > Then you avoid the hardcoded path in the rule too.
> > 
> > 
> > > +
> > > +$(obj)/%.dtb: $(src)/dts/%.dts
> > > +	$(call if_changed,dtc)
> 
> The rule should be generic (not depend on the presence of a dts
> subdirectory.  Basically, the .dtb really should be generated in the
> same directory as the .dts file.  There is no reason for this rule to
> have special behaviour.
> 
> > 
> > This snippet belong in the file that uses this.
> > This is how we do for other rules like bzip etc.
> 
> This rule is intended to be generic and usable anywhere in the tree.
I understand this.
But only few people will recognize this so they see something like this:

obj-y := foo.dtb.o

And they look for a file named foo.dtb.S or foo.dtb.c.

If we spell it out then we have a better chance to allow
people to understand the relation ships between the files.


If we really want to hide this in scipts/Makefile.* then Makefile.build
is the logical places to do so.
Makefile.lib is supposed to be stuff that is relavent for more than
one Makefile in scripts/* but it has unfortunately also grown
some of the boot support stuff.

Today there is a single rule related to _shipped files.
We should not fill it up with additional rules - put them
Makefile.build if we really want to avoid them in boot/Makefile.

	Sam
