Message-Id: <200007081724.TAA00758@piglet.grunz.lu>
Date: Sat, 8 Jul 2000 19:24:21 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying to enable backside on a G4
To: guillaume.laures@noos.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39671310.96C22BBD@noos.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-963077065=:756"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-963077065=:756
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi all,

On   8 Jul, this message from Guillaume Laurès echoed through cyberspace:
> Michel Lanners a écrit :
>>
>> If you're working on 2.4.0-style kernels, here is a patch that
>> implements this functionality as a kernel command line option.
>
> Hum, did you forget to join the patch ???

Ooopss.. sorry about that. Wrote the mail this morning in a hurry ;-)

Attached are actually two patches: the first one fixes the output of
'cat /proc/sys/kernel/l2cr', as it contains some errors and omissions.
This part is only needed on 2.2.x and old 2.3.x kernels; it's integrated
in 2.4.0-something.

The second patch adds command line functionality for 2.3/2.4 kernels.

> And what about the l2cr=xxxxxxxx option in the next kernels, will it be re-enabled or should we
> keep on user-space ?

Keep it in userspace for now. It's better to have it in the kernel, as
the l2 cache has an influence on the bogomips calculation (at least in
2.2 kernels), hence affects the accuracy of kernel timing loops. I
haven't noticed any adverse effects, however.

I'll have to check whether all the steps I've taken to enable the cache
are actually needed, since all the invalidate stuff should be handled by
the function I'm calling. But it didn't work last I tried.... Once
that's decided, I will resubmit the command line patch.

> I followed your setup and put :
>
>         echo -n "Enabling level2 cache..."
>         echo 0 > /proc/sys/kernel/l2cr
>         echo '0x35300000' > /proc/sys/kernel/l2cr
> #disabled,no parity,1MB,+1.5 clock,pipelined burst SRAM,data only,global invalidate,ZZ
> enabled,copy-back,0.5ns hold
>         echo '0xb5100000' > /proc/sys/kernel/l2cr
> #enabled,no parity,1MB,+1.5 clock,pipelined burst SRAM,data only,ZZ enabled,copy-back,0.5ns hold

Don't take the text translation above too serious; it comes from the
partly bogus 2.2 kernel.... Other than that, as you have seen ;-), it
works.

> Since :
>  - GrabG3CacheSetting (slightly modified to accept any processor or it would complain that I
> don't have a G3...) from BenH told me that XLR8's extension sets my G4's L2CR to 0xb5100000

Yeah, could you submit that back to Ben? I've noticed that as well when
I started to play l2cr...

>  - I don't really understand what the the L2I bit stands for, is it necessary to set it on the
> second echo too as you do ?

Since you don't know what's leftover in the cache when you enable it,
you need to invalidate it first. And you need to make sure invalidation
has completed before actually turning the cache on. There's also a PLL
loop stabilizing issue, since you are setting a new value to the cache's
clocking. The steps taken are documented somehwere, I think in the
PowerPC manuals.

> So may be it's viser to do as a general rule :
>
> echo 0 > /proc/sys/kernel/l2cr # (disable)
> echo '0x00200000' > /proc/sys/kernel/l2cr # (invalidate)
        ^^^^^^^^^^
'Or' that with your requested setting, minus the enable bit, so that the
PLL for the cache's clock can stabilize.

> And kernel compilation is now at least twice as fast...

:-))

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-963077065=:756
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="l2cr-display.diff"

--- linux-2.2.15/arch/ppc/kernel/ppc_htab.c	Thu Aug 26 21:51:03 1999
+++ linux-work/arch/ppc/kernel/ppc_htab.c	Fri Aug 27 19:44:57 1999
@@ -595,19 +595,24 @@
 			if (!first)
 				*p++ = '\t';
 			val = _get_L2CR();
-			p += sprintf(p, "%08x: ", val);
-			p += sprintf(p, " %s",
-				     (val&0x80000000)?"enabled":"disabled");
-			p += sprintf(p,",%sparity",(val&0x40000000)?"":"no ");
-			p += sprintf(p, ",%s", sizestrings[(val >> 28) & 3]);
-			p += sprintf(p, ",%s", clockstrings[(val >> 25) & 7]);
-			p += sprintf(p, ",%s", typestrings[(val >> 23) & 0x2]);
-			p += sprintf(p,"%s",(val>>22)&1?"":",data only");
-			p += sprintf(p,"%s",(val>>20)&1?",ZZ enabled":"");
-			p += sprintf(p,",%s",(val>>19)&1?"write-through":"copy-back");
-			p += sprintf(p,",%sns hold", holdstrings[(val>>16)&3]);
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " %s", (val >> 31) & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
+			p += sprintf(p, ", %s", sizestrings[(val >> 28) & 3]);
+			p += sprintf(p, ", %s", clockstrings[(val >> 25) & 7]);
+			p += sprintf(p, ", %s", typestrings[(val >> 23) & 2]);
+			p += sprintf(p, "%s", (val>>22)&1 ? ", data only" : "");
+			p += sprintf(p, "%s", (val>>20)&1 ? ", ZZ enabled": "");
+			p += sprintf(p, ", %s", (val>>19)&1 ? "write-through" :
+					"copy-back");
+			p += sprintf(p, "%s", (val>>18)&1 ? ", testing" : "");
+			p += sprintf(p, ", %sns hold",holdstrings[(val>>16)&3]);
+			p += sprintf(p, "%s", (val>>15)&1 ? ", DLL slow" : "");
+			p += sprintf(p, "%s", (val>>14)&1 ? ", diff clock" :"");
+			p += sprintf(p, "%s", (val>>13)&1 ? ", DLL bypass" :"");

-			p += sprintf(p,"\n");
+			p += sprintf(p, "\n");

 			len = strlen(buf);
 			if (len > left)

--134458388-1804289383-963077065=:756
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="l2cr-cmdline.diff"

diff -uNr /mnt/r4/usr/src/linux-2.3.paul/arch/ppc/kernel/setup.c /usr/src/linux/arch/ppc/kernel/setup.c
--- /mnt/r4/usr/src/linux-2.3.paul/arch/ppc/kernel/setup.c	Fri Jun 16 13:32:29 2000
+++ /usr/src/linux/arch/ppc/kernel/setup.c	Sun Jun 25 00:15:03 2000
@@ -664,10 +664,14 @@
 	{
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
-		_set_L2CR(0);
-		_set_L2CR(val);
+		val |= 0x200000;		/* perform global invalidate */
+		_set_L2CR(0); 			/* disable cache */
+		_set_L2CR(val & ~0x80000000);	/* set cache parameters */
+		_set_L2CR(val);			/* and enable it */
 	}
 }
+
+__setup("l2cr=", ppc_setup_l2cr);

 void __init ppc_init(void)
 {

--134458388-1804289383-963077065=:756--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
