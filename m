Date: Tue, 4 Sep 2001 14:51:16 -0500 (CDT)
Message-Id: <200109041951.f84JpGA18512@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-reply-to: <15251.459.153586.712142@cargo.ozlabs.ibm.com> (message from Paul
	Mackerras on Mon, 3 Sep 2001 14:06:35 +1000 (EST))
Subject: Re: Assorted patches - number one
References: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com> <15251.459.153586.712142@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Paul Mackerras:
>
> Edward Swarthout writes:
> > +#define	SPRN_TBHI	0x3DC	/* Time Base High */
> > +#define	SPRN_TBHU	0x3CC	/* Time Base High User-mode */
> > +#define	SPRN_TBLO	0x3DD	/* Time Base Low */
> > +#define	SPRN_TBLU	0x3CD	/* Time Base Low User-mode */
>
> These are the 4xx registers, aren't they?  We had definitions in like
> this before, does anyone remember why they were removed?

Sorry, I did not intend to add these spr numbers.  They got added to
our additions-list when we diff'ed our 2.4-test11 to 2.4.9.  (The only
reference to these numbers that I could find are in the ibm 401).

> > +#define	SPRN_ICTRL 	0x3F3	/* 1011 7450 ICTRL */
> > +#define   ICTRL_EICE         (0x08000000)   /* EICE */
> > +#define   ICTRL_EDCE         (0x04000000)   /* EIDE */
> > +#define   ICTRL_EICP         (0x00000100)   /* EICP */
> > +#define	SPRN_LDSTDB	0x3F4	/* 1012 7450 LDSTDB */
>
> these comments could be more informative :)

I see you fixed them.  Thanks.

> I'll take the patch and fix the glitches but it would be good if you
> could check your next patch carefully.

Yes,  I was sloppy.  I will do better next time.

-Ed

For others,
to get the most benefit with gdb on the kernel, it needs to be
compiled with -g.  This allows the root user to peek around with
"gdb vmlinux-g /proc/kcore".  I don't know if there is a need for
this or how to make it configurable, but here is a simple patch:

-Ed

diff -rPu linuxppc_2_4_devel/Makefile cvs_linuxppc_2_4_devel/Makefile
--- linuxppc_2_4_devel/Makefile	Fri Aug 31 11:55:27 2001
+++ cvs_linuxppc_2_4_devel/Makefile	Fri Aug 31 10:47:23 2001
@@ -88,7 +88,7 @@
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)

 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  -fomit-frame-pointer -fno-strict-aliasing -fno-common
+	  -fomit-frame-pointer -fno-strict-aliasing -fno-common -g
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)

 #
@@ -255,8 +255,9 @@
 		$(NETWORKS) \
 		$(LIBS) \
 		--end-group \
-		-o vmlinux
-	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+		-o vmlinux-g
+	$(NM) vmlinux-g | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+	strip --strip-debug vmlinux-g -o vmlinux

 symlinks:
 	rm -f include/asm


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
