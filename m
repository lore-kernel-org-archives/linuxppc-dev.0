Return-Path: <mikey@neuling.org>
To: Milton Miller <miltonm@bga.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec-tools ppc64: add --reuseinitrd option 
In-reply-to: <46b0d1603ea2ab82b37daaa1888e8793@bga.com> 
References: <12001.1176881167@neuling.org> <5129.1176956949@neuling.org>
	<46b0d1603ea2ab82b37daaa1888e8793@bga.com>
Date: Fri, 20 Apr 2007 17:23:50 +1000
Message-ID: <14852.1177053830@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org,
	Fastboot mailing list <fastboot@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <46b0d1603ea2ab82b37daaa1888e8793@bga.com> you wrote:
> 
> On Apr 18, 2007, at 11:29 PM, Michael Neuling wrote:
> 
> > Add a --reuseinitrd option so that initrds saved using the
> > retain_initrd kernel option can be reused on the kexec boot.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > Horms: This fixes comments from Milton.  Also adds sanity checks to 
> > make
> > sure the old initrd was retained, and that another initrd/ramdisk is 
> > not
> > being specified at the same time.
> >
> > fastboot is dead... love live kexec! Yay :-)
> >
> 
> > -		checkprop(fn, dt);
> > +		checkprop(fn, dt, len);
> >
> >  		/* Get the cmdline from the device-tree and modify it */
> >  		if (!strcmp(dp->d_name, "bootargs")) {
> > @@ -249,6 +263,10 @@ static void putprops(char *fn, struct di
> >  			char temp_cmdline[COMMAND_LINE_SIZE] = { "" };
> >  			char *param = NULL;
> >  			cmd_len = strlen(local_cmdline);
> > +			if (reuse_initrd &&
> > +			    (strstr((char *)dt, "retain_initrd") == NULL))
> > +				die("unrecoverable error: current boot didn't "
> > +				    "retain the initrd for reuse.\n");
> 
> Although this seems efficent to look at what was in the device tree,
> I'd prefer we actually looked at /proc/cmdline when we parse the
> arg, so that we are sure to find what the kernel is actually
> using for the command line.
> 
> Besides it will be eaiser for other archs to copy the check.

Looks like we should make it a generic option.  If we do, this should
probably be two patches.  One to introduce the option, and one for the
ppc64 specific parts.

Do any of the other architectures allow you to see where the initrd is
located for the current boot from user space?  If not, the option will
need to take two parameters saying where the retained initrd is.  This
will make the option less generic (if not, we'll need to change the
other archs to export these values to user space).

> >  	/* Add initrd entries to the second kernel */
> > -	if (initrd_base && !strcmp(basename,"/chosen/")) {
> > +	if (initrd_base && !strcmp(basename,"/chosen/") && !reuse_initrd) {
> 
> How does initrd_base get set if you disallow --initrd= ?

Oops, that's left over crud.  Thanks.

When using this option, the initrd entries get imported from the first
kernel, rather than being generated here.

> 
> >
> > @@ -148,6 +154,9 @@ int elf_ppc64_load(int argc, char **argv
> >  	else
> >  		fprintf(stdout, "Warning: append= option is not passed. Using t
he 
> > first kernel root partition\n");
> >
> > +	if (ramdisk && reuse_initrd)
> > +		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n")
;
> > +
> 
> This check is generic, not elf specific, so it should be where
> we pass the args.  Hmm, maybe this is that place and it just
> wants abstracting, I don't have the tree in front of me.

I put it here so the error's caught independent of the arg parsing
order.  Otherwise, we'd need to duplicate the check.

I think it's the right place, unless we move it to an arch generic
option. 

Mikey
