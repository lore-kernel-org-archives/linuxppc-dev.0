Date: Wed, 20 Sep 2000 21:15:27 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Tom Rini <trini@kernel.crashing.org>
cc: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: CPU Temperature Patch
In-Reply-To: <20000920110436.C15401@opus.bloom.county>
Message-ID: <Pine.LNX.4.10.10009202113230.7561-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > +       /* this set for 500 MHz Pismo - how do we get access to clock?? */
> >
> > There is, in the same file, around line 319 code to read the clock speed from
> > the device tree. However, is it really necessary to include the clock speed at
> > this point? What is the drawback if we just assume 500 MHz (or even the max
> > value) for every G3 based machine?
>
> Why assume when we can do it properly?  Besides, a friend of mine oc'ed his
> B&W to 550, so it's possible to have >500Mhz :)

Like this?

--- arch/ppc/kernel/setup.c.org	Wed Sep 20 20:25:53 2000
+++ arch/ppc/kernel/setup.c	Wed Sep 20 20:31:26 2000
@@ -197,6 +197,7 @@
 	unsigned int thresd;
 	unsigned int threst;
 	unsigned int i;
+	unsigned int cpu_freq;

 	othrm1 = _get_THRM1();
 	othrm2 = _get_THRM2();
@@ -208,9 +209,23 @@
 	/* we need 20us to do the compare - assume 300MHz processor clock */
 	/* max value for sitv is 0x3fff - or 16383 */
 	/* this set for 500 MHz Pismo - how do we get access to clock?? */
+
+	cpu_freq = 500;
+	if ( have_of )
+	{
+		struct device_node *cpu_node;
+		int *fp;
+
+		cpu_node = find_type_devices("cpu");
+		if ( cpu_node ) {
+			fp = (int *) get_property(cpu_node, "clock-frequency", NULL);
+			if ( fp ) cpu_freq = *fp / 1000000;
+		}
+	}
+
 	/* 25 usec conversion time - max for 500 Mhz is approx. 32 usec */
 	_set_THRM3(0);
-	_set_THRM3(THRM3_E | THRM3_SITV(500*25) );
+	_set_THRM3(THRM3_E | THRM3_SITV(cpu_freq*25) );

 	thresd = 1 << 6;
 	threst = thresd;

Only tested on my Lombard ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
