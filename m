Return-Path: <mgreer@mvista.com>
Date: Wed, 15 Mar 2006 18:59:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: .quad asm directive generation
Message-ID: <20060316015924.GA32493@mag.az.mvista.com>
References: <20060313212105.GA11995@mag.az.mvista.com>
	<20060314033135.GA24168@localhost.localdomain>
	<20060314235254.GA6045@mag.az.mvista.com>
	<E1FJJXV-0005Zf-7r@jdl.com>
	<20060316000059.GA29326@mag.az.mvista.com>
	<20060316004948.GA1512@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060316004948.GA1512@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 16, 2006 at 11:49:48AM +1100, David Gibson wrote:
> On Wed, Mar 15, 2006 at 05:00:59PM -0700, Mark A. Greer wrote:
> > On Tue, Mar 14, 2006 at 06:06:57PM -0600, Jon Loeliger wrote:
> > > 
> > > For 9 months nothing.  Dave abdicates his DTC maintainer role to me.
> > 
> > Jon,
> > 
> > I can't find dtc under ~dgibson on ozlabs anymore.  Do you have it
> > somewhere now?
> 
> Ah, bother.  I did arrange for one of the old addresses of the tree to
> keep working, but forgot that it wasn't the one which had been widely
> announced.  Just a minute, I'll send an announcement to the lists.

Okay, thanks guys.

Here is a patch that fixes a problem I'm having with asm output.  My
host system is a x86 box so its 32-bit, little endian.

Disclaimer: Everything below is AFAICT.

The problem is that asm_emit_cell() was swapping its asm output when
it shouldn't be (because the assembler will do the necessary swapping).
The cell values (asm_emit_cell()) are different from the data values
(asm_emit_data()) because the cell values are generated within the
program and don't get swapped like the data values read from the dts file.
They should be left as they are so that the assembler will swap them,
if necessary.  For example, when the property length field was 4,
the asm output contained ".long 0x4000000" and sent the kernel prom.c
dt parsing code into the weeds.

The dtb output is correct.

Did any of that make sense?

/me knows he's rambling...

Anyway, here is a simple patch the fixes it for me (i.e., the
cross-assembled asm output matches the dtb).

Mark
---

diff -Nurp dtc/flattree.c dtc_new/flattree.c
--- dtc/flattree.c	2006-02-24 10:57:56.000000000 -0700
+++ dtc_new/flattree.c	2006-03-15 18:02:07.000000000 -0700
@@ -121,7 +121,7 @@ static void asm_emit_cell(void *e, cell_
 {
 	FILE *f = e;
 
-	fprintf(f, "\t.long\t0x%x\n", be32_to_cpu(val));
+	fprintf(f, "\t.long\t0x%x\n", val);
 }
 
 static void asm_emit_string(void *e, char *str, int len)
