Date: Fri, 28 Sep 2001 21:23:57 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Vinod Kurup <vkurup@massmed.org>
Cc: <debian-powerpc@lists.debian.org>, <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: 2.4.10 Lombard IDE fix (was: Re: ide disk no longer found (rsync-benh))
In-Reply-To: <Pine.LNX.4.33.0109281954320.10557-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.33.0109282108570.13578-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 Sep 2001, Michael Schmitz wrote:

> > I'd place my bet on some voodoo in the generic IDE mess that changed.
>
> Actually I take that back. hda and hdb are probed but found not present.
> Seems ide0 doesn't get enabled properly ...

Patch to apply a quick fix for this, use at your own risk etc., don't
yell at me if it doesn't work:

--- arch/ppc/kernel/pmac_feature.c.org	Fri Sep 28 23:02:14 2001
+++ arch/ppc/kernel/pmac_feature.c	Fri Sep 28 23:01:42 2001
@@ -179,9 +179,10 @@
 	struct macio_chip*	macio;
 	unsigned long		flags;

-	macio = macio_find(node, macio_ohare);
+	macio = macio_find(node, type);
 	if (!macio)
 		return -ENODEV;
+
 	LOCK(flags);
 	if (value)
 		MACIO_BIS(reg, mask);
@@ -423,10 +424,10 @@
 {
 	switch(param) {
 	    case 0:
-		return simple_feature_tweak(node, macio_ohare,
+		return simple_feature_tweak(node, macio_unknown,
 			HEATHROW_FCR, HRW_IDE0_ENABLE, value);
 	    case 1:
-		return simple_feature_tweak(node, macio_ohare,
+		return simple_feature_tweak(node, macio_unknown,
 			HEATHROW_FCR, HRW_BAY_IDE_ENABLE, value);
 	    default:
 	    	return -ENODEV;
@@ -438,10 +439,10 @@
 {
 	switch(param) {
 	    case 0:
-		return simple_feature_tweak(node, macio_ohare,
+		return simple_feature_tweak(node, macio_unknown,
 			HEATHROW_FCR, HRW_IDE0_RESET_N, !value);
 	    case 1:
-		return simple_feature_tweak(node, macio_ohare,
+		return simple_feature_tweak(node, macio_unknown,
 			HEATHROW_FCR, HRW_IDE1_RESET_N, !value);
 	    default:
 	    	return -ENODEV;

Comments: simple_feature_tweak shouldn't ignore the type argument it got
passed. And requesting macio_unknown in the heathrow IDE functions is just
a hack really, to make macio_find not care about the particular chip
type. The Lombard would need macio_paddington, true heathrow based
machines will need macio_heathrow here.

macio_find either needs to check for compatible types, or we need to add
another set of paddington specific functions that use macio_paddington
instead of macio_ohare above (though I guess macio_ohare won't work on
heathrow either?). Kind of defeats the whole abstraction purpose.

Leave it to BenH or Paulus to find a proper fix for this. I could test
this on Lombard only, no idea what macio type the Wallstreet uses.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
