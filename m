Message-ID: <38BB28DD.BE1E320E@chpc.utah.edu>
Date: Mon, 28 Feb 2000 19:03:09 -0700
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem building 2.3.47: no macintosh.a file
References: <38BB1E89.35A75737@chpc.utah.edu>
Content-Type: multipart/mixed;
 boundary="------------188B1D7B74D9FB4AA2DCF2E5"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------188B1D7B74D9FB4AA2DCF2E5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Lou Langholtz wrote:

> When trying to compile the 2.3.47 linux distribution from a kernel.org
> mirror, I don't get a macintosh.a file built in my drivers/macintosh/
> directory. As a matter of fact, I don't seem to get any macintosh
> drivers built in that directory as there's no .o files at all. Anyone
> else experience this? I've tried poking around to discover where the
> error could be but so far I'm clueless about this. Am I doing something
> wrong with my .config configuration info? I've attached my .config file
> in case this could be it and someone could check it. Any other
> possibilities?

Aha! I found I needed to change (fix?) drivers/Makefile to essentially add in
the macintosh subdirectory like for CONFIG_MAC but for CONFIG_PPC. I've
attached this context diff.

> BTW: I did have to make some minor changes to get even so far as to try
> linking it all together. I've attached the context diff of my mem.c file
> which I had to change to get it to compile. Could my simple change be
> the right thing to have done for the mem.c file???

Now the linker gets the macintosh.a stuff but spews out about some undefined
references and fails. I suspect I may be able to fix this by changing my
configuration. If anybody knows better, please let me know too. The actual
undefined references are to: find_via_pmu, pmu_poll, backlight_level,
pmu_set_brightness, and vgacon_remap_base.

Advanced thanks ;-)




--------------188B1D7B74D9FB4AA2DCF2E5
Content-Type: text/plain; charset=us-ascii;
 name="cdiff"
Content-Disposition: inline;
 filename="cdiff"
Content-Transfer-Encoding: 7bit

*** drivers/Makefile.orig	Thu Feb 17 10:57:13 2000
--- drivers/Makefile	Mon Feb 28 18:45:54 2000
***************
*** 52,57 ****
--- 52,62 ----
  MOD_SUB_DIRS += video
  endif

+ ifdef CONFIG_PPC
+ SUB_DIRS += macintosh
+ MOD_SUB_DIRS += macintosh
+ endif
+
  ifdef CONFIG_MAC
  SUB_DIRS += macintosh
  MOD_SUB_DIRS += macintosh

--------------188B1D7B74D9FB4AA2DCF2E5--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
