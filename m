Message-ID: <3E24A188.6050802@mvista.com>
Date: Tue, 14 Jan 2003 16:47:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch moving latest linux-galileo common & ev64260 code to 2_4_devel
References: <3E088CAD.2030102@mvista.com> <3E08A93E.8000409@mvista.com> <20030114163239.GD791@opus.bloom.county>
In-Reply-To: <20030114163239.GD791@opus.bloom.county>
Content-Type: multipart/mixed;
 boundary="------------060909050401020904010806"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060909050401020904010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tom Rini wrote:

>I've applied all of this, in the interest of getting things back into
>sync.
>
Thanks.

>What I want to know 'tho, is why is there still the 'reg base' being
>either here or there.  How hard would it be to always have it at the
>'other' location?  Or, was it decided that it was best to allow this to
>end up anywhere?
>
There wasn't a decision per se but there were 2 versions of DINK and
different versions of PPCBoot that left the bridge at different
locations  so I made the "incoming" base address configurable to
anywhere (but with different default for PPCBoot vs. something else).
Also, people wanted the base moved to different locations for the kernel
so I made the "outgoing" base address configurable as well.

Note: The linuxppc bootwrapper is what takes the "incoming" base address
& moves it to the specified "outgoing" base address.

I sort of like having that flexibility but then I seem to like config
options more than others here so...  I can get rid of the different
defaults and have included a patch to do so.  Is that enough?

>Also, I would really like to see the if/else of PPCBoot go away in favor
>of something like parsing PPCBoot, if it exists, and if not setting up
>things the 'other' way.  ie:
>platform_init(...) {
>  if (r3 == ppcboot)
>    parse_ppcboot()
>  else
>    find_things_out()
>  ...
>}
>
>find_things_out() {
>  bd_t.memsize = gt64260_find_end_of_memory();
>  ...
>}
>
>IOW, if we don't have PPCBoot and it's 'bd_t', fill it out.[1]
>
I suppose but there is code that can be ifdef'd out which makes the
executable smaller.  Isn't it worth keeping them for that reason?

>
>[1] And of course this brings us to bi_recs, which is another
>flamewar^H^H^H^H^H^H^H^Hdiscussion.
>
I've totally punted on this for the same reason...

Mark

--------------060909050401020904010806
Content-Type: text/plain;
 name="cfg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cfg.diff"

===== arch/ppc/config.in 1.163 vs edited =====
--- 1.163/arch/ppc/config.in	Tue Jan 14 09:08:28 2003
+++ edited/arch/ppc/config.in	Tue Jan 14 16:08:59 2003
@@ -176,31 +176,27 @@
 fi

 if [ "$CONFIG_GT64260" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Marvell/Galileo GT64260 Options'
+  mainmenu_option next_comment
+  comment 'Marvell/Galileo GT64260 Options'

-   dep_bool 'PCI Bus 0 Snooping Disable (experimental)' \
-     CONFIG_GT64260_BUS_0_NOT_COHERENT $CONFIG_EXPERIMENTAL
-   dep_bool 'PCI Bus 1 Snooping Disable (experimental)' \
-     CONFIG_GT64260_BUS_1_NOT_COHERENT $CONFIG_EXPERIMENTAL
+  dep_bool 'PCI Bus 0 Snooping Disable (experimental)' \
+    CONFIG_GT64260_BUS_0_NOT_COHERENT $CONFIG_EXPERIMENTAL
+  dep_bool 'PCI Bus 1 Snooping Disable (experimental)' \
+    CONFIG_GT64260_BUS_1_NOT_COHERENT $CONFIG_EXPERIMENTAL

-   if [ "$CONFIG_GT64260_BUS_0_NOT_COHERENT" = "y" \
-     -o "$CONFIG_GT64260_BUS_1_NOT_COHERENT" = "y" ]; then
-       define_bool CONFIG_NOT_COHERENT_CACHE y
-   fi
+  if [ "$CONFIG_GT64260_BUS_0_NOT_COHERENT" = "y" \
+	-o "$CONFIG_GT64260_BUS_1_NOT_COHERENT" = "y" ]; then
+    define_bool CONFIG_NOT_COHERENT_CACHE y
+  fi

-   bool 'Board uses PPCBoot' CONFIG_USE_PPCBOOT
-   if [ "$CONFIG_USE_PPCBOOT" = "y" ]; then
-       hex 'Base Address assigned by Firmware' CONFIG_GT64260_ORIG_REG_BASE 0xf8000000
-   else
-       hex 'Base Address assigned by Firmware' CONFIG_GT64260_ORIG_REG_BASE 0x14000000
+  bool 'Board uses PPCBoot' CONFIG_USE_PPCBOOT
+  hex 'Base Address assigned by Firmware' CONFIG_GT64260_ORIG_REG_BASE 0x14000000

-       bool 'Change Base Address in Bootloader' CONFIG_GT64260_NEW_BASE
-       if [ "$CONFIG_GT64260_NEW_BASE" = "y" ]; then
-	 hex 'New Base Address' CONFIG_GT64260_NEW_REG_BASE 0x14000000
-       fi
-   fi
-   endmenu
+  bool 'Change Base Address in Linux/PPC Bootwrapper' CONFIG_GT64260_NEW_BASE
+  if [ "$CONFIG_GT64260_NEW_BASE" = "y" ]; then
+    hex 'New Base Address' CONFIG_GT64260_NEW_REG_BASE 0x14000000
+  fi
+  endmenu
 fi

 if [ "$CONFIG_FORCE" = "y" -o "$CONFIG_MENF1" = "y" \

--------------060909050401020904010806--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
