Return-Path: <muvarov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id AFFCFDDDEE
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 19:43:17 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1364549fga.39
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Nov 2008 01:43:15 -0700 (PDT)
Message-ID: <572af9170811010143v37826aa2y3200eb6815aba966@mail.gmail.com>
Date: Sat, 1 Nov 2008 11:43:15 +0300
From: "Maxim Uvarov" <muvarov@gmail.com>
To: "Simon Horman" <horms@verge.net.au>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
In-Reply-To: <20081101031601.GA11013@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_121548_7321380.1225528995186"
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
	<572af9170810150146p58c599fvabb41338ffd4e033@mail.gmail.com>
	<20081031022902.GH27118@verge.net.au>
	<572af9170810302353l417781berf1da0661b37bc6db@mail.gmail.com>
	<20081101031601.GA11013@verge.net.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_121548_7321380.1225528995186
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/11/1 Simon Horman <horms@verge.net.au>

> On Fri, Oct 31, 2008 at 09:53:23AM +0300, Maxim Uvarov wrote:
> > 2008/10/31 Simon Horman <horms@verge.net.au>
> >
> > > Hi,
> > >
> > > Could someone please comment on the satus of this patch?
> > >
> > Hello,  Simon
> >
> > I can not reproduce  error which you wrote before on my target. So it is
> a
> > little bit
> > difficult to say what  was wrong exactly.
>
> Hi,
>
> the version of the patch below (which I think is the latest)
> compiles fine for me. I wanted to confirm that you
> and Chandru are happy for it to be merged.
>
> If so, could you please provide a short descripton for the change-log
> and a Signed-off-by line.

Patch looks good.

Description is:
   Do not count  max_memory_range for allocation. Increase allocation
buffers
   when it is needed. This actually allows us to avoid a lot of troubles
