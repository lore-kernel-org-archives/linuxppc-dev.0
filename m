Message-Id: <199908271807.UAA00368@piglet.cpu.lu>
Date: Fri, 27 Aug 1999 20:07:50 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: bug in l2cr status display?
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
In-Reply-To: <37C64B33.27CD4058@agelectronics.co.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-935777270=:367"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-935777270=:367
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

On  27 Aug, this message from Adrian Cox echoed through cyberspace:
> Michel Lanners wrote:
>> It seems that the effect of the L2CR[DO] bit isn't clear.
> 
> I think I posted a patch for this a while ago, but I've sort of lost
> track. Basically, somebody in Motorola's documentation department
> couldn't tell one from zero. In normal use the bit should be clear.
> Hopefully somebody with write access will get the correct form into CVS.

Ok, so I understood it the right way.

Paul, below is a patch that fixes this, adds a few more bit
interpretations, and tries to clean up a bit the code and the display.
I've checked, even if everything is printed, we're staying within the
temp buffer ;-).

On  27 Aug, this message from Marc Dietrich echoed through cyberspace:
> I downloaded the 750 PDF Manuel and to Bit #9 (L2DO) it says:
> "L2 Data-only. Setting this bit enables data-only operation in the L2
> cache..."                                    ^^^^

Ok, found it. The above is in chapter 2; the less-verbose table in
chapter 9 has it wrong.

> So setting this bit disables instruction caching therefore it should'nt be
> set on bootup. 

Yep.

> It seems to me, that the L2CR programming is implemented but disabled in
> current kernel version. The L2CR=xxxxxxx doesn't work for me.

The coammnd-line option doesn't work; there is a function for parsing
this option, but it is never called. However, there is
/proc/sys/kernel/l2cr, which is readable _and_ writable. So
echo 0 > /proc/sys/kernel/l2cr disables the L2.

> By the way, it seems that Motola (or IBM) uses different cache chips on
> the 750 CPU - one with 0.5 and one with 1.0 ns timings. 0.5 ns are the
> common used chips while mine has a 1.0ns timing. This causes the
> PowerLogix Cache Control to crash my Mac. Has anyone expiriances on this?
> How has this been to recocnice in the kernel boot-up?

There is no way I know of for autodetecting any attribute of the L2
cache (except the size, maybe). All values have to be set based on some
non-automatic identification, i.e mostly manually.

On  27 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
> Don't forget the inverted numbering of bits usually used by Moto.

Yeah; that annoyed me as well; but it is pretty obvious if you cat
/proc/sys/kernel/l2cr.

> Also, you may want to set the invalidate bit when setting l2cr. Note also
> that the _set_l2cr routine in the kernel alrady handles some of the bits.

I learned that the lock-up way ;-) Shouldn't _set_l2cr() check whether
we're switching the cache on, and if so, do the invalidate for us?

> BTW. Paul, did you merge the latest code from PowerLogix I sent you a
> couple of weeks ago ?

2.2.12 contains a patch to this code.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-935777270=:367
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: l2cr.patch

--- linux-2.2.12/arch/ppc/kernel/ppc_htab.c	Thu Aug 26 21:51:03 1999
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

--134392852-1804289383-935777270=:367--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
