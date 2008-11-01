Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id DF640DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 14:16:04 +1100 (EST)
Date: Sat, 1 Nov 2008 14:16:03 +1100
From: Simon Horman <horms@verge.net.au>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
Message-ID: <20081101031601.GA11013@verge.net.au>
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
	<572af9170810150146p58c599fvabb41338ffd4e033@mail.gmail.com>
	<20081031022902.GH27118@verge.net.au>
	<572af9170810302353l417781berf1da0661b37bc6db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <572af9170810302353l417781berf1da0661b37bc6db@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 09:53:23AM +0300, Maxim Uvarov wrote:
> 2008/10/31 Simon Horman <horms@verge.net.au>
> 
> > Hi,
> >
> > Could someone please comment on the satus of this patch?
> >
> Hello,  Simon
> 
> I can not reproduce  error which you wrote before on my target. So it is a
> little bit
> difficult to say what  was wrong exactly.

Hi,

the version of the patch below (which I think is the latest)
compiles fine for me. I wanted to confirm that you
and Chandru are happy for it to be merged.

If so, could you please provide a short descripton for the change-log
and a Signed-off-by line.

Thanks

> > On Wed, Oct 15, 2008 at 12:46:24PM +0400, Maxim Uvarov wrote:
> > > Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)
> > >
> > > I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p
> > works.
> > >
> > > Maxim.
> >
> > > diff --git a/kexec/arch/ppc64/kexec-ppc64.c
> > b/kexec/arch/ppc64/kexec-ppc64.c
> > > index 069a9fc..0ad40fa 100644
> > > --- a/kexec/arch/ppc64/kexec-ppc64.c
> > > +++ b/kexec/arch/ppc64/kexec-ppc64.c
> > > @@ -96,96 +96,46 @@ err1:
> > >
> > >  }
> > >
> > > -static int count_dyn_reconf_memory_ranges(void)
> > > +static int realloc_memory_ranges()
> > >  {
> > > -     char device_tree[] = "/proc/device-tree/";
> > > -     char fname[128];
> > > -     char buf[32];
> > > -     FILE *file;
> > > -
> > > -     strcpy(fname, device_tree);
> > > -     strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
> > > -     if ((file = fopen(fname, "r")) == NULL) {
> > > -             perror(fname);
> > > -             return -1;
> > > -     }
> > > +     size_t memory_range_len;
> > >
> > > -     if (fread(buf, 1, 8, file) < 0) {
> > > -             perror(fname);
> > > -             fclose(file);
> > > -             return -1;
> > > -     }
> > > -
> > > -     lmb_size = ((uint64_t *)buf)[0];
> > > -     fclose(file);
> > > +     max_memory_ranges++;
> > > +     memory_range_len = sizeof(struct memory_range) * max_memory_ranges;
> > >
> > > -     /* Get number of lmbs from ibm,dynamic-memory */
> > > -     strcpy(fname, device_tree);
> > > -     strcat(fname,
> > "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
> > > -     if ((file = fopen(fname, "r")) == NULL) {
> > > -             perror(fname);
> > > -             return -1;
> > > -     }
> > > -     /*
> > > -      * first 4 bytes provide number of entries(lmbs)
> > > -      */
> > > -     if (fread(buf, 1, 4, file) < 0) {
> > > -             perror(fname);
> > > -             fclose(file);
> > > -             return -1;
> > > -     }
> > > -     num_of_lmbs = ((unsigned int *)buf)[0];
> > > -     max_memory_ranges += num_of_lmbs;
> > > -     fclose(file);
> > > +     memory_range = (struct memory_range *) realloc(memory_range,
> > memory_range_len);
> > > +     if (!memory_range)
> > > +             goto err;
> > >
> > > -     return 0;
> > > -}
> > > +     base_memory_range = (struct memory_range *) realloc(memory_range,
> > memory_range_len);
> > > +     if (!base_memory_range)
> > > +             goto err;
> > >
> > > -/*
> > > - * Count the memory nodes under /proc/device-tree and populate the
> > > - * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
> > > - * macro used earlier.
> > > - */
> > > -static int count_memory_ranges(void)
> > > -{
> > > -     char device_tree[256] = "/proc/device-tree/";
> > > -     struct dirent *dentry;
> > > -     DIR *dir;
> > > +     exclude_range = (struct memory_range *) realloc(exclude_range,
> > memory_range_len);
> > > +     if (!exclude_range)
> > > +             goto err;
> > >
> > > -     if ((dir = opendir(device_tree)) == NULL) {
> > > -             perror(device_tree);
> > > -             return -1;
> > > -     }
> > > +     usablemem_rgns.ranges = (struct memory_range *)
> > > +                             realloc(usablemem_rgns.ranges,
> > memory_range_len);
> > > +     if (!(usablemem_rgns.ranges))
> > > +             goto err;
> > >
> > > -     while ((dentry = readdir(dir)) != NULL) {
> > > -             if (!strncmp(dentry->d_name,
> > > -                             "ibm,dynamic-reconfiguration-memory", 35)){
> > > -                     if (count_dyn_reconf_memory_ranges() != 0)
> > > -                             return -1;
> > > -                     continue;
> > > -             }
> > > +     return 0;
> > >
> > > -             if (strncmp(dentry->d_name, "memory@", 7) &&
> > > -                     strcmp(dentry->d_name, "memory") &&
> > > -                     strncmp(dentry->d_name, "pci@", 4))
> > > -                     continue;
> > > -             max_memory_ranges++;
> > > -     }
> > > -     /* need to add extra region for retained initrd */
> > > -     if (reuse_initrd) {
> > > -             max_memory_ranges++;
> > > -     }
> > > +err:
> > > +     fprintf(stderr, "memory range structure re-allocation failure\n");
> > > +     return -1;
> > > +}
> > >
> > > -     closedir(dir);
> > >
> > > -     return 0;
> > > -}
> > >  static void add_base_memory_range(uint64_t start, uint64_t end)
> > >  {
> > >       base_memory_range[nr_memory_ranges].start = start;
> > >       base_memory_range[nr_memory_ranges].end  = end;
> > >       base_memory_range[nr_memory_ranges].type = RANGE_RAM;
> > >       nr_memory_ranges++;
> > > +     if (nr_memory_ranges >= max_memory_ranges)
> > > +             realloc_memory_ranges();
> > >
> > >       dbgprintf("%016llx-%016llx : %x\n",
> > >               base_memory_range[nr_memory_ranges-1].start,
> > > @@ -300,8 +250,8 @@ static int get_base_ranges(void)
> > >                               return -1;
> > >                       }
> > >                       if (nr_memory_ranges >= max_memory_ranges) {
> > > -                             fclose(file);
> > > -                             break;
> > > +                             if (realloc_memory_ranges() < 0)
> > > +                                     break;
> > >                       }
> > >                       start = ((uint64_t *)buf)[0];
> > >                       end = start + ((uint64_t *)buf)[1];
> > > @@ -396,6 +346,8 @@ static int get_devtree_details(unsigned long
> > kexec_flags)
> > >                       exclude_range[i].start = 0x0UL;
> > >                       exclude_range[i].end = kernel_end;
> > >                       i++;
> > > +                     if (i >= max_memory_ranges)
> > > +                             realloc_memory_ranges();
> > >
> > >                       if (kexec_flags & KEXEC_ON_CRASH) {
> > >                               memset(fname, 0, sizeof(fname));
> > > @@ -470,6 +422,8 @@ static int get_devtree_details(unsigned long
> > kexec_flags)
> > >                       exclude_range[i].start = htab_base;
> > >                       exclude_range[i].end = htab_base + htab_size;
> > >                       i++;
> > > +                     if (i >= max_memory_ranges)
> > > +                             realloc_memory_ranges();
> > >
> > >                       /* reserve the initrd_start and end locations. */
> > >                       if (reuse_initrd) {
> > > @@ -545,6 +499,8 @@ static int get_devtree_details(unsigned long
> > kexec_flags)
> > >                       exclude_range[i].start = rtas_base;
> > >                       exclude_range[i].end = rtas_base + rtas_size;
> > >                       i++;
> > > +                     if (i >= max_memory_ranges)
> > > +                             realloc_memory_ranges();
> > >                       if (kexec_flags & KEXEC_ON_CRASH)
> > >                               add_usable_mem_rgns(rtas_base, rtas_size);
> > >               } /* rtas */
> > > @@ -740,9 +696,10 @@ out:
> > >  /* Return a list of valid memory ranges */
> > >  int get_memory_ranges(struct memory_range **range, int *ranges,
> > >                       unsigned long kexec_flags)
> > > -{
> > > -     if (count_memory_ranges())
> > > -             return -1;
> > > +{
> > > +        /* allocate memory_range dynamically */
> > > +        max_memory_ranges = 1;
> > > +
> > >       if (alloc_memory_ranges())
> > >               return -1;
> > >       if (setup_memory_ranges(kexec_flags))
> >
> >
> > --
> > Simon Horman
> >  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
> >  H: www.vergenet.net/~horms/ <http://www.vergenet.net/%7Ehorms/>
> >   W: www.valinux.co.jp/en
> >
> >
> 
> 
> -- 
> Best regards,
> Maxim Uvarov

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