with
   various device-tree files.

Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>
>
>
> Thanks
>
> > > On Wed, Oct 15, 2008 at 12:46:24PM +0400, Maxim Uvarov wrote:
> > > > Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)
> > > >
> > > > I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p
> > > works.
> > > >
> > > > Maxim.
> > >
> > > > diff --git a/kexec/arch/ppc64/kexec-ppc64.c
> > > b/kexec/arch/ppc64/kexec-ppc64.c
> > > > index 069a9fc..0ad40fa 100644
> > > > --- a/kexec/arch/ppc64/kexec-ppc64.c
> > > > +++ b/kexec/arch/ppc64/kexec-ppc64.c
> > > > @@ -96,96 +96,46 @@ err1:
> > > >
> > > >  }
> > > >
> > > > -static int count_dyn_reconf_memory_ranges(void)
> > > > +static int realloc_memory_ranges()
> > > >  {
> > > > -     char device_tree[] = "/proc/device-tree/";
> > > > -     char fname[128];
> > > > -     char buf[32];
> > > > -     FILE *file;
> > > > -
> > > > -     strcpy(fname, device_tree);
> > > > -     strcat(fname,
> "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
> > > > -     if ((file = fopen(fname, "r")) == NULL) {
> > > > -             perror(fname);
> > > > -             return -1;
> > > > -     }
> > > > +     size_t memory_range_len;
> > > >
> > > > -     if (fread(buf, 1, 8, file) < 0) {
> > > > -             perror(fname);
> > > > -             fclose(file);
> > > > -             return -1;
> > > > -     }
> > > > -
> > > > -     lmb_size = ((uint64_t *)buf)[0];
> > > > -     fclose(file);
> > > > +     max_memory_ranges++;
> > > > +     memory_range_len = sizeof(struct memory_range) *
> max_memory_ranges;
> > > >
> > > > -     /* Get number of lmbs from ibm,dynamic-memory */
> > > > -     strcpy(fname, device_tree);
> > > > -     strcat(fname,
> > > "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
> > > > -     if ((file = fopen(fname, "r")) == NULL) {
> > > > -             perror(fname);
> > > > -             return -1;
> > > > -     }
> > > > -     /*
> > > > -      * first 4 bytes provide number of entries(lmbs)
> > > > -      */
> > > > -     if (fread(buf, 1, 4, file) < 0) {
> > > > -             perror(fname);
> > > > -             fclose(file);
> > > > -             return -1;
> > > > -     }
> > > > -     num_of_lmbs = ((unsigned int *)buf)[0];
> > > > -     max_memory_ranges += num_of_lmbs;
> > > > -     fclose(file);
> > > > +     memory_range = (struct memory_range *) realloc(memory_range,
> > > memory_range_len);
> > > > +     if (!memory_range)
> > > > +             goto err;
> > > >
> > > > -     return 0;
> > > > -}
> > > > +     base_memory_range = (struct memory_range *)
> realloc(memory_range,
> > > memory_range_len);
> > > > +     if (!base_memory_range)
> > > > +             goto err;
> > > >
> > > > -/*
> > > > - * Count the memory nodes under /proc/device-tree and populate the
> > > > - * max_memory_ranges variable. This variable replaces
> MAX_MEMORY_RANGES
> > > > - * macro used earlier.
> > > > - */
> > > > -static int count_memory_ranges(void)
> > > > -{
> > > > -     char device_tree[256] = "/proc/device-tree/";
> > > > -     struct dirent *dentry;
> > > > -     DIR *dir;
> > > > +     exclude_range = (struct memory_range *) realloc(exclude_range,
> > > memory_range_len);
> > > > +     if (!exclude_range)
> > > > +             goto err;
> > > >
> > > > -     if ((dir = opendir(device_tree)) == NULL) {
> > > > -             perror(device_tree);
> > > > -             return -1;
> > > > -     }
> > > > +     usablemem_rgns.ranges = (struct memory_range *)
> > > > +                             realloc(usablemem_rgns.ranges,
> > > memory_range_len);
> > > > +     if (!(usablemem_rgns.ranges))
> > > > +             goto err;
> > > >
> > > > -     while ((dentry = readdir(dir)) != NULL) {
> > > > -             if (!strncmp(dentry->d_name,
> > > > -                             "ibm,dynamic-reconfiguration-memory",
> 35)){
> > > > -                     if (count_dyn_reconf_memory_ranges() != 0)
> > > > -                             return -1;
> > > > -                     continue;
> > > > -             }
> > > > +     return 0;
> > > >
> > > > -             if (strncmp(dentry->d_name, "memory@", 7) &&
> > > > -                     strcmp(dentry->d_name, "memory") &&
> > > > -                     strncmp(dentry->d_name, "pci@", 4))
> > > > -                     continue;
> > > > -             max_memory_ranges++;
> > > > -     }
> > > > -     /* need to add extra region for retained initrd */
> > > > -     if (reuse_initrd) {
> > > > -             max_memory_ranges++;
> > > > -     }
> > > > +err:
> > > > +     fprintf(stderr, "memory range structure re-allocation
> failure\n");
> > > > +     return -1;
> > > > +}
> > > >
> > > > -     closedir(dir);
> > > >
> > > > -     return 0;
> > > > -}
> > > >  static void add_base_memory_range(uint64_t start, uint64_t end)
> > > >  {
> > > >       base_memory_range[nr_memory_ranges].start = start;
> > > >       base_memory_range[nr_memory_ranges].end  = end;
> > > >       base_memory_range[nr_memory_ranges].type = RANGE_RAM;
> > > >       nr_memory_ranges++;
> > > > +     if (nr_memory_ranges >= max_memory_ranges)
> > > > +             realloc_memory_ranges();
> > > >
> > > >       dbgprintf("%016llx-%016llx : %x\n",
> > > >               base_memory_range[nr_memory_ranges-1].start,
> > > > @@ -300,8 +250,8 @@ static int get_base_ranges(void)
> > > >                               return -1;
> > > >                       }
> > > >                       if (nr_memory_ranges >= max_memory_ranges) {
> > > > -                             fclose(file);
> > > > -                             break;
> > > > +                             if (realloc_memory_ranges() < 0)
> > > > +                                     break;
> > > >                       }
> > > >                       start = ((uint64_t *)buf)[0];
> > > >                       end = start + ((uint64_t *)buf)[1];
> > > > @@ -396,6 +346,8 @@ static int get_devtree_details(unsigned long
> > > kexec_flags)
> > > >                       exclude_range[i].start = 0x0UL;
> > > >                       exclude_range[i].end = kernel_end;
> > > >                       i++;
> > > > +                     if (i >= max_memory_ranges)
> > > > +                             realloc_memory_ranges();
> > > >
> > > >                       if (kexec_flags & KEXEC_ON_CRASH) {
> > > >                               memset(fname, 0, sizeof(fname));
> > > > @@ -470,6 +422,8 @@ static int get_devtree_details(unsigned long
> > > kexec_flags)
> > > >                       exclude_range[i].start = htab_base;
> > > >                       exclude_range[i].end = htab_base + htab_size;
> > > >                       i++;
> > > > +                     if (i >= max_memory_ranges)
> > > > +                             realloc_memory_ranges();
> > > >
> > > >                       /* reserve the initrd_start and end locations.
> */
> > > >                       if (reuse_initrd) {
> > > > @@ -545,6 +499,8 @@ static int get_devtree_details(unsigned long
> > > kexec_flags)
> > > >                       exclude_range[i].start = rtas_base;
> > > >                       exclude_range[i].end = rtas_base + rtas_size;
> > > >                       i++;
> > > > +                     if (i >= max_memory_ranges)
> > > > +                             realloc_memory_ranges();
> > > >                       if (kexec_flags & KEXEC_ON_CRASH)
> > > >                               add_usable_mem_rgns(rtas_base,
> rtas_size);
> > > >               } /* rtas */
> > > > @@ -740,9 +696,10 @@ out:
> > > >  /* Return a list of valid memory ranges */
> > > >  int get_memory_ranges(struct memory_range **range, int *ranges,
> > > >                       unsigned long kexec_flags)
> > > > -{
> > > > -     if (count_memory_ranges())
> > > > -             return -1;
> > > > +{
> > > > +        /* allocate memory_range dynamically */
> > > > +        max_memory_ranges = 1;
> > > > +
> > > >       if (alloc_memory_ranges())
> > > >               return -1;
> > > >       if (setup_memory_ranges(kexec_flags))
> > >
> > >
> > > --
> > > Simon Horman
> > >  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
> > >  H: www.vergenet.net/~horms/ <http://www.vergenet.net/%7Ehorms/> <
> http://www.vergenet.net/%7Ehorms/>
> > >   W: www.valinux.co.jp/en
> > >
> > >
> >
> >
> > --
> > Best regards,
> > Maxim Uvarov
>
> --
> Simon Horman
>  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
>  H: www.vergenet.net/~horms/ <http://www.vergenet.net/%7Ehorms/>
>   W: www.valinux.co.jp/en
>
>


-- 
Best regards,
Maxim Uvarov

------=_Part_121548_7321380.1225528995186
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/11/1 Simon Horman <span dir="ltr">&lt;<a href="mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Fri, Oct 31, 2008 at 09:53:23AM +0300, Maxim Uvarov wrote:<br>
&gt; 2008/10/31 Simon Horman &lt;<a href="mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;<br>
&gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; Could someone please comment on the satus of this patch?<br>
&gt; &gt;<br>
&gt; Hello, &nbsp;Simon<br>
&gt;<br>
&gt; I can not reproduce &nbsp;error which you wrote before on my target. So it is a<br>
&gt; little bit<br>
&gt; difficult to say what &nbsp;was wrong exactly.<br>
<br>
</div>Hi,<br>
<br>
the version of the patch below (which I think is the latest)<br>
compiles fine for me. I wanted to confirm that you<br>
and Chandru are happy for it to be merged.<br>
<br>
If so, could you please provide a short descripton for the change-log<br>
and a Signed-off-by line.</blockquote><div>Patch looks good.<br>&nbsp;</div>Description is:<br>
&nbsp;&nbsp; Do not count&nbsp; max_memory_range for allocation. Increase allocation buffers<br>

&nbsp;&nbsp; when it is needed. This actually allows us to avoid a lot of troubles with<br>

&nbsp;&nbsp; various device-tree files.<br>
<br>

Signed-off-by: Maxim Uvarov &lt;<a href="mailto:muvarov@gmail.com">muvarov@gmail.com</a>&gt;<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
Thanks<br>
<div class="Ih2E3d"><br>
&gt; &gt; On Wed, Oct 15, 2008 at 12:46:24PM +0400, Maxim Uvarov wrote:<br>
&gt; &gt; &gt; Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p<br>
&gt; &gt; works.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Maxim.<br>
&gt; &gt;<br>
</div><div><div></div><div class="Wj3C7c">&gt; &gt; &gt; diff --git a/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; &gt; b/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; &gt; &gt; index 069a9fc..0ad40fa 100644<br>
&gt; &gt; &gt; --- a/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; &gt; &gt; +++ b/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; &gt; &gt; @@ -96,96 +96,46 @@ err1:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &nbsp;}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -static int count_dyn_reconf_memory_ranges(void)<br>
&gt; &gt; &gt; +static int realloc_memory_ranges()<br>
&gt; &gt; &gt; &nbsp;{<br>
&gt; &gt; &gt; - &nbsp; &nbsp; char device_tree[] = &quot;/proc/device-tree/&quot;;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; char fname[128];<br>
&gt; &gt; &gt; - &nbsp; &nbsp; char buf[32];<br>
&gt; &gt; &gt; - &nbsp; &nbsp; FILE *file;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; - &nbsp; &nbsp; strcpy(fname, device_tree);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; strcat(fname, &quot;ibm,dynamic-reconfiguration-memory/ibm,lmb-size&quot;);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if ((file = fopen(fname, &quot;r&quot;)) == NULL) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; + &nbsp; &nbsp; size_t memory_range_len;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if (fread(buf, 1, 8, file) &lt; 0) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fclose(file);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; - &nbsp; &nbsp; lmb_size = ((uint64_t *)buf)[0];<br>
&gt; &gt; &gt; - &nbsp; &nbsp; fclose(file);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; max_memory_ranges++;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; memory_range_len = sizeof(struct memory_range) * max_memory_ranges;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; /* Get number of lmbs from ibm,dynamic-memory */<br>
&gt; &gt; &gt; - &nbsp; &nbsp; strcpy(fname, device_tree);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; strcat(fname,<br>
&gt; &gt; &quot;ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory&quot;);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if ((file = fopen(fname, &quot;r&quot;)) == NULL) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; - &nbsp; &nbsp; /*<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp;* first 4 bytes provide number of entries(lmbs)<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp;*/<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if (fread(buf, 1, 4, file) &lt; 0) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fclose(file);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; - &nbsp; &nbsp; num_of_lmbs = ((unsigned int *)buf)[0];<br>
&gt; &gt; &gt; - &nbsp; &nbsp; max_memory_ranges += num_of_lmbs;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; fclose(file);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; memory_range = (struct memory_range *) realloc(memory_range,<br>
&gt; &gt; memory_range_len);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; if (!memory_range)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; return 0;<br>
&gt; &gt; &gt; -}<br>
&gt; &gt; &gt; + &nbsp; &nbsp; base_memory_range = (struct memory_range *) realloc(memory_range,<br>
&gt; &gt; memory_range_len);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; if (!base_memory_range)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -/*<br>
&gt; &gt; &gt; - * Count the memory nodes under /proc/device-tree and populate the<br>
&gt; &gt; &gt; - * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES<br>
&gt; &gt; &gt; - * macro used earlier.<br>
&gt; &gt; &gt; - */<br>
&gt; &gt; &gt; -static int count_memory_ranges(void)<br>
&gt; &gt; &gt; -{<br>
&gt; &gt; &gt; - &nbsp; &nbsp; char device_tree[256] = &quot;/proc/device-tree/&quot;;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; struct dirent *dentry;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; DIR *dir;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; exclude_range = (struct memory_range *) realloc(exclude_range,<br>
&gt; &gt; memory_range_len);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; if (!exclude_range)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if ((dir = opendir(device_tree)) == NULL) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(device_tree);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; + &nbsp; &nbsp; usablemem_rgns.ranges = (struct memory_range *)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc(usablemem_rgns.ranges,<br>
&gt; &gt; memory_range_len);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; if (!(usablemem_rgns.ranges))<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; while ((dentry = readdir(dir)) != NULL) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!strncmp(dentry-&gt;d_name,<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;ibm,dynamic-reconfiguration-memory&quot;, 35)){<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (count_dyn_reconf_memory_ranges() != 0)<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt; &gt; + &nbsp; &nbsp; return 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (strncmp(dentry-&gt;d_name, &quot;memory@&quot;, 7) &amp;&amp;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; strcmp(dentry-&gt;d_name, &quot;memory&quot;) &amp;&amp;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; strncmp(dentry-&gt;d_name, &quot;pci@&quot;, 4))<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; max_memory_ranges++;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; - &nbsp; &nbsp; /* need to add extra region for retained initrd */<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if (reuse_initrd) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; max_memory_ranges++;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; }<br>
&gt; &gt; &gt; +err:<br>
&gt; &gt; &gt; + &nbsp; &nbsp; fprintf(stderr, &quot;memory range structure re-allocation failure\n&quot;);<br>
&gt; &gt; &gt; + &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; closedir(dir);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - &nbsp; &nbsp; return 0;<br>
&gt; &gt; &gt; -}<br>
&gt; &gt; &gt; &nbsp;static void add_base_memory_range(uint64_t start, uint64_t end)<br>
&gt; &gt; &gt; &nbsp;{<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges].start = start;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges].end &nbsp;= end;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges].type = RANGE_RAM;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; nr_memory_ranges++;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; if (nr_memory_ranges &gt;= max_memory_ranges)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; dbgprintf(&quot;%016llx-%016llx : %x\n&quot;,<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges-1].start,<br>
&gt; &gt; &gt; @@ -300,8 +250,8 @@ static int get_base_ranges(void)<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (nr_memory_ranges &gt;= max_memory_ranges) {<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fclose(file);<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (realloc_memory_ranges() &lt; 0)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; start = ((uint64_t *)buf)[0];<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end = start + ((uint64_t *)buf)[1];<br>
&gt; &gt; &gt; @@ -396,6 +346,8 @@ static int get_devtree_details(unsigned long<br>
&gt; &gt; kexec_flags)<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].start = 0x0UL;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].end = kernel_end;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i++;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (i &gt;= max_memory_ranges)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (kexec_flags &amp; KEXEC_ON_CRASH) {<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memset(fname, 0, sizeof(fname));<br>
&gt; &gt; &gt; @@ -470,6 +422,8 @@ static int get_devtree_details(unsigned long<br>
&gt; &gt; kexec_flags)<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].start = htab_base;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].end = htab_base + htab_size;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i++;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (i &gt;= max_memory_ranges)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* reserve the initrd_start and end locations. */<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (reuse_initrd) {<br>
&gt; &gt; &gt; @@ -545,6 +499,8 @@ static int get_devtree_details(unsigned long<br>
&gt; &gt; kexec_flags)<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].start = rtas_base;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].end = rtas_base + rtas_size;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i++;<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (i &gt;= max_memory_ranges)<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (kexec_flags &amp; KEXEC_ON_CRASH)<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; add_usable_mem_rgns(rtas_base, rtas_size);<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } /* rtas */<br>
&gt; &gt; &gt; @@ -740,9 +696,10 @@ out:<br>
&gt; &gt; &gt; &nbsp;/* Return a list of valid memory ranges */<br>
&gt; &gt; &gt; &nbsp;int get_memory_ranges(struct memory_range **range, int *ranges,<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long kexec_flags)<br>
&gt; &gt; &gt; -{<br>
&gt; &gt; &gt; - &nbsp; &nbsp; if (count_memory_ranges())<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp;/* allocate memory_range dynamically */<br>
&gt; &gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp;max_memory_ranges = 1;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; if (alloc_memory_ranges())<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; if (setup_memory_ranges(kexec_flags))<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Simon Horman<br>
&gt; &gt; &nbsp;VA Linux Systems Japan K.K., Sydney, Australia Satellite Office<br>
&gt; &gt; &nbsp;H: <a href="http://www.vergenet.net/%7Ehorms/" target="_blank">www.vergenet.net/~horms/</a> &lt;<a href="http://www.vergenet.net/%7Ehorms/" target="_blank">http://www.vergenet.net/%7Ehorms/</a>&gt;<br>
&gt; &gt; &nbsp; W: <a href="http://www.valinux.co.jp/en" target="_blank">www.valinux.co.jp/en</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best regards,<br>
&gt; Maxim Uvarov<br>
<br>
</div></div>--<br>
<div><div></div><div class="Wj3C7c">Simon Horman<br>
 &nbsp;VA Linux Systems Japan K.K., Sydney, Australia Satellite Office<br>
 &nbsp;H: <a href="http://www.vergenet.net/%7Ehorms/" target="_blank">www.vergenet.net/~horms/</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; W: <a href="http://www.valinux.co.jp/en" target="_blank">www.valinux.co.jp/en</a><br>
<br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Maxim Uvarov<br>

------=_Part_121548_7321380.1225528995186--
