Subject: [PATCH] add board_init() (was [PATCH] make platform_init() weak
	for 8xx)
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040719182047.GC6813@smtp.west.cox.net>
References: <1090253615.1415.24.camel@shiva.saftware.de>
	 <20040719163203.GA6813@smtp.west.cox.net>
	 <1090258468.1419.58.camel@shiva.saftware.de>
	 <20040719182047.GC6813@smtp.west.cox.net>
Content-Type: multipart/mixed; boundary="=-q+LE7BvkuaQzprBksYoY"
Message-Id: <1090591193.3939.27.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 23 Jul 2004 15:59:53 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-q+LE7BvkuaQzprBksYoY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Mo, den 19.07.2004 schrieb Tom Rini um 20:20:
> On Mon, Jul 19, 2004 at 07:34:28PM +0200, Andreas Oberritter wrote:
>
> > On Mon, 2004-07-19 at 18:32, Tom Rini wrote:
> > > Second, this takes us in the direction of 82xx.  Until the 82xx
> > > abstractions get flushed out a bit more, I remain unconvinced that
> > > they're really the right way to go (perhaps hooking the other direction
> > > would work better, e.g. platform_init() calls board_init(), with a weak
> > > version provided, and some functions forced to be provided by board.c,
> > > such as m8xx_map_io).
> >
> > I chose this way because it seemed to be a simple way to port the dbox2
> > board to 2.6 using the new device API. Is there another 8xx board which
> > uses the device API for its onboard peripherials and can be used as a
> > reference? Can I get my devices registered without modifying
> > platform_init, or shall I send a patch with the board_init() you
> > mentioned? See my board.c attached.
>
> There currently isn't a reference platform for what you speak of.  My
> preference would be to see what I described given a shot to see if it
> looks better or worse (and it better, or worse, in the flow of things).

How about this patch?

Regards,
Andreas

--=-q+LE7BvkuaQzprBksYoY
Content-Disposition: attachment; filename=board_init.diff
Content-Type: text/x-patch; name=board_init.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/23 15:54:13+02:00 obi@pegasos.saftware.de
#   add weak board_init() function which can be overridden by board support code
#
# arch/ppc/syslib/m8xx_setup.c
#   2004/07/23 15:53:53+02:00 obi@pegasos.saftware.de +6 -0
#   add weak board_init() function which can be overridden by board support code
#
diff -Nru a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c	2004-07-23 15:54:57 +02:00
+++ b/arch/ppc/syslib/m8xx_setup.c	2004-07-23 15:54:57 +02:00
@@ -61,6 +61,11 @@
 extern void m8xx_wdt_handler_install(bd_t *bp);
 extern void rpxfb_alloc_pages(void);

+void __attribute__ ((weak))
+board_init(void)
+{
+}
+
 void __init
 m8xx_setup_arch(void)
 {
@@ -103,6 +108,7 @@
 	}
 #endif
 #endif
+	board_init();
 }

 void

--=-q+LE7BvkuaQzprBksYoY--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
