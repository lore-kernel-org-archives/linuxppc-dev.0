Date: Fri, 18 Jun 2004 14:02:50 +0200
From: Sebastian Henschel <linux@kodeaffe.de>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
Message-ID: <20040618120250.GA8657@fuchi>
References: <200406051846.50718.toojays@toojays.net> <200406102105.27654.toojays@toojays.net> <1086883926.2977.145.camel@gaston> <200406161204.30453.toojays@toojays.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
In-Reply-To: <200406161204.30453.toojays@toojays.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello john..

* John Steele Scott <toojays@toojays.net> [2004-06-16 09:24 +0200]:

> On Fri, 11 Jun 2004 01:42 am, Benjamin Herrenschmidt wrote:
> > > I have made a new patch for this, available from:
> > > http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040610.patch
> >
> > Looks good except for some coding style issues ;)
> >
> > Use spaces between } and else for example, there's also an if
> > without a space before the ( and please, name the low level asm
> > function low_* like the other ones, for consistency.
>
> A new patch which addresses these issues is at:
> http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040616.patch
>
> This is functionally identical to the previous patch.

thanks a lot for your patch, it seems to work, according to info from
cpufreqd, bogomips and /proc/cpuinfo. though i had to tweak it a little
bit for the alu powerbook g4 2nd generation 12" aka powerbook6,4:

--- arch/ppc/platforms/pmac_cpufreq.c.old	2004-06-18 12:33:37.000000000 +0200
+++ arch/ppc/platforms/pmac_cpufreq.c	2004-06-18 12:34:32.000000000 +0200
@@ -411,6 +411,7 @@ static int __init pmac_cpufreq_setup(voi

 		/*  Check for 7447A based iBook G4 */
 		if (machine_is_compatible("PowerBook6,5") ||
+		    machine_is_compatible("PowerBook6,4") ||
 		    machine_is_compatible("PowerBook5,4")) {
 			/* OF only reports the high frequency */
 			hi_freq = cur_freq;

i also added an entry in the "feature"-table for 6,4 and 5,4 (which you
might have forgotten at this place). the 5,4 is the alu powerbook g4 2nd
generation 15" which i had worked on two weeks ago (but cannot anymore).

--- arch/ppc/platforms/pmac_feature.c.orig	2004-06-18 12:28:44.000000000 +0200
+++ arch/ppc/platforms/pmac_feature.c	2004-06-18 12:32:39.000000000 +0200
@@ -2135,6 +2135,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook5,4",			"PowerBook G4 15\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
@@ -2147,6 +2151,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,4",			"PowerBook G4 12\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,5",			"iBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,

since there are several entries for PowerBook G4 12", 15" and there will
presumably be a new entry to be made for the current generation 17",
would it be sensible to differentiate the short descriptions a little
bit more? like:

"PowerBook6,4", "PowerBook G4 12\", Alu 2nd Generation"
"PowerBook5,4", "PowerBook G4 15\", Alu 2nd Generation"

i personally own a powerbook5,2 which is the first alu generation, could
that be:

"PowerBook5,2", "PowerBook G4 15\", Alu 1st Generation"

or do the titanium powerbooks g4 also come with the id 5,2?

thanks,
 sebastian
--
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
