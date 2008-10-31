Return-Path: <muvarov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 2C2E4DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 17:53:26 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so864171fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 23:53:24 -0700 (PDT)
Message-ID: <572af9170810302353l417781berf1da0661b37bc6db@mail.gmail.com>
Date: Fri, 31 Oct 2008 09:53:23 +0300
From: "Maxim Uvarov" <muvarov@gmail.com>
To: "Simon Horman" <horms@verge.net.au>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
In-Reply-To: <20081031022902.GH27118@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_103301_19846870.1225436003819"
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
	<572af9170810150146p58c599fvabb41338ffd4e033@mail.gmail.com>
	<20081031022902.GH27118@verge.net.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_103301_19846870.1225436003819
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/10/31 Simon Horman <horms@verge.net.au>

> Hi,
>
> Could someone please comment on the satus of this patch?
>
Hello,  Simon

I can not reproduce  error which you wrote before on my target. So it is a
little bit
difficult to say what  was wrong exactly.

>
> On Wed, Oct 15, 2008 at 12:46:24PM +0400, Maxim Uvarov wrote:
> > Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)
> >
> > I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p
> works.
> >
> > Maxim.
> >
> >
> >
> > 2008/10/15 Simon Horman <horms@verge.net.au>
> >
> > > On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:
> > > > Hello all,
> > > >
> > > > As you all know it is not easy to count exact value of memory ranges
> from
> > > > device tree on powerpc.
> > > > It very depends on how dts file was written. What do you think about
> > > really
> > > > dynamic allocation buffers
> > > > for this buffers?
> > >
> > > Conceptually I have no objections to the change,
> > > though I would like to get some review from ppc people.
> > > (linuxppc-dev@ozlabs.org CCed)
> > >
> > > > Patch is attached.
> > >
> > > This patch doesn't seem to compile for me.
> > >
> > > # powerpc64-unknown-linux-gnu-gcc --version
> > > powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1
> > > Copyright (C) 2006 Free Software Foundation, Inc.
> > > This is free software; see the source for copying conditions.  There is
> NO
> > > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> > >
> > > #make
> > > [snip]
> > > kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn't
> a
> > > prototype
> > > kexec/arch/ppc64/kexec-ppc64.c: In function 'realloc_memory_ranges':
> > > kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of
> > > 'realloc' makes pointer from integer without a cast
> > > kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to
> function
> > > 'realloc'
> > > kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable 'tmp'
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
> > diff --git a/kexec/arch/ppc64/kexec-ppc64.c
> b/kexec/arch/ppc64/kexec-ppc64.c
> > index 069a9fc..0ad40fa 100644
> > --- a/kexec/arch/ppc64/kexec-ppc64.c
> > +++ b/kexec/arch/ppc64/kexec-ppc64.c
> > @@ -96,96 +96,46 @@ err1:
> >
> >  }
> >
> > -static int count_dyn_reconf_memory_ranges(void)
> > +static int realloc_memory_ranges()
> >  {
> > -     char device_tree[] = "/proc/device-tree/";
> > -     char fname[128];
> > -     char buf[32];
> > -     FILE *file;
> > -
> > -     strcpy(fname, device_tree);
> > -     strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
> > -     if ((file = fopen(fname, "r")) == NULL) {
> > -             perror(fname);
> > -             return -1;
> > -     }
> > +     size_t memory_range_len;
> >
> > -     if (fread(buf, 1, 8, file) < 0) {
> > -             perror(fname);
> > -             fclose(file);
> > -             return -1;
> > -     }
> > -
> > -     lmb_size = ((uint64_t *)buf)[0];
> > -     fclose(file);
> > +     max_memory_ranges++;
> > +     memory_range_len = sizeof(struct memory_range) * max_memory_ranges;
> >
> > -     /* Get number of lmbs from ibm,dynamic-memory */
> > -     strcpy(fname, device_tree);
> > -     strcat(fname,
> "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
> > -     if ((file = fopen(fname, "r")) == NULL) {
> > -             perror(fname);
> > -             return -1;
> > -     }
> > -     /*
> > -      * first 4 bytes provide number of entries(lmbs)
> > -      */
> > -     if (fread(buf, 1, 4, file) < 0) {
> > -             perror(fname);
> > -             fclose(file);
> > -             return -1;
> > -     }
> > -     num_of_lmbs = ((unsigned int *)buf)[0];
> > -     max_memory_ranges += num_of_lmbs;
> > -     fclose(file);
> > +     memory_range = (struct memory_range *) realloc(memory_range,
> memory_range_len);
> > +     if (!memory_range)
> > +             goto err;
> >
> > -     return 0;
> > -}
> > +     base_memory_range = (struct memory_range *) realloc(memory_range,
> memory_range_len);
> > +     if (!base_memory_range)
> > +             goto err;
> >
> > -/*
> > - * Count the memory nodes under /proc/device-tree and populate the
> > - * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
> > - * macro used earlier.
> > - */
> > -static int count_memory_ranges(void)
> > -{
> > -     char device_tree[256] = "/proc/device-tree/";
> > -     struct dirent *dentry;
> > -     DIR *dir;
> > +     exclude_range = (struct memory_range *) realloc(exclude_range,
> memory_range_len);
> > +     if (!exclude_range)
> > +             goto err;
> >
> > -     if ((dir = opendir(device_tree)) == NULL) {
> > -             perror(device_tree);
> > -             return -1;
> > -     }
> > +     usablemem_rgns.ranges = (struct memory_range *)
> > +                             realloc(usablemem_rgns.ranges,
> memory_range_len);
> > +     if (!(usablemem_rgns.ranges))
> > +             goto err;
> >
> > -     while ((dentry = readdir(dir)) != NULL) {
> > -             if (!strncmp(dentry->d_name,
> > -                             "ibm,dynamic-reconfiguration-memory", 35)){
> > -                     if (count_dyn_reconf_memory_ranges() != 0)
> > -                             return -1;
> > -                     continue;
> > -             }
> > +     return 0;
> >
> > -             if (strncmp(dentry->d_name, "memory@", 7) &&
> > -                     strcmp(dentry->d_name, "memory") &&
> > -                     strncmp(dentry->d_name, "pci@", 4))
> > -                     continue;
> > -             max_memory_ranges++;
> > -     }
> > -     /* need to add extra region for retained initrd */
> > -     if (reuse_initrd) {
> > -             max_memory_ranges++;
> > -     }
> > +err:
> > +     fprintf(stderr, "memory range structure re-allocation failure\n");
> > +     return -1;
> > +}
> >
> > -     closedir(dir);
> >
> > -     return 0;
> > -}
> >  static void add_base_memory_range(uint64_t start, uint64_t end)
> >  {
> >       base_memory_range[nr_memory_ranges].start = start;
> >       base_memory_range[nr_memory_ranges].end  = end;
> >       base_memory_range[nr_memory_ranges].type = RANGE_RAM;
> >       nr_memory_ranges++;
> > +     if (nr_memory_ranges >= max_memory_ranges)
> > +             realloc_memory_ranges();
> >
> >       dbgprintf("%016llx-%016llx : %x\n",
> >               base_memory_range[nr_memory_ranges-1].start,
> > @@ -300,8 +250,8 @@ static int get_base_ranges(void)
> >                               return -1;
> >                       }
> >                       if (nr_memory_ranges >= max_memory_ranges) {
> > -                             fclose(file);
> > -                             break;
> > +                             if (realloc_memory_ranges() < 0)
> > +                                     break;
> >                       }
> >                       start = ((uint64_t *)buf)[0];
> >                       end = start + ((uint64_t *)buf)[1];
> > @@ -396,6 +346,8 @@ static int get_devtree_details(unsigned long
> kexec_flags)
> >                       exclude_range[i].start = 0x0UL;
> >                       exclude_range[i].end = kernel_end;
> >                       i++;
> > +                     if (i >= max_memory_ranges)
> > +                             realloc_memory_ranges();
> >
> >                       if (kexec_flags & KEXEC_ON_CRASH) {
> >                               memset(fname, 0, sizeof(fname));
> > @@ -470,6 +422,8 @@ static int get_devtree_details(unsigned long
> kexec_flags)
> >                       exclude_range[i].start = htab_base;
> >                       exclude_range[i].end = htab_base + htab_size;
> >                       i++;
> > +                     if (i >= max_memory_ranges)
> > +                             realloc_memory_ranges();
> >
> >                       /* reserve the initrd_start and end locations. */
> >                       if (reuse_initrd) {
> > @@ -545,6 +499,8 @@ static int get_devtree_details(unsigned long
> kexec_flags)
> >                       exclude_range[i].start = rtas_base;
> >                       exclude_range[i].end = rtas_base + rtas_size;
> >                       i++;
> > +                     if (i >= max_memory_ranges)
> > +                             realloc_memory_ranges();
> >                       if (kexec_flags & KEXEC_ON_CRASH)
> >                               add_usable_mem_rgns(rtas_base, rtas_size);
> >               } /* rtas */
> > @@ -740,9 +696,10 @@ out:
> >  /* Return a list of valid memory ranges */
> >  int get_memory_ranges(struct memory_range **range, int *ranges,
> >                       unsigned long kexec_flags)
> > -{
> > -     if (count_memory_ranges())
> > -             return -1;
> > +{
> > +        /* allocate memory_range dynamically */
> > +        max_memory_ranges = 1;
> > +
> >       if (alloc_memory_ranges())
> >               return -1;
> >       if (setup_memory_ranges(kexec_flags))
>
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

------=_Part_103301_19846870.1225436003819
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/10/31 Simon Horman <span dir="ltr">&lt;<a href="mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<br>
Could someone please comment on the satus of this patch?<br>
<div><div></div><div class="Wj3C7c"></div></div></blockquote><div>Hello,&nbsp; Simon<br><br>I can not reproduce&nbsp; error which you wrote before on my target. So it is a little bit<br>difficult to say what&nbsp; was wrong exactly.<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div class="Wj3C7c"><br>
On Wed, Oct 15, 2008 at 12:46:24PM +0400, Maxim Uvarov wrote:<br>
&gt; Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)<br>
&gt;<br>
&gt; I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p works.<br>
&gt;<br>
&gt; Maxim.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; 2008/10/15 Simon Horman &lt;<a href="mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;<br>
&gt;<br>
&gt; &gt; On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:<br>
&gt; &gt; &gt; Hello all,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As you all know it is not easy to count exact value of memory ranges from<br>
&gt; &gt; &gt; device tree on powerpc.<br>
&gt; &gt; &gt; It very depends on how dts file was written. What do you think about<br>
&gt; &gt; really<br>
&gt; &gt; &gt; dynamic allocation buffers<br>
&gt; &gt; &gt; for this buffers?<br>
&gt; &gt;<br>
&gt; &gt; Conceptually I have no objections to the change,<br>
&gt; &gt; though I would like to get some review from ppc people.<br>
&gt; &gt; (<a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a> CCed)<br>
&gt; &gt;<br>
&gt; &gt; &gt; Patch is attached.<br>
&gt; &gt;<br>
&gt; &gt; This patch doesn&#39;t seem to compile for me.<br>
&gt; &gt;<br>
&gt; &gt; # powerpc64-unknown-linux-gnu-gcc --version<br>
&gt; &gt; powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1<br>
&gt; &gt; Copyright (C) 2006 Free Software Foundation, Inc.<br>
&gt; &gt; This is free software; see the source for copying conditions. &nbsp;There is NO<br>
&gt; &gt; warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.<br>
&gt; &gt;<br>
&gt; &gt; #make<br>
&gt; &gt; [snip]<br>
&gt; &gt; kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn&#39;t a<br>
&gt; &gt; prototype<br>
&gt; &gt; kexec/arch/ppc64/kexec-ppc64.c: In function &#39;realloc_memory_ranges&#39;:<br>
&gt; &gt; kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of<br>
&gt; &gt; &#39;realloc&#39; makes pointer from integer without a cast<br>
&gt; &gt; kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to function<br>
&gt; &gt; &#39;realloc&#39;<br>
&gt; &gt; kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable &#39;tmp&#39;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Simon Horman<br>
&gt; &gt; &nbsp;VA Linux Systems Japan K.K., Sydney, Australia Satellite Office<br>
</div></div>&gt; &gt; &nbsp;H: <a href="http://www.vergenet.net/%7Ehorms/" target="_blank">www.vergenet.net/~horms/</a> &lt;<a href="http://www.vergenet.net/%7Ehorms/" target="_blank">http://www.vergenet.net/%7Ehorms/</a>&gt;<br>

<div class="Ih2E3d">&gt; &gt; &nbsp; W: <a href="http://www.valinux.co.jp/en" target="_blank">www.valinux.co.jp/en</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best regards,<br>
&gt; Maxim Uvarov<br>
<br>
</div>&gt; diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; index 069a9fc..0ad40fa 100644<br>
&gt; --- a/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; +++ b/kexec/arch/ppc64/kexec-ppc64.c<br>
&gt; @@ -96,96 +96,46 @@ err1:<br>
&gt;<br>
&gt; &nbsp;}<br>
&gt;<br>
&gt; -static int count_dyn_reconf_memory_ranges(void)<br>
&gt; +static int realloc_memory_ranges()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; &nbsp; char device_tree[] = &quot;/proc/device-tree/&quot;;<br>
&gt; - &nbsp; &nbsp; char fname[128];<br>
&gt; - &nbsp; &nbsp; char buf[32];<br>
&gt; - &nbsp; &nbsp; FILE *file;<br>
&gt; -<br>
&gt; - &nbsp; &nbsp; strcpy(fname, device_tree);<br>
&gt; - &nbsp; &nbsp; strcat(fname, &quot;ibm,dynamic-reconfiguration-memory/ibm,lmb-size&quot;);<br>
&gt; - &nbsp; &nbsp; if ((file = fopen(fname, &quot;r&quot;)) == NULL) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; size_t memory_range_len;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; if (fread(buf, 1, 8, file) &lt; 0) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fclose(file);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; -<br>
&gt; - &nbsp; &nbsp; lmb_size = ((uint64_t *)buf)[0];<br>
&gt; - &nbsp; &nbsp; fclose(file);<br>
&gt; + &nbsp; &nbsp; max_memory_ranges++;<br>
&gt; + &nbsp; &nbsp; memory_range_len = sizeof(struct memory_range) * max_memory_ranges;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; /* Get number of lmbs from ibm,dynamic-memory */<br>
&gt; - &nbsp; &nbsp; strcpy(fname, device_tree);<br>
&gt; - &nbsp; &nbsp; strcat(fname, &quot;ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory&quot;);<br>
&gt; - &nbsp; &nbsp; if ((file = fopen(fname, &quot;r&quot;)) == NULL) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; - &nbsp; &nbsp; /*<br>
&gt; - &nbsp; &nbsp; &nbsp;* first 4 bytes provide number of entries(lmbs)<br>
&gt; - &nbsp; &nbsp; &nbsp;*/<br>
&gt; - &nbsp; &nbsp; if (fread(buf, 1, 4, file) &lt; 0) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(fname);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fclose(file);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; - &nbsp; &nbsp; num_of_lmbs = ((unsigned int *)buf)[0];<br>
&gt; - &nbsp; &nbsp; max_memory_ranges += num_of_lmbs;<br>
&gt; - &nbsp; &nbsp; fclose(file);<br>
&gt; + &nbsp; &nbsp; memory_range = (struct memory_range *) realloc(memory_range, memory_range_len);<br>
&gt; + &nbsp; &nbsp; if (!memory_range)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; return 0;<br>
&gt; -}<br>
&gt; + &nbsp; &nbsp; base_memory_range = (struct memory_range *) realloc(memory_range, memory_range_len);<br>
&gt; + &nbsp; &nbsp; if (!base_memory_range)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt;<br>
&gt; -/*<br>
&gt; - * Count the memory nodes under /proc/device-tree and populate the<br>
&gt; - * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES<br>
&gt; - * macro used earlier.<br>
&gt; - */<br>
&gt; -static int count_memory_ranges(void)<br>
&gt; -{<br>
&gt; - &nbsp; &nbsp; char device_tree[256] = &quot;/proc/device-tree/&quot;;<br>
&gt; - &nbsp; &nbsp; struct dirent *dentry;<br>
&gt; - &nbsp; &nbsp; DIR *dir;<br>
&gt; + &nbsp; &nbsp; exclude_range = (struct memory_range *) realloc(exclude_range, memory_range_len);<br>
&gt; + &nbsp; &nbsp; if (!exclude_range)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; if ((dir = opendir(device_tree)) == NULL) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; perror(device_tree);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; usablemem_rgns.ranges = (struct memory_range *)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc(usablemem_rgns.ranges, memory_range_len);<br>
&gt; + &nbsp; &nbsp; if (!(usablemem_rgns.ranges))<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; while ((dentry = readdir(dir)) != NULL) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!strncmp(dentry-&gt;d_name,<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;ibm,dynamic-reconfiguration-memory&quot;, 35)){<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (count_dyn_reconf_memory_ranges() != 0)<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; return 0;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (strncmp(dentry-&gt;d_name, &quot;memory@&quot;, 7) &amp;&amp;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; strcmp(dentry-&gt;d_name, &quot;memory&quot;) &amp;&amp;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; strncmp(dentry-&gt;d_name, &quot;pci@&quot;, 4))<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; max_memory_ranges++;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; - &nbsp; &nbsp; /* need to add extra region for retained initrd */<br>
&gt; - &nbsp; &nbsp; if (reuse_initrd) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; max_memory_ranges++;<br>
&gt; - &nbsp; &nbsp; }<br>
&gt; +err:<br>
&gt; + &nbsp; &nbsp; fprintf(stderr, &quot;memory range structure re-allocation failure\n&quot;);<br>
&gt; + &nbsp; &nbsp; return -1;<br>
&gt; +}<br>
&gt;<br>
&gt; - &nbsp; &nbsp; closedir(dir);<br>
&gt;<br>
&gt; - &nbsp; &nbsp; return 0;<br>
&gt; -}<br>
&gt; &nbsp;static void add_base_memory_range(uint64_t start, uint64_t end)<br>
&gt; &nbsp;{<br>
&gt; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges].start = start;<br>
&gt; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges].end &nbsp;= end;<br>
&gt; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges].type = RANGE_RAM;<br>
&gt; &nbsp; &nbsp; &nbsp; nr_memory_ranges++;<br>
&gt; + &nbsp; &nbsp; if (nr_memory_ranges &gt;= max_memory_ranges)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; dbgprintf(&quot;%016llx-%016llx : %x\n&quot;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; base_memory_range[nr_memory_ranges-1].start,<br>
&gt; @@ -300,8 +250,8 @@ static int get_base_ranges(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (nr_memory_ranges &gt;= max_memory_ranges) {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fclose(file);<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (realloc_memory_ranges() &lt; 0)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; start = ((uint64_t *)buf)[0];<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; end = start + ((uint64_t *)buf)[1];<br>
&gt; @@ -396,6 +346,8 @@ static int get_devtree_details(unsigned long kexec_flags)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].start = 0x0UL;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].end = kernel_end;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i++;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (i &gt;= max_memory_ranges)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (kexec_flags &amp; KEXEC_ON_CRASH) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memset(fname, 0, sizeof(fname));<br>
&gt; @@ -470,6 +422,8 @@ static int get_devtree_details(unsigned long kexec_flags)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].start = htab_base;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].end = htab_base + htab_size;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i++;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (i &gt;= max_memory_ranges)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* reserve the initrd_start and end locations. */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (reuse_initrd) {<br>
&gt; @@ -545,6 +499,8 @@ static int get_devtree_details(unsigned long kexec_flags)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].start = rtas_base;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exclude_range[i].end = rtas_base + rtas_size;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i++;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (i &gt;= max_memory_ranges)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; realloc_memory_ranges();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (kexec_flags &amp; KEXEC_ON_CRASH)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; add_usable_mem_rgns(rtas_base, rtas_size);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } /* rtas */<br>
&gt; @@ -740,9 +696,10 @@ out:<br>
&gt; &nbsp;/* Return a list of valid memory ranges */<br>
&gt; &nbsp;int get_memory_ranges(struct memory_range **range, int *ranges,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long kexec_flags)<br>
&gt; -{<br>
&gt; - &nbsp; &nbsp; if (count_memory_ranges())<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;/* allocate memory_range dynamically */<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;max_memory_ranges = 1;<br>
&gt; +<br>
&gt; &nbsp; &nbsp; &nbsp; if (alloc_memory_ranges())<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &nbsp; &nbsp; &nbsp; if (setup_memory_ranges(kexec_flags))<br>
<font color="#888888"><br>
<br>
--<br>
</font><div><div></div><div class="Wj3C7c">Simon Horman<br>
 &nbsp;VA Linux Systems Japan K.K., Sydney, Australia Satellite Office<br>
 &nbsp;H: <a href="http://www.vergenet.net/%7Ehorms/" target="_blank">www.vergenet.net/~horms/</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; W: <a href="http://www.valinux.co.jp/en" target="_blank">www.valinux.co.jp/en</a><br>
<br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Maxim Uvarov<br>

------=_Part_103301_19846870.1225436003819--
